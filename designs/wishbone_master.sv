`define IDLE 0
`define READ 1
`define WRITE 2

module wishbone_slave(
								input RST_I,
								input CLK_I,
								input [31 : 0] DAT_I,
    							input [31:0] ADR_I,
                                input WE_I,
                                input SEL_I,
                                input STB_I,
                                input CYC_I,
								output logic [31:0] DAT_O,
								output logic ACK_O
						);


    logic [1:0] state;
    logic [1:0] next_state;

    logic rst;
    logic wen;
    wire [31:0] data_io;
    logic [31:0] data;
    logic [31:0] adr;  
     


    assign data_io = wen ? data : 'bZ; 

    memory memory_inst0(adr,wen,data_io,CLK_I,rst);
    

    always @(posedge CLK_I or RST_I) begin
        if(RST_I) begin
            state <= `IDLE; 
            next_state <= `IDLE;
            rst <= 1; 
        end
        else begin
            state <= next_state;
            rst <= 0;
        end
    end

    always @(*) begin
        case(state)
            `IDLE: begin
                DAT_O <= 0;
                if(!WE_I && STB_I && CYC_I) begin
                    next_state <= `READ;
                    ACK_O <= 0;
                end
                else if(WE_I && STB_I && CYC_I) begin
                    next_state <= `WRITE;
                    ACK_O <= 0;
                end
                else begin
                    next_state <= `IDLE;
                    ACK_O <= 0;
                end
             end   
            `READ: begin
                adr <= ADR_I;             
                wen <= 0;
                ACK_O <= 1;
                //@(posedge CLK_I);
                DAT_O <= data_io;
                //ACK_O <= 1;
                next_state <= `IDLE;
            end

            `WRITE : begin
                adr <= ADR_I;
                wen <= 1;
                data <= DAT_I;
                ACK_O <= 1;
                //@(posedge CLK_I);
                //ACK_O <= 1;
                next_state <= `IDLE;
            end

            default: begin
                next_state <= `IDLE;
                ACK_O <= 0;
                DAT_O <= 0;
            end
       endcase    
    end

endmodule
