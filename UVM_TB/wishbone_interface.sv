interface wishbone_interface;
    logic RST_I,CLK_I,WE_I,STB_I,SEL_I,CYC_I;
    logic [31:0] ADR_I;
    logic [31:0] DAT_I;
    logic [31:0] DAT_O;
    logic [31:0] ADR_O;
    logic ACK_O;
    //clocking cb @(posedge CLK_I);
        //input WE_I,STB_I,SEL_I,CYC_I;
        //input ADR_I,DAT_I;
        //output DAT_O,ACK_O,ADR_O;
    //endclocking

//initial $monitor("CLK = %b\n",CLK_I);
endinterface
