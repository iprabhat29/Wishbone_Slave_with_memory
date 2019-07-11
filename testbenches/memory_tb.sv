module tb;
    bit clock,reset;

    wire [31:0] data;

    
    logic [31:0] adr;

    bit wen;
    
    logic [31:0] data_i;
    assign data = wen ? data_i : 'bZ;

    initial forever #5 clock = ~ clock;

    memory inst_mem(adr,wen,data,clock,reset);
    initial begin
        #10 reset <= 1;
        @(posedge clock);
        reset <= 0;
        @(posedge clock);
        adr <= 32'd10;
        data_i <= 32'hDEADBEEF;
        wen <= 1;
        @(posedge clock);
        adr <= 32'd11;
        data_i <= 32'hFEEDBEEF;
        wen <= 1;
        @(posedge clock);
        wen <= 1;
        data_i <= 32'hFADEBEED;
        adr <= 32'd12;
        @(posedge clock);
        wen <= 1;
        adr <= 32'd13;
        data_i <= 32'hBEEFFADE;
        @(posedge clock);
        wen <= 0;
        adr <= 32'd12;
        @(posedge clock);
        reset <= 1;
   end

    initial #1000 $finish;

endmodule
