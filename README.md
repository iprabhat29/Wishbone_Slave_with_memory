# Wishbone_Slave_with_memory
Design of wishbone slave with memory implementation
How to RUN

From testbench folder run:
  vcs -Mupdate -RPP -sverilog -timescale=1ns/1ps ../designs/wishbone_master.sv ../designs/memory.sv wishbone_tb.sv -o demo -full64 -debug_all
  
To debug in gui
  ./demo -gui
  
