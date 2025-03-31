module multiplexor
#(parameter integer WIDTH = 5)
 (input wire [WIDTH-1:0] in0, in1, // input signals
  input wire             sel,      // select signal
  output reg [WIDTH-1:0] mux_out   // output signal
  );
  
  // always block to select between in0 and in1 based on sel
  always @*
    if (sel)
      mux_out = in1; // select input in1
    else
      mux_out = in0; // select input in0
  		
 endmodule
