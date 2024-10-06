// ケーブル削減のため、レジスタ基板に搭載することになると思う
// 41
module ALU_input_mux_IR(
        input wire [7:0] notR,
        input wire [7:0] notI,
        input wire notPA_Select_R_low,
        input wire notPA_Select_I_low,
        input wire PA_Select_IOP_low,
        output wire [15:0] Low
    );

    wire _notPA_Select_IOP_low = PA_Select_IOP_low ~| PA_Select_IOP_low;

    assign Low[8] = notI[0] ~| _notPA_Select_IOP_low;
    assign Low[9] = notI[1] ~| _notPA_Select_IOP_low;
    assign Low[10] = notI[2] ~| _notPA_Select_IOP_low;
    assign Low[11] = notI[3] ~| _notPA_Select_IOP_low;
    assign Low[12] = notI[4] ~| _notPA_Select_IOP_low;
    assign Low[13] = notI[5] ~| _notPA_Select_IOP_low;
    assign Low[14] = notI[6] ~| _notPA_Select_IOP_low;
    assign Low[15] = notI[7] ~| _notPA_Select_IOP_low;

    wire _low_R0 = notR[0] ~| notPA_Select_R_low;
    wire _low_R1 = notR[1] ~| notPA_Select_R_low;
    wire _low_R2 = notR[2] ~| notPA_Select_R_low;
    wire _low_R3 = notR[3] ~| notPA_Select_R_low;
    wire _low_R4 = notR[4] ~| notPA_Select_R_low;
    wire _low_R5 = notR[5] ~| notPA_Select_R_low;
    wire _low_R6 = notR[6] ~| notPA_Select_R_low;
    wire _low_R7 = notR[7] ~| notPA_Select_R_low;
    wire _low_I0 = notI[0] ~| notPA_Select_I_low;
    wire _low_I1 = notI[1] ~| notPA_Select_I_low;
    wire _low_I2 = notI[2] ~| notPA_Select_I_low;
    wire _low_I3 = notI[3] ~| notPA_Select_I_low;
    wire _low_I4 = notI[4] ~| notPA_Select_I_low;
    wire _low_I5 = notI[5] ~| notPA_Select_I_low;
    wire _low_I6 = notI[6] ~| notPA_Select_I_low;
    wire _low_I7 = notI[7] ~| notPA_Select_I_low;

    wire _notLow0 = _low_R0 ~| _low_I0;
    wire _notLow1 = _low_R1 ~| _low_I1;
    wire _notLow2 = _low_R2 ~| _low_I2;
    wire _notLow3 = _low_R3 ~| _low_I3;
    wire _notLow4 = _low_R4 ~| _low_I4;
    wire _notLow5 = _low_R5 ~| _low_I5;
    wire _notLow6 = _low_R6 ~| _low_I6;
    wire _notLow7 = _low_R7 ~| _low_I7;

    assign Low[0] = _notLow0 ~| _notLow0;
    assign Low[1] = _notLow1 ~| _notLow1;
    assign Low[2] = _notLow2 ~| _notLow2;
    assign Low[3] = _notLow3 ~| _notLow3;
    assign Low[4] = _notLow4 ~| _notLow4;
    assign Low[5] = _notLow5 ~| _notLow5;
    assign Low[6] = _notLow6 ~| _notLow6;
    assign Low[7] = _notLow7 ~| _notLow7;

endmodule