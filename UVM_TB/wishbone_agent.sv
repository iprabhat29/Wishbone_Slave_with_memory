class wishbone_agent extends uvm_agent;
    `uvm_component_utils(wishbone_agent)
    uvm_analysis_port#(wishbone_sequence) agent_ap_before;
    uvm_analysis_port#(wishbone_sequence) agent_ap_after;
    //uvm_analysis_imp #(wishbone_sequence,wishbone_agent) agent_before_export;
    //uvm_analysis_imp #(wishbone_sequence,wishbone_agent) agent_after_export;
    function new(string name,uvm_component parent);
        super.new(name,parent);
    endfunction
    wishbone_sequence sq;
    wishbone_sequencer sqr;
    wishbone_driver dvr;
    wishbone_monitor mon;

    uvm_tlm_fifo#(wishbone_sequence) tlmfifo;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent_ap_after = new("agent_ap_after",this);
        agent_ap_before = new("agent_ap_before",this);
        //agent_after_export = new("agent_after_export",this);
        //agent_before_export = new("agent_before_export",this);
        tlmfifo = new("tlmfifo",this,1);
        sqr = wishbone_sequencer::type_id::create("sqr",this);
        dvr = wishbone_driver::type_id::create("dvr",this);
        mon = wishbone_monitor::type_id::create("mon",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        sqr.putport.connect(tlmfifo.put_export);
        dvr.getport.connect(tlmfifo.get_export);
        mon.mon_ap_before.connect(agent_ap_before);
        mon.mon_ap_after.connect(agent_ap_after);
        //agent_ap_before.connect(sc.sc_before_export);
        //agent_ap_after.connect(sc.sc_after_export);
    endfunction
endclass
