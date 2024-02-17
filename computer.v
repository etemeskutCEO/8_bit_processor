`timescale 1 ns / 1ps

module computer(
    input clk,rst,
    input [7:0] port_in_00,port_in_01,port_in_02,port_in_03,port_in_04,
    port_in_05,port_in_06,port_in_07,port_in_08,port_in_09,port_in_10,
    port_in_11,port_in_12,port_in_13,port_in_14,port_in_15,

    output wire [7:0] port_out_00,port_out_01,port_out_02,port_out_03,
    port_out_04,port_out_05,port_out_06,port_out_07,port_out_08,
    port_out_09,port_out_10,port_out_11,port_out_12,port_out_13,
    port_out_14,port_out_15
);

wire [7:0] address, data_in, data_out;
wire write_en;

cpu CPU(rst,clk,data_out,write_en,data_in,address);
memory_top MEMORY(clk,rst,write_en,address,data_in,
    port_in_00,port_in_01,port_in_02,port_in_03,port_in_04,
    port_in_05,port_in_06,port_in_07,port_in_08,port_in_09,port_in_10,
    port_in_11,port_in_12,port_in_13,port_in_14,port_in_15,
    
    data_out,
    
    port_out_00,port_out_01,port_out_02,port_out_03,
    port_out_04,port_out_05,port_out_06,port_out_07,port_out_08,
    port_out_09,port_out_10,port_out_11,port_out_12,port_out_13,
    port_out_14,port_out_15);

endmodule  