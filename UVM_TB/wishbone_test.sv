class wishbone_test extends uvm_test;
    `uvm_component_utils(wishbone_test)
    function new(string name = "",uvm_component parent);
        super.new(name,parent);
    endfunction
    wishbone_env env;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = wishbone_env::type_id::create("env",this);
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(phase);
        #1000;
        phase.drop_objection(phase);
    endtask
endclass

