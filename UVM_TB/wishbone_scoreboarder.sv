`uvm_analysis_imp_decl(_before)
`uvm_analysis_imp_decl(_after)
class wishbone_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(wishbone_scoreboard)
    uvm_analysis_export #(wishbone_sequence) sc_before_export;
    uvm_analysis_export #(wishbone_sequence) sc_after_export;
    uvm_tlm_analysis_fifo #(wishbone_sequence) sc_before_fifo;
    uvm_tlm_analysis_fifo #(wishbone_sequence) sc_after_fifo;
    wishbone_sequence sqa;
    wishbone_sequence sqb;
    function new(string name,uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sc_before_export = new("sc_before_export",this);
        sc_after_export  = new("sc_after_export",this);

        sc_before_fifo = new("sc_before_fifo",this);
        sc_after_fifo = new("sc_after_fifo",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        sc_before_export.connect(sc_before_fifo.analysis_export);
        sc_after_export.connect(sc_after_fifo.analysis_export);
    endfunction

    function void write_before(wishbone_sequence sq);
        sc_before_fifo.write(sq);
    endfunction

    function void write_after(wishbone_sequence sq);
        sc_after_fifo.write(sq);
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            #40;
            sqa = new();
            sqb = new();
            sc_before_fifo.get(sqb);
            sc_after_fifo.get(sqa);
            compare();
            #10;
        end
    endtask

    virtual function void compare();
        $display("Before ADR %d\tDATA %d\top %d\n",sqb.adr,sqb.data,sqb.op);
        $display("AFTER ADR %d\tDATA %d\top %d\n",sqa.adr,sqa.data,sqa.op);
    endfunction
endclass
        

