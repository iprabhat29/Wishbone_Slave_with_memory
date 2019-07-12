class wishbone_monitor extends uvm_monitor;
    `uvm_component_utils(wishbone_monitor)
    virtual wishbone_interface intf;
    uvm_analysis_port #(wishbone_sequence) mon_ap_before;
    uvm_analysis_port #(wishbone_sequence) mon_ap_after;
    //vitrual wishbone_interface intf;
    wishbone_sequence sqa;
    wishbone_sequence sqb;
    function new(string name,uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        void'(uvm_resource_db#(virtual wishbone_interface)::read_by_name(.scope("ifs"), .name("wishbone_interface"), .val(intf)));
        mon_ap_before = new("mon_ap_before",this);
        mon_ap_after =  new("mon_ap_after",this);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
	        sqb = new();
            sqa = new();
            @(posedge intf.ACK_O);
            if(intf.WE_I) begin 
               //sq = new();
               sqb.data = intf.DAT_I;
               sqb.adr = intf.ADR_I;
               sqb.op = 1;
               mon_ap_before.write(sqb);
               sqa.data = intf.DAT_I;
               sqa.adr = intf.ADR_I;
               sqa.op = 1;
               mon_ap_after.write(sqa);
            end
            else if(!intf.WE_I) begin
                sqb.data = intf.DAT_O;
                sqb.adr = intf.ADR_I;
                sqb.op = 0;
                mon_ap_before.write(sqb);
                sqa = new();
                sqa.data = intf.DAT_O;
                sqa.adr = intf.ADR_I;
                sqa.op = 0;
                mon_ap_after.write(sqa);
            end
            else;
        end
   endtask
endclass

