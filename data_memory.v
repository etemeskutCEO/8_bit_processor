`timescale 1ns / 1ps

module data_memory(
    input clk,
    input [7:0] address,
    input [7:0] data_in,
    input write_en,
    output reg data_out);

    reg [7:0] RAM [128:223];
    reg enable;
    integer i;
    
     initial begin
        for (i = 128; i <= 223; i = i + 1) begin
            RAM[i] = 8'h00;
        end
    end

    always @(*) begin
        if(address >= 8'h80 && address <= 8'hDF) begin
            enable = 1'b1;
        end else begin
            enable = 1'b0;
        end
    end

    //need to check for <= operator on data_out part, it may be wrong.
    always @(posedge clk) begin
        if((enable == 1'b1) && (write_en == 1'b1)) begin
            RAM[address] <= data_in;
        end else if((enable == 1'b1) && (write_en == 1'b0)) begin
            data_out <= RAM[address];
        end
    end

endmodule