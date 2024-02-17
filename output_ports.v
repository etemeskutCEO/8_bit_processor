`timescale 1ns / 1ps

module output_ports(
    input clk, reset, write_en,
    input [7:0] address, data_in,

    output reg [7:0] port_out_00,port_out_01,port_out_02,port_out_03,port_out_04,port_out_05,
    port_out_06,port_out_07,port_out_08,port_out_09,port_out_10,port_out_11,
    port_out_12,port_out_13,port_out_14,port_out_15
    );

    always @(reset, posedge clk) begin
        if(reset == 1) begin
                port_out_00 <= 8'h00;
                port_out_01 <= 8'h00;
                port_out_02 <= 8'h00;
                port_out_03 <= 8'h00;
                port_out_04 <= 8'h00;
                port_out_05 <= 8'h00;
                port_out_06 <= 8'h00;
                port_out_07 <= 8'h00;
                port_out_08 <= 8'h00;
                port_out_09 <= 8'h00;
                port_out_10 <= 8'h00;
                port_out_11 <= 8'h00;
                port_out_12 <= 8'h00;
                port_out_13 <= 8'h00;
                port_out_14 <= 8'h00;
                port_out_15 <= 8'h00;
        end else if(write_en == 1'b1) begin
            case(address)
                8'hE0: port_out_00 <= data_in;
                8'hE1: port_out_01 <= data_in;
                8'hE2: port_out_02 <= data_in;
                8'hE3: port_out_03 <= data_in;
                8'hE4: port_out_04 <= data_in;
                8'hE5: port_out_05 <= data_in;
                8'hE6: port_out_06 <= data_in;
                8'hE7: port_out_07 <= data_in;
                8'hE8: port_out_08 <= data_in;
                8'hE9: port_out_09 <= data_in;
                8'hEA: port_out_10 <= data_in;
                8'hEB: port_out_11 <= data_in;
                8'hEC: port_out_12 <= data_in;
                8'hED: port_out_13 <= data_in;
                8'hEE: port_out_14 <= data_in;
                8'hEF: port_out_15 <= data_in;
                default begin
                port_out_00 <= 8'h00;
                port_out_01 <= 8'h00;
                port_out_02 <= 8'h00;
                port_out_03 <= 8'h00;
                port_out_04 <= 8'h00;
                port_out_05 <= 8'h00;
                port_out_06 <= 8'h00;
                port_out_07 <= 8'h00;
                port_out_08 <= 8'h00;
                port_out_09 <= 8'h00;
                port_out_10 <= 8'h00;
                port_out_11 <= 8'h00;
                port_out_12 <= 8'h00;
                port_out_13 <= 8'h00;
                port_out_14 <= 8'h00;
                port_out_15 <= 8'h00;
                end
            endcase
        end
    end
endmodule