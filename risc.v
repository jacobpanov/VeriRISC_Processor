module risc
(
  input  wire clk, // clock signal
  input  wire rst, // reset signal
  output wire halt // halt signal
);

  // local parameter definitions
  localparam integer AWIDTH=5, DWIDTH=8 ;

  /////////////////////
  // CLOCK GENERATOR //
  /////////////////////

  wire [2:0] phase ;

  // instantiation of counter module for clock generation
  counter
  #(
    .WIDTH   ( 3  ) 
   )
    counter_clk
   (
    .clk     ( clk   ),
    .rst     ( rst   ),
    .load    ( 1'b0  ),
    .enab    ( !halt ),
    .cnt_in  ( 3'b0  ),
    .cnt_out ( phase ) 
   ) ;

  ////////////////
  // CONTROLLER //
  ////////////////

  wire [2:0] opcode ;

  // instantiation of controller module
  controller controller_inst
  (
    .opcode  ( opcode ), // operation code
    .phase   ( phase  ), // instruction phase
    .zero    ( zero   ), // accumulator is zero
    .sel     ( sel    ), // select instruction address to memory
    .rd      ( rd     ), // enable memory output onto data bus
    .ld_ir   ( ld_ir  ), // load instruction register
    .inc_pc  ( inc_pc ), // increment program counter
    .halt    ( halt   ), // halt machine
    .ld_pc   ( ld_pc  ), // load program counter
    .data_e  ( data_e ), // enable accumulator output onto data bus
    .ld_ac   ( ld_ac  ), // load accumulator from data bus
    .wr      ( wr     )  // write data bus to memory
  ) ;

  /////////////////////
  // PROGRAM COUNTER //
  /////////////////////

  wire [AWIDTH-1:0] ir_addr, pc_addr ;

  // instantiation of counter module for program counter
  counter
  #(
    .WIDTH   ( AWIDTH  ) 
   )
    counter_pc
   (
    .clk     ( clk     ),
    .rst     ( rst     ),
    .load    ( ld_pc   ),
    .enab    ( inc_pc  ),
    .cnt_in  ( ir_addr ),
    .cnt_out ( pc_addr ) 
   ) ;

  /////////////////////
  // ADDESS SELECTOR //
  /////////////////////

  wire [AWIDTH-1:0] addr ;

  // instantiation of multiplexor module for address selection
  multiplexor
  #(
    .WIDTH   ( AWIDTH  ) 
   )
    address_mux
   (
    .sel     ( sel     ),
    .in0     ( ir_addr ),
    .in1     ( pc_addr ),
    .mux_out ( addr    ) 
   ) ;

  /////////////////////////
  // DATA/PROGRAM MEMORY //
  /////////////////////////

  wire [DWIDTH-1:0] data ;

  // instantiation of memory module
  memory
  #(
    .AWIDTH ( AWIDTH ),
    .DWIDTH ( DWIDTH ) 
   )
    memory_inst
   (
    .clk    ( clk    ),
    .wr     ( wr     ),
    .rd     ( rd     ),
    .addr   ( addr   ),
    .data   ( data   ) 
   ) ;

  //////////////////////////
  // INSTRUCTION REGISTER //
  //////////////////////////

  // instantiation of register module for instruction register
  register
  #(
    .WIDTH    ( DWIDTH ) 
   )
    register_ir
   (
    .clk      ( clk    ),
    .rst      ( rst    ),
    .load     ( ld_ir  ),
    .data_in  ( data   ),
    .data_out ( {opcode,ir_addr} )
   ) ;

  ////////////////////////
  // ARITHMETIC & LOGIC //
  ////////////////////////

  wire [DWIDTH-1:0] acc_out, alu_out ;

  // instantiation of alu module
  alu
  #(
    .WIDTH     ( DWIDTH ) 
   )
    alu_inst
   (
    .opcode    ( opcode  ),
    .in_a      ( acc_out ),
    .in_b      ( data    ),
    .a_is_zero ( zero    ),
    .alu_out   ( alu_out ) 
   ) ;

  //////////////////////////
  // ACCUMULATOR REGISTER //
  //////////////////////////

  // instantiation of register module for accumulator register
  register
  #(
    .WIDTH    ( DWIDTH  ) 
   )
    register_ac
   (
    .clk      ( clk     ),
    .rst      ( rst     ),
    .load     ( ld_ac   ),
    .data_in  ( alu_out ),
    .data_out ( acc_out ) 
   ) ;

  //////////////////////////
  // BUS DRIVER           //
  //////////////////////////

  // instantiation of driver module
  driver
  #(
    .WIDTH    ( DWIDTH  ) 
   )
    driver_inst
   (
    .data_en  ( data_e  ),
    .data_in  ( alu_out ),
    .data_out ( data    ) 
   ) ;

endmodule
