`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.02.2024 11:18:25
// Design Name: 
// Module Name: computer_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module computer_tb;
    
    reg clk=0;
    reg rst=0;
    reg [7:0] port_in_00,port_in_01,port_in_02,port_in_03,port_in_04,
    port_in_05,port_in_06,port_in_07,port_in_08,port_in_09,port_in_10,
    port_in_11,port_in_12,port_in_13,port_in_14,port_in_15;

    wire [7:0] port_out_00,port_out_01,port_out_02,port_out_03,
    port_out_04,port_out_05,port_out_06,port_out_07,port_out_08,
    port_out_09,port_out_10,port_out_11,port_out_12,port_out_13,
    port_out_14,port_out_15;
    
    computer computer_DUT(clk,rst,port_in_00,port_in_01,port_in_02,port_in_03,port_in_04,
    port_in_05,port_in_06,port_in_07,port_in_08,port_in_09,port_in_10,
    port_in_11,port_in_12,port_in_13,port_in_14,port_in_15,port_out_00,
    port_out_01,port_out_02,port_out_03,
    port_out_04,port_out_05,port_out_06,port_out_07,port_out_08,
    port_out_09,port_out_10,port_out_11,port_out_12,port_out_13,
    port_out_14,port_out_15);
    
    always #10 clk = ~clk;
    
    initial begin
    rst = 1;
    #40;
    rst=0;
    #40;
    port_in_00 = 8'b11110011;
    port_in_01 = 8'h0D;
    port_in_02 = 8'h0F;
    #4000;
    end
    
    
endmodule
