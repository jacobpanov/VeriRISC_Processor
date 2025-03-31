module controller
(input wire zero,
 input wire [2:0] opcode, phase,
 output reg sel, rd, ld_ir, halt, inc_pc, ld_ac, wr, ld_pc, data_e
 );
 
 // always block to control the state of the controller
 always @* begin
    // case statement to handle different phases of the controller
 		case (phase)
 			0: begin 
 				sel=1; // select instruction address to memory
 				rd=0; // disable memory output onto data bus
 				ld_ir=0; // disable load instruction register
 				halt=0; // disable halt machine
 				inc_pc=0; // disable increment program counter
 				ld_ac=0; // disable load accumulator from data bus
 				ld_pc=0; // disable load program counter
 				wr=0; // disable write data bus to memory
 				data_e=0; // disable enable accumulator output onto data bus
 			end
 			1: begin 
 				sel=1; // select instruction address to memory
 				rd=1; // enable memory output onto data bus
 				ld_ir=0; // disable load instruction register
 				halt=0; // disable halt machine
 				inc_pc=0; // disable increment program counter
 				ld_ac=0; // disable load accumulator from data bus
 				ld_pc=0; // disable load program counter
 				wr=0; // disable write data bus to memory
 				data_e=0; // disable enable accumulator output onto data bus
 			end
 			2: begin 
 				sel=1; // select instruction address to memory
 				rd=1; // enable memory output onto data bus
 				ld_ir=1; // enable load instruction register
 				halt=0; // disable halt machine
 				inc_pc=0; // disable increment program counter
 				ld_ac=0; // disable load accumulator from data bus
 				ld_pc=0; // disable load program counter
 				wr=0; // disable write data bus to memory
 				data_e=0; // disable enable accumulator output onto data bus
 			end
 			3: begin 
 				sel=1; // select instruction address to memory
 				rd=1; // enable memory output onto data bus
 				ld_ir=1; // enable load instruction register
 				halt=0; // disable halt machine
 				inc_pc=0; // disable increment program counter
 				ld_ac=0; // disable load accumulator from data bus
 				ld_pc=0; // disable load program counter
 				wr=0; // disable write data bus to memory
 				data_e=0; // disable enable accumulator output onto data bus
 			end
 			4: begin 
 				sel=0; // select instruction address to memory
 				rd=0; // disable memory output onto data bus
 				ld_ir=0; // disable load instruction register
 				halt= (opcode == 0); // halt machine if opcode is 0
 				inc_pc=1; // enable increment program counter
 				ld_ac=0; // disable load accumulator from data bus
 				ld_pc=0; // disable load program counter
 				wr=0; // disable write data bus to memory
 				data_e=0; // disable enable accumulator output onto data bus
 			end
 			5: begin 
 				sel=0; // select instruction address to memory
 				rd= (opcode == 2 || opcode == 3 || opcode == 4 || opcode == 5); // enable memory output onto data bus if opcode is 2, 3, 4, or 5
 				ld_ir=0; // disable load instruction register
 				halt=0; // disable halt machine
 				inc_pc=0; // disable increment program counter
 				ld_ac=0; // disable load accumulator from data bus
 				ld_pc=0; // disable load program counter
 				wr=0; // disable write data bus to memory
 				data_e=0; // disable enable accumulator output onto data bus
 			end
 			6: begin 
 				sel=0; // select instruction address to memory
 				rd= (opcode == 2 || opcode == 3 || opcode == 4 || opcode == 5); // enable memory output onto data bus if opcode is 2, 3, 4, or 5
 				ld_ir=0; // disable load instruction register
 				halt=0; // disable halt machine
 				inc_pc= (opcode == 1 && zero); // enable increment program counter if opcode is 1 and zero flag is set
 				ld_ac=0; // disable load accumulator from data bus
 				ld_pc= (opcode == 7); // enable load program counter if opcode is 7
 				wr=0; // disable write data bus to memory
 				data_e= (opcode == 6); // enable accumulator output onto data bus if opcode is 6
 			end
 			7: begin 
 				sel=0; // select instruction address to memory
 				rd= (opcode == 2 || opcode == 3 || opcode == 4 || opcode == 5); // enable memory output onto data bus if opcode is 2, 3, 4, or 5
 				ld_ir=0; // disable load instruction register
 				halt=0; // disable halt machine
 				inc_pc=0; // disable increment program counter
 				ld_ac= (opcode == 2 || opcode == 3 || opcode == 4 || opcode == 5); // enable load accumulator from data bus if opcode is 2, 3, 4, or 5
 				ld_pc= (opcode == 7); // enable load program counter if opcode is 7
 				wr= (opcode == 6); // enable write data bus to memory if opcode is 6
 				data_e= (opcode == 6); // enable accumulator output onto data bus if opcode is 6
 			end
 		endcase
 	end
 	
 endmodule
