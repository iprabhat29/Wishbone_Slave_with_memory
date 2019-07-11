module memory(
                input [31:0] adr,
                input wen,
                inout [31:0] data,
                input clock,
                input rst
             );
                logic [31:0] memory[0:255];
                //logic [31:0] out;
                assign data = wen ? 'bZ : memory[adr];
                

                always @(posedge clock or posedge rst) begin
                    if(rst) begin
                        for(int i = 0;i < 256;i++) begin
                            memory[i] = 0;
                        end
                    end
                    else begin
                        if(!wen) begin
                            //out <= memory[adr];
                        end
                        else begin
                            memory[adr] <= data;
                        end
                    end
                 end
endmodule                 

