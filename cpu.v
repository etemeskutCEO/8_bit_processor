`timescale 1 ns / 1ps

module cpu(
    input rst,clk,
    input [7:0] from_memory,

    output write_en,
    output [7:0] to_memory,address
    );

    wire IR_Load, MAR_Load, PC_Load, PC_Inc, A_Load, B_Load, CCR_Load;
    wire [2:0] ALU_Sel;
    wire [3:0] CCR_Result;
    wire [1:0] BUS1_Sel, BUS2_Sel;
    wire [7:0] IR;

    control_unit control_unit1(clk,rst,CCR_Result,IR,IR_Load,MAR_Load,PC_Load,PC_Inc,A_Load,
                                B_Load,CCR_Load,write_en,ALU_Sel,BUS1_Sel,BUS2_Sel);

    data_paths data_path1(clk,rst,IR_Load,MAR_Load,PC_Load,PC_Inc,A_Load,B_Load,CCR_Load,
                          write_en,ALU_Sel,BUS1_Sel,BUS2_Sel);

endmodule