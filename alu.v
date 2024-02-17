`timescale 1ns / 1ps

module alu(
    input [7:0] A,B,
    input [2:0] alu_sel,

    output reg [3:0] nzvc,
    output reg [7:0] result 
);

    reg [8:0] sum_unsigned;
    reg [7:0] alu_signal;
    reg sum_overflow, sub_overflow;

    always @(alu_sel, A, B) begin
        sum_unsigned <= 8'h00;

        case(alu_sel)
            3'b000: begin
                alu_signal <= A + B;
                sum_unsigned <= {1'b0, A} + {1'b0, B};
            end
            3'b001: begin
                alu_signal <= A - B;
                sum_unsigned <= {1'b0, A} + {1'b0, B};
            end
            3'b010: alu_signal <= A & B;
            3'b011: alu_signal <= A | B;
            3'b100: alu_signal <= A + 1'b1;
            3'b101: alu_signal <= A - 1'b0;
            default: begin
                alu_signal <= 8'b00;
                sum_unsigned <= 8'b00;
            end
        endcase

        nzvc[3] = alu_signal[7];
        nzvc[2] = alu_signal ? 1'b0 : 1'b1;

        sum_overflow = (A[7] & ~B[7] & alu_signal[7]) | (A[7] & B[7] & ~alu_signal[7]);
        sub_overflow = (~A[7] & B[7] & alu_signal[7]) | (A[7] & ~B[7] & ~alu_signal);

        nzvc[1] = (alu_sel == 3'b000) ? sum_overflow : ((alu_sel == 3'b001) ? sub_overflow : 1'b0);
        nzvc[0] = (alu_sel == 3'b000) ? sum_unsigned[8] : ((alu_sel == 3'b001) ? sum_unsigned[8] : 0);
    end
endmodule