class wishbone_driver extends uvm_driver#(wishbone_sequence);
    `uvm_component_utils(wishbone_driver)
    
    virtual wishbone_interface intf;
    
    uvm_blocking_get_port#(wishbone_sequence) getport;
    
    wishbone_sequence sq;

    static int count1 = 0;

    static int count2 = 0;

    static logic [31:0] adr_mem[0:255];

    function new(string name = "",uvm_component parent);
        super.new(name,parent);
    endfunction

    task reset_adr_mem();
        begin
            for(int i = 0;i <= 255; i++)
                adr_mem[i] <= 32'd0;
        end
    endtask

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        //sq = wishbone_sequence::type_id::create("sq",this);
        getport = new("getport",this);
        void'(uvm_resource_db#(virtual wishbone_interface)::read_by_name(.scope("ifs"), .name("wishbone_interface"), .val(intf)));
       // getport = new("getport",this);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        repeat(100) begin
            sq = new();
            getport.get(sq);
            $display("Received ADR=%h\tData=%h\top=%d\n",sq.adr,sq.data,sq.op);
            case(sq.op)
                1 : begin
                    intf.CYC_I <= 1;
                    intf.ADR_I <= sq.adr;
                    intf.STB_I <= 1;
                    intf.WE_I <= 1;
                    intf.DAT_I <= sq.data;
                    adr_mem[count1] <= sq.adr;
                    count1 <= count1 + 1;
                    @(posedge intf.CLK_I);
                    @(posedge intf.ACK_O);
                    intf.STB_I <= 0;
                    intf.CYC_I <= 0;
                    @(posedge intf.CLK_I);
                end
                0: begin
                    intf.CYC_I <= 1;
                    intf.STB_I <= 1;
                    intf.WE_I <= 0;
                    intf.ADR_I <= adr_mem[count2];
                    count2 <= count2 + 1;
                    @(posedge intf.CLK_I);
                    @(posedge intf.ACK_O);
                    intf.STB_I <= 0;
                    intf.CYC_I <= 0;
                    @(posedge intf.CLK_I);
                end
                2: begin
                    intf.RST_I <= 1;
                    reset_adr_mem();
                    count1 <= 0;
                    count2 <= 0;
                    @(posedge intf.CLK_I) repeat(2);
                    intf.RST_I <= 0;
                    @(posedge intf.CLK_I);
                end
                default : begin

                end
            endcase
            
        end
    endtask
endclass
