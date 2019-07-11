module wishbone_tb;
    logic rst_i,clk_i,we_i,sel_i,stb_i,ack_o,cyc_i;

    logic [31:0] adr_i;

    logic [31:0] data_i;

    logic [31:0] data_o;



    wishbone_slave inst0(rst_i,clk_i,data_i,adr_i,we_i,sel_i,stb_i,cyc_i,data_o,ack_o);
    initial begin
        clk_i = 0;
        rst_i = 0;   
    end

    initial begin
        @(posedge clk_i) repeat(2);
        rst_i <= 1;
        @(posedge clk_i) repeat(2);
        rst_i <= 0;
        @(posedge clk_i);
        cyc_i <= 1;
        adr_i <= 10;
        stb_i <= 1;
        we_i <= 1;
        data_i <= 32'hDEADBEEF;
        @(posedge clk_i);
        @(posedge ack_o);
        //@(negedge ack_o);
        stb_i <= 0;
        cyc_i <= 0;
        @(posedge clk_i);
        cyc_i <= 1;
        stb_i <= 1;
        we_i <= 1;
        adr_i <= 12; 
        data_i <= 32'hDEADFEED;
        @(posedge clk_i);
        @(posedge ack_o);
        stb_i <= 0;
        cyc_i <= 0;
        @(posedge clk_i);
        cyc_i <= 1;
        stb_i <= 1;
        we_i <= 0;
        adr_i <= 10;
        @(posedge clk_i);
        @(posedge ack_o);
        stb_i <= 0;
        cyc_i <= 0;
        @(posedge clk_i);
    end


    initial forever #5 clk_i = ~ clk_i;

    initial #1000 $finish;

endmodule
