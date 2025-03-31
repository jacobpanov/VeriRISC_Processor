module register
#(parameter WIDTH = 8)
 (input wire [WIDTH-1:0] data_in, // input data
  input wire load, clk, rst, // control signals
  output reg [WIDTH-1:0] data_out // output data
  );
  
  // always block to handle register operations
  always @(posedge clk)
  	if (rst) data_out <= 0; // reset output to 0
  	else
  	if (load) data_out <= data_in; // load input data to output
  	else
  	data_out <= data_out; // hold current output value
  	
 endmodule
