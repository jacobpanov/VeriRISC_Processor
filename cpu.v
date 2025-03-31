module cpu
(
  input  wire CLK  , // clock signal
  input  wire RST  , // reset signal
  output wire HALT   // halt signal
);

  // register and wire definitions
  reg [4:0] pc;         // program counter
  reg [7:0] ac;         // accumulator
  reg [7:0] mem [0:31]; // memory

  wire [7:0] instruction = mem[pc]; // current instruction
  wire [7:5] opcode      = instruction[7:5]; // operation code
  wire [4:0] operand     = instruction[4:0]; // operand address
  wire [7:0] rvalue      = mem[operand]; // value at operand address

  // always block to handle cpu operations
  always @(posedge CLK)
    if ( RST )
      pc <= 0 ; // reset program counter
    else
      case ( opcode )
        0: begin                    pc<=pc;         end // halt
        1: begin                    pc<=pc+1+(!ac); end // skip if zero
        2: begin ac <= ac + rvalue; pc<=pc+1;       end // add
        3: begin ac <= ac & rvalue; pc<=pc+1;       end // and
        4: begin ac <= ac ^ rvalue; pc<=pc+1;       end // xor
        5: begin ac <=      rvalue; pc<=pc+1;       end // load accumulator
        6: begin mem[operand]<=ac;  pc<=pc+1;       end // store accumulator
        7: begin                    pc<=operand;    end // jump
      endcase

  assign HALT = opcode == 0; // halt if opcode is 0

endmodule
