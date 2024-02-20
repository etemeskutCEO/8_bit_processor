`timescale 1ns / 1ps

module program_memory(clk,address,data_out);

input clk;
input [7:0] address;
output reg [7:0] data_out;
reg enable;


parameter YUKLE_A_SBT	= 8'h86;
parameter YUKLE_A		= 8'h87;
parameter YUKLE_B_SBT	= 8'h88;
parameter YUKLE_B		= 8'h89;
parameter KAYDET_A		= 8'h96;	
parameter KAYDET_B		= 8'h97;

parameter TOPLA_AB		= 8'h42;
parameter CIKAR_AB		= 8'h43;
parameter AND_AB		= 8'h44;
parameter OR_AB			= 8'h45;
parameter ARTTIR_A		= 8'h46;
parameter ARTTIR_B		= 8'h47;
parameter DUSUR_A		= 8'h48;
parameter DUSUR_B		= 8'h49;

parameter ATLA				    = 8'h20;
parameter ATLA_NEGATIFSE		= 8'h21;
parameter ATLA_POZITIFSE		= 8'h22;
parameter ATLA_ESITSE_SIFIR	    = 8'h23;
parameter ATLA_DEGILSE_SIFIR	= 8'h24;
parameter ATLA_OVERFLOW_VARSA   = 8'h25;
parameter ATLA_OVERFLOW_YOKSA   = 8'h26;
parameter ATLA_ELDE_VARSA		= 8'h27;
parameter ATLA_ELDE_YOKSA       = 8'h28;


reg [7:0] ROM [127:0];
integer i;

initial begin

    ROM[0] <= YUKLE_A;
    ROM[1] <= 8'hF0;
    ROM[2] <= YUKLE_B;
    ROM[3] <= 8'hF1;
    ROM[4] <= TOPLA_AB;
    ROM[5] <= ATLA_ESITSE_SIFIR;
    ROM[6] <= 8'h0B;
    ROM[7] <= KAYDET_A;
    ROM[8] <= 8'h80;
    ROM[9] <= ATLA;
    ROM[10] <= 8'h20;
    ROM[11] <= YUKLE_A;
    ROM[12] <= 8'hF2;
    ROM[13] <= ATLA;
    ROM[14] <= 8'h04;
    for(i=15;i<128;i=i+1) begin
        ROM[i] <= 8'b00000000;
    end
end
    always @(*) begin
        if(address >= 8'h00 && address <= 8'h7F) begin
            enable = 1'b1;
        end else begin
            enable = 1'b0;
        end
    end

    always @(posedge clk) begin
        if(enable == 1) begin
            data_out <= ROM[address];
        end
    end


endmodule
