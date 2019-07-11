# Wishbone_Slave_with_memory
Design of wishbone slave with memory implementation

Design specification is provided.

Tools used 
  vcs 2017.03-SP2-11
  dve 2017.03-SP2-11
  
How to RUN

From testbench folder run:
  vcs -Mupdate -RPP -sverilog -timescale=1ns/1ps ../designs/wishbone_slave.sv ../designs/memory.sv wishbone_tb.sv -o demo -full64 -debug_all
  
To debug in gui
  ./demo -gui
  
