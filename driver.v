module driver
#(parameter WIDTH = 8)
 (input wire [WIDTH-1:0] data_in, // input data
  input wire 						 data_en, // data enable signal
  output wire [WIDTH-1:0] data_out // output data
 );
 
 // assign data_out to data_in if data_en is high, otherwise high impedance
 assign data_out = data_en ? data_in : 'bz;

endmodule
