# VeriRISC_Processor

## Overview

The **VeriRISC Processor** project is a Verilog-based implementation of a Reduced Instruction Set Computer (RISC) CPU. 

---

## Features

- Implements a basic set of RISC instructions to execute fundamental computational tasks.
- Designed as a basis for further application-specific implementations.
- Includes simulation testbenches to validate instruction execution and module interactions.
- Test cases are provided in the `/tests` directory.
- Additional CPU tests are found in the `/tests/cpu`.

---

## Project Structure

### `alu.v` - Arithmetic Logic Unit  
Handles all arithmetic and logical operations required by the processor.  

---

### `controller.v` - Control Unit  
Generates control signals based on the decoded instruction and processor status flags.  

---

### `counter.v` - Program Counter  
Implements a counter typically used for program control flow.  

---

### `cpu.v` - Top-Level CPU Module  
Integrates all core components (ALU, controller, memory, registers, etc.) into a single cohesive design.

---

### `driver.v` - Simulation Driver  
Facilitates interactions between the processor and the testbench or external systems.  

---

### `lib.v` - Shared Definitions  
Houses shared parameters, constants, and macros used across modules.

---

### `memory.v` - Data and Instruction Memory  
Stores instruction sets and data for execution and processing.  

---

### `multiplexor.v` - Signal Selector  
Implements signal multiplexers to choose between inputs based on control signals.  

---

### `rcvr.v` - Serial Receiver (FSM)  
Implements a serial-to-parallel interface using a finite state machine.  

---

### `register.v` - Register File  
Stores temporary values and supports read/write operations by the CPU.  

---

### `risc.v` - Behavioral CPU Model  
Provides a simplified RISC CPU design at a higher level of abstraction for testing and reference.

---

### `/tests` - Testbench Directory  
Contains simulation test files to validate the functionality and performance of the processor modules.

---

## Getting Started

### Prerequisites

- Verilog simulation tool (e.g., Icarus Verilog, ModelSim, or Vivado)
- Basic understanding of digital logic and RISC CPU architecture

### Running Simulations

1. Clone the repository:
   ```bash
   git clone https://github.com/jacobpanov/VeriRISC_Processor.git
   cd VeriRISC_Processor

2. Use your preferred HDL simulator.
