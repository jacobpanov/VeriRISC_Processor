module rcvr
(
  input  wire      clock   , // clock signal
  input  wire      reset   , // reset signal
  input  wire      data_in , // serial data input
  input  wire      reading , // reading signal
  output reg       ready   , // ready signal
  output reg       overrun , // overrun signal
  output reg [7:0] data_out // parallel data output
);

  // for proper operation the fsm must hard-code the match
  localparam [7:0] MATCH = 8'hA5 ; // 10100101

  reg [3:0] state ; // state register

  // opportunity for gray encoding as path is mostly linear
  localparam [3:0] HEAD1=4'b0000, HEAD2=4'b0001, HEAD3=4'b0011, HEAD4=4'b0010,
                   HEAD5=4'b0110, HEAD6=4'b0111, HEAD7=4'b0101, HEAD8=4'b0100,
                   BODY1=4'b1100, BODY2=4'b1101, BODY3=4'b1111, BODY4=4'b1110,
                   BODY5=4'b1010, BODY6=4'b1011, BODY7=4'b1001, BODY8=4'b1000;

  reg [6:0] body_reg ; // body register

  // always block to handle state transitions and data processing
  always @(posedge clock)

    if (reset) begin
        // clear all control registers to inactive state (ignore data registers)
        ready <= 0;
        overrun <= 0;
        state <= HEAD1;
      end

    else begin

        // when in each state what moves fsm to what next state?
        case ( state )
        	HEAD1 : state <= (data_in) ? HEAD2 : HEAD1;
        	HEAD2 : state <= (!data_in) ? HEAD3 : HEAD2;
        	HEAD3 : state <= (data_in) ? HEAD4 : HEAD3;
        	HEAD4 : state <= (!data_in) ? HEAD5 : HEAD4;
        	HEAD5 : state <= (!data_in) ? HEAD6 : HEAD5;
        	HEAD6 : state <= (data_in) ? HEAD7 : HEAD6;
        	HEAD7 : state <= (!data_in) ? HEAD8 : HEAD7;
        	HEAD8 : state <= (data_in) ? BODY1 : HEAD8;
        	BODY1 : state <= BODY2;
        	BODY2 : state <= BODY3;
        	BODY3 : state <= BODY4;
        	BODY4 : state <= BODY5;
        	BODY5 : state <= BODY6;
        	BODY6 : state <= BODY7;
        	BODY7 : state <= BODY8;
        	BODY8 : state <= HEAD1;
        endcase
        
        // if state is body? then shift data input left into body register
        if (state == BODY1 || state == BODY2 || state == BODY3 || state == BODY4 
        || state == BODY5 || state == BODY6 || state == BODY7 || state == BODY8)
        	body_reg <= {body_reg, data_in};
        	
        // if state is body8 then copy concatenation of body register and input
        // data to output register
        if (state == BODY8) data_out <= {body_reg, data_in};
        
        // set ready signal if state is body8
        if (state == BODY8) ready <= 1;
        else 
        if (reading) ready <= 0;
        
        // if reading then clear overrun, else
        // if state is body8 and still ready then set overrun
        if (reading) overrun <= 0;
        else
        if (state == BODY8 && ready) overrun <= 1;
        
      end

endmodule
