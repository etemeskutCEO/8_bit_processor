`timescale 1ns / 1ps

module data_paths(
    input clk,rst,IR_Load,MAR_Load,PC_Load,PC_Inc,A_Load,B_Load,CCR_Load,
    input [2:0] ALU_Sel,
    input [1:0] BUS1_Sel,BUS2_Sel,
    input [7:0] from_memory,

    output [7:0] IR,address,to_memory,
    output [3:0] CCR_Result
);

wire [7:0] BUS1,BUS2,ALU_result;
reg [7:0] IR_reg,MAR,PC,A_reg,B_reg;
wire [3:0] CCR_in;
reg [3:0] CCR;

assign BUS1 = (BUS1_Sel == 2'b00) ? PC : (BUS1_Sel == 2'b01) ? A_reg : (BUS1_Sel == 2'b10) ? B_reg : 8'h00;
assign BUS2 = (BUS2_Sel == 2'b00) ? ALU_result : (BUS2_Sel == 2'b01) ? BUS1 : (BUS2_Sel == 2'b10) ? from_memory : 8'h00;

always @(posedge clk,rst) begin
    if(rst == 1) begin
        IR_reg <= 8'h00;
    end else if(IR_Load == 1) begin
        IR_reg <= BUS2;
    end
end
assign IR = IR_reg;

always @(posedge clk, rst) begin
    if(rst == 1) begin
        MAR <= 8'h00;
    end else if(MAR_Load == 1) begin
        MAR <= BUS2;
    end
end
assign address = MAR;

always @(posedge clk, rst) begin
    if(rst == 1) begin
        PC <= 8'h00;
    end else if(PC_Load == 1) begin
        PC <= BUS2;
    end else if(PC_Inc == 1) begin
        PC <= (PC + 8'b01);
    end
end

always @(posedge clk, rst) begin
    if(rst == 1) begin
        A_reg <= 8'h00;
    end else if(A_Load == 1) begin
        A_reg <= BUS2;
    end
end

always @(posedge clk, rst) begin
    if(rst == 1) begin
        B_reg <= 8'h00;
    end else if(B_Load == 1) begin
        B_reg <= BUS2;
    end
end

alu alu1(B_reg,BUS1,ALU_Sel,CCR_in,ALU_result);

always @(posedge clk, rst) begin
    if(rst == 1) begin
        CCR <= 8'h00;
    end else if(CCR_Load == 1) begin
        CCR <= CCR_in;
    end
end
assign CCR_Result = CCR;

assign to_memory = BUS1;

endmodule