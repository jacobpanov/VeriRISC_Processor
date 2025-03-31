module counter
#(parameter integer WIDTH = 5)
 (input wire [WIDTH-1:0] cnt_in, // input count value
 	input wire enab, load, clk, rst, // control signals
 	output reg [WIDTH-1:0] cnt_out // output count value
 );
 
 reg [WIDTH-1:0] cnt_temp; // temporary count value
 
 always @*
 		if (rst) cnt_temp = 0; // reset counter to 0
 		else
 		if (load) cnt_temp = cnt_in; // load counter with input value
 		else 
 		if (enab) cnt_temp = cnt_out + 1; // increment counter
 		else
 		cnt_temp = cnt_out; // maintain current counter value
 		
 always @(posedge clk)
 		cnt_out <= cnt_temp; // update counter output on clock edge
 		
endmodule
