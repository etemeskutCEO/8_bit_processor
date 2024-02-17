`timescale 1ns / 1ps

module memory_top(
    input clk,rst,write_en,
    input [7:0] address, data_in,
    
    input [7:0] port_in_00,port_in_01,port_in_02,port_in_03,port_in_04,
    port_in_05,port_in_06,port_in_07,port_in_08,port_in_09,port_in_10,
    port_in_11,port_in_12,port_in_13,port_in_14,port_in_15,

    output reg [7:0] data_out,

    output wire [7:0] port_out_00,port_out_01,port_out_02,port_out_03,
    port_out_04,port_out_05,port_out_06,port_out_07,port_out_08,
    port_out_09,port_out_10,port_out_11,port_out_12,port_out_13,
    port_out_14,port_out_15
);

wire [7:0] rom_out,ram_out;

program_memory ROM (clk,address,rom_out);
data_memory RAM (clk,address,data_in,write_en,ram_out);
output_ports output_ports (clk,reset,write_en,address,data_in,port_out_00,
    port_out_01,port_out_02,port_out_03,port_out_04,port_out_05,
    port_out_06,port_out_07,port_out_08,port_out_09,port_out_10,
    port_out_11,port_out_12,port_out_13,port_out_14,port_out_15
);

always @(address,rom_out, ram_out,
			port_in_00, port_in_01, port_in_02, port_in_03,
			port_in_04, port_in_05, port_in_06, port_in_07,
			port_in_07, port_in_08, port_in_09, port_in_10,
			port_in_11, port_in_12, port_in_13, port_in_14, port_in_15)
        begin
        if(address >= 8'h00 && address <= 8'h7F) begin 
            data_out <= rom_out;
        end else if(address >= 8'h80 && address <= 8'hDF) begin
            data_out <= ram_out;
        end else if(address == 8'hF0) begin
            data_out <= port_in_00;
        end else if(address == 8'hF1) begin
            data_out <= port_in_01;
        end else if(address == 8'hF2) begin
            data_out <= port_in_02;
        end else if(address == 8'hF3) begin
            data_out <= port_in_03;
        end else if(address == 8'hF4) begin
            data_out <= port_in_04;
        end else if(address == 8'hF5) begin
            data_out <= port_in_05;
        end else if(address == 8'hF6) begin
            data_out <= port_in_06;
        end else if(address == 8'hF7) begin
            data_out <= port_in_07;
        end else if(address == 8'hF8) begin
            data_out <= port_in_08;
        end else if(address == 8'hF9) begin
            data_out <= port_in_09;
        end else if(address == 8'hFA) begin
            data_out <= port_in_10;
        end else if(address == 8'hFB) begin
            data_out <= port_in_11;
        end else if(address == 8'hFC) begin
            data_out <= port_in_12;
        end else if(address == 8'hFD) begin
            data_out <= port_in_13;
        end else if(address == 8'hFE) begin
            data_out <= port_in_14;
        end else if(address == 8'hFF) begin
            data_out <= port_in_15;
        end
        else begin
        data_out <= 8'h00;
        end
    end
endmodule