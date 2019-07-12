class wishbone_sequencer extends uvm_sequencer#(wishbone_sequence);
    `uvm_component_utils(wishbone_sequencer)
    uvm_blocking_put_port #(wishbone_sequence) putport;

    wishbone_sequence sq;

    function new(string name = "",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        //sq = wishbone_sequence::type_id::create("sq",this);
        putport = new("putport",this);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        repeat(100) begin
            sq = new();
            assert(sq.randomize());
            $display("ADR = %h\tDATA=%h\top=%d\n",sq.adr,sq.data,sq.op);
            putport.put(sq);
            #50;
        end
    endtask


endclass
