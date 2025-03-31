module memory
#(
  parameter integer AWIDTH=5, // address width
  parameter integer DWIDTH=8  // data width
 )
 (
  input  wire              clk  , // clock signal
  input  wire              wr   , // write enable signal
  input  wire              rd   , // read enable signal
  input  wire [AWIDTH-1:0] addr , // memory address
  inout  wire [DWIDTH-1:0] data   // data bus
 );
  reg [DWIDTH-1:0] array [0:2**AWIDTH-1]; // memory array
  always @(posedge clk)
    if ( wr ) array[addr] = data; // write data to memory
  assign data = rd ? array[addr] : 'bz; // read data from memory or high impedance
endmodule
