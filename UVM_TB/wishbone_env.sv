class wishbone_env extends uvm_env;
    `uvm_component_utils(wishbone_env);
    wishbone_agent ag;
    wishbone_scoreboard sc;
    function new(string name,uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ag = wishbone_agent::type_id::create("ag",this);
        sc = wishbone_scoreboard::type_id::create("sc",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        ag.agent_ap_before.connect(sc.sc_before_export);
        ag.agent_ap_after.connect(sc.sc_after_export);
    endfunction

endclass
