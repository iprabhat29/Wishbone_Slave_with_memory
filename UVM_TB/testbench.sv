`include "wishbone_interface.sv"
module testbench;
    import uvm_pkg::*;
    wishbone_interface intf();
    wishbone_slave inst0(intf.RST_I,intf.CLK_I,intf.DAT_I,intf.ADR_I,intf.WE_I,intf.SEL_I,intf.STB_I,intf.CYC_I,intf.DAT_O,intf.ACK_O);
    
    initial intf.CLK_I = 0;

    initial forever #5 intf.CLK_I = ~ intf.CLK_I;

    initial #10000 $finish;

    initial begin
        uvm_resource_db#(virtual wishbone_interface)::set(.scope("ifs"),.name("wishbone_interface"),.val(intf));
        run_test("wishbone_test");
    end
endmodule
