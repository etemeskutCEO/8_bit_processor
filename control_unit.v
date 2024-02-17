`timescale 1 ns / 1ps

module control_unit(
    input clk, rst,
    input [3:0] CCR_Result,
    input [7:0] IR,

    output reg IR_Load, MAR_Load, PC_Load, PC_Inc, A_Load, B_Load, CCR_Load,
    write_en,
    output reg [2:0] ALU_Sel,
    output reg [1:0] BUS1_Sel,BUS2_Sel
);

parameter S_FETCH_0 = 5'b00000, S_FETCH_1 = 5'b00001, S_FETCH_2 = 5'b00010, S_DECODE_3 = 5'b00011,
          S_LDA_IMM_4 = 5'b00100, S_LDA_IMM_5 = 5'b00101, S_LDA_IMM_6 = 5'b00110,
          S_LDA_DIR_4 = 5'b00111, S_LDA_DIR_5 = 5'b01000, S_LDA_DIR_6 = 5'b01001, S_LDA_DIR_7 = 5'b01010, S_LDA_DIR_8 = 5'b01011,
          S_LDB_IMM_4 = 5'b01100, S_LDB_IMM_5 = 5'b01101, S_LDB_IMM_6 = 5'b01110,
          S_LDB_DIR_4 = 5'b01111, S_LDB_DIR_5 = 5'b10000, S_LDB_DIR_6 = 5'b10001, S_LDB_DIR_7 = 5'b10010, S_LDB_DIR_8 = 5'b10011,
          S_STA_DIR_4 = 5'b10100, S_STA_DIR_5 = 5'b10101, S_STA_DIR_6 = 5'b10110, S_STA_DIR_7 = 5'b10111,
          S_ADD_AB_4 = 5'b11000,
          S_BRA_4 = 5'b11001, S_BRA_5 = 5'b11010, S_BRA_6 = 5'b11011,
          S_BEQ_4 = 5'b11100, S_BEQ_5 = 5'b11101, S_BEQ_6 = 5'b11110, S_BEQ_7 = 5'b11111;

reg [4:0] current_state, next_state;


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

always @(posedge clk, rst) begin
    if(rst == 1) begin
        current_state <= S_FETCH_0;
    end else begin
        current_state <= next_state;
    end
end

always @(current_state, IR, CCR_Result) begin
    case(current_state)
        S_FETCH_0: next_state <= S_FETCH_1;
        S_FETCH_1: next_state <= S_FETCH_2;
        S_FETCH_2: next_state <= S_DECODE_3;
        S_DECODE_3: begin
            if(IR == YUKLE_A_SBT) next_state <= S_LDA_IMM_4;
            else if(IR == YUKLE_A) next_state <= S_LDA_DIR_4;
            else if(IR == YUKLE_B_SBT) next_state <= S_LDB_IMM_4;
            else if(IR == YUKLE_B) next_state <= S_LDB_DIR_4;
            else if(IR == KAYDET_A) next_state <= S_STA_DIR_4;
            else if(IR == TOPLA_AB) next_state <= S_ADD_AB_4;
            else if(IR == ATLA) next_state <= S_BRA_4;
            else if(IR == ATLA_ESITSE_SIFIR) begin
                if(CCR_Result == 1) next_state <= S_BEQ_4;
                else next_state <= S_BEQ_7; end
            else next_state <= S_FETCH_0;
        end

        S_LDA_IMM_4: next_state <= S_LDA_IMM_5;
        S_LDA_IMM_5: next_state <= S_LDA_IMM_6;
        S_LDA_IMM_6: next_state <= S_FETCH_0;

        S_LDA_DIR_4: next_state <= S_LDA_DIR_5;
        S_LDA_DIR_5: next_state <= S_LDA_DIR_6;
        S_LDA_DIR_6: next_state <= S_LDA_DIR_7;
        S_LDA_DIR_7: next_state <= S_LDA_DIR_8;
        S_LDA_DIR_8: next_state <= S_FETCH_0;

        S_LDB_IMM_4: next_state <= S_LDB_IMM_5;
        S_LDB_IMM_5: next_state <= S_LDB_IMM_6;
        S_LDB_IMM_6: next_state <= S_FETCH_0;

        S_LDB_DIR_4: next_state <= S_LDB_DIR_5;
        S_LDB_DIR_5: next_state <= S_LDB_DIR_6;
        S_LDB_DIR_6: next_state <= S_LDB_DIR_7;
        S_LDB_DIR_7: next_state <= S_LDB_DIR_8;
        S_LDB_DIR_8: next_state <= S_FETCH_0;

        S_STA_DIR_4: next_state <= S_STA_DIR_5;
        S_STA_DIR_5: next_state <= S_STA_DIR_6;
        S_STA_DIR_6: next_state <= S_STA_DIR_7;
        S_STA_DIR_7: next_state <= S_FETCH_0;

        S_ADD_AB_4: next_state <= S_FETCH_0;

        S_BRA_4: next_state <= S_BRA_5;
        S_BRA_5: next_state <= S_BRA_6;
        S_BRA_6: next_state <= S_FETCH_0;

        S_BEQ_4: next_state <= S_BEQ_5;
        S_BEQ_5: next_state <= S_BEQ_6;
        S_BEQ_7: next_state <= S_FETCH_0;
        S_BEQ_6: next_state <= S_FETCH_0; //bypass when z = 0

        default: next_state <= S_FETCH_0;
    endcase
end

    always @(current_state) begin
        IR_Load <= 1'b0;
        MAR_Load <= 1'b0; 
        PC_Load <= 1'b0;
        PC_Inc <= 1'b0;
        A_Load <= 1'b0;
        B_Load <= 1'b0;
        CCR_Load <= 1'b0;
        write_en <= 1'b0;
        ALU_Sel <= 3'b000;
        BUS1_Sel <= 2'b00;
        BUS2_Sel <= 2'b00;
        
        case(current_state)
            S_FETCH_0: begin
                BUS1_Sel <= 2'b00;
                BUS2_Sel <= 2'b01;
                MAR_Load <= 1'b1; end //put bus2 value to mar.
            S_FETCH_1: PC_Inc <= 1'b1;
            S_FETCH_2: begin 
                BUS2_Sel <= 2'b10;
                IR_Load <= 1'b1; end
            S_DECODE_3:begin end

            S_LDA_IMM_4: begin
                BUS1_Sel <= 2'b00;
                BUS2_Sel <= 2'b01;
                MAR_Load <= 1'b1; end
            S_LDA_IMM_5: PC_Inc <= 1'b1;
            S_LDA_IMM_6: begin
                BUS2_Sel <= 2'b10;
                A_Load <= 1'b1; end

            S_LDA_DIR_4: begin
                BUS1_Sel <= 2'b00;
                BUS2_Sel <= 2'b01;
                MAR_Load <= 1'b1; end
            S_LDA_DIR_5: PC_Inc <= 1'b1;
            S_LDA_DIR_6: begin
                BUS2_Sel <= 2'b10;
                MAR_Load <= 1'b1; end
            S_LDA_DIR_7:begin end
            S_LDA_DIR_8: begin
                BUS2_Sel <= 2'b10;
                A_Load <= 1'b1; end

            S_LDB_IMM_4: begin
                BUS1_Sel <= 2'b00;
                BUS2_Sel <= 2'b01;
                MAR_Load <= 1'b1; end
            S_LDB_IMM_5: PC_Inc <= 1'b1;
            S_LDB_IMM_6: begin
                BUS2_Sel <= 2'b10;
                B_Load <= 1'b1; end

            S_LDB_DIR_4: begin
                BUS1_Sel <= 2'b00;
                BUS2_Sel <= 2'b01;
                MAR_Load <= 1'b1; end
            S_LDB_DIR_5: PC_Inc <= 1'b1;
            S_LDB_DIR_6: begin
                BUS2_Sel <= 2'b10;
                MAR_Load <= 1'b1; end
            S_LDB_DIR_7: begin end
            S_LDB_DIR_8: begin
                BUS2_Sel <= 2'b10;
                A_Load <= 1'b1; end
                
            S_STA_DIR_4: begin
                BUS1_Sel <= 2'b00;
                BUS2_Sel <= 2'b01;
                MAR_Load <= 1'b1; end
            S_STA_DIR_5: PC_Inc <= 1'b1;
            S_STA_DIR_6: begin
                BUS2_Sel <= 2'b10;
                MAR_Load <= 1'b1; end
            S_STA_DIR_7: begin
                BUS1_Sel <= 2'b01;
                write_en <= 1'b1; end

            S_ADD_AB_4: begin
                BUS1_Sel <= 2'b01;
                BUS2_Sel <= 2'b00;
                ALU_Sel <= 3'b000;
                A_Load <= 1'b1;
                CCR_Load <= 1'b1;
            end

            S_BRA_4: begin
                BUS1_Sel <= 2'b00;
                BUS2_Sel <= 2'b01;
                MAR_Load <= 1'b1; end
            S_BRA_5: begin end
            S_BRA_6: begin
                BUS2_Sel <= 2'b10;
                MAR_Load <= 1'b1; 
            end

            S_BEQ_4: begin
                BUS1_Sel <= 2'b00;
                BUS2_Sel <= 2'b01;
                MAR_Load <= 1'b1; end
            S_BEQ_5: begin end
            S_BEQ_6: begin
                BUS2_Sel <= 2'b10;
                PC_Load <= 1'b1; 
            end
            S_BEQ_7: PC_Inc <= 1'b1;
            default: begin
                IR_Load <= 1'b0;
                MAR_Load <= 1'b0; 
                PC_Load <= 1'b0;
                PC_Inc <= 1'b0;
                A_Load <= 1'b0;
                B_Load <= 1'b0;
                CCR_Load <= 1'b0;
                write_en <= 1'b0;
                ALU_Sel <= 3'b000;
                BUS1_Sel <= 2'b00;
                BUS2_Sel <= 2'b00;
            end
        endcase
    end
endmodule



            
