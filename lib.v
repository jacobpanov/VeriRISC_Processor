module priority7 ( y, a ) ;

  output reg  [2:0] y ;
  input  wire [7:1] a ;
  integer i;
  
  always @* begin
    // initialize y to 0
  	y = 0;
    // case statement to determine priority
  	case(1)
  		a[1] : y = 1;
  		a[2] : y = 2;
  		a[3] : y = 3;
  		a[4] : y = 4;
  		a[5] : y = 5;
  		a[6] : y = 6;
  		a[7] : y = 7;
  	endcase
	end

endmodule

// latch with active-high enable and active-low asynchronous reset and set
// set has priority over reset
module latchrs ( q, e, d, r, s ) ;

  output reg  q ;
  input  wire e, d, r, s ;
  
  always @*
    // if set is active, set q to 1
  	if (!s) q <= 1; 
    // if reset is active, set q to 0
  	else
    // if enable is active, set q to d
  	if (!r) q <= 0;
  	else
  	if (e) q <= d; 

endmodule

// flip-flop with active-high clock and enable and active-low asynchronous reset and set
// set has priority over reset
module dffrs ( q, c, d, e, r, s ) ;

  output reg  q ;
  input  wire c, d, e, r, s ;
  
  always @(posedge c or negedge r or negedge s)
    // if set is active, set q to 1
  	if (!s) q <= 1;
    // if reset is active, set q to 0
  	else
    // if enable is active, set q to d
  	if (!r) q <= 0;
  	else
  	if (e) q <= d;

endmodule

// bus driver
// output is high-impedance when not enabled
module drive8 ( y, a, e ) ;

  output reg  [7:0] y ;
  input  wire [7:0] a ;
  input  wire       e ;
  
  always @*
    // if enable is active, set y to a
  	if (e) y = a;
    // if enable is not active, set y to high-impedance
  	else
  	y = 'bz;

endmodule
