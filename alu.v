module alu
#(
  parameter WIDTH=8
 )
 (
  input  wire [      2:0] opcode    , // operation code
  input  wire [WIDTH-1:0] in_a      , // input a
  input  wire [WIDTH-1:0] in_b      , // input b
  output reg              a_is_zero , // flag to indicate if input a is zero
  output reg  [WIDTH-1:0] alu_out    // output of the alu
 );

  // define local parameters for operation codes
  localparam PASS0=0, PASS1=1, ADD=2, AND=3, XOR=4, PASSB=5, PASS6=6, PASS7=7;

  // always block to perform alu operations
  always @*
    begin
      a_is_zero = (in_a == 0); // set a_is_zero flag if in_a is zero
      if ( opcode == ADD   ) alu_out = in_a + in_b; else // perform addition
      if ( opcode == AND   ) alu_out = in_a & in_b; else // perform bitwise and
      if ( opcode == XOR   ) alu_out = in_a ^ in_b; else // perform bitwise xor
      if ( opcode == PASSB ) alu_out = in_b ; else // pass input b
                             alu_out = in_a ; // pass input a
    end

endmodule
