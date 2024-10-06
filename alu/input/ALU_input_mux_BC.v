// ケーブル削減のため、レジスタ基板に搭載することになると思う
// DE/HLも同じ
// 84
module ALU_input_mux_BC(
        input wire [7:0] notB,
        input wire [7:0] notC,
        input wire notPA_Select_B_high,
        input wire PA_Select_C_high,
        input wire PA_Select_BC_high,
        input wire notPA_Select_B_low,
        input wire PA_Select_C_low,
        input wire PA_Select_BC_low,
        output wire [15:0] High,
        output wire [15:0] Low,
    );

    wire _notPA_Select_B_high_high = PA_Select_BC_high ~| PA_Select_BC_high;
    wire _notPA_Select_C_high_low = PA_Select_C_high ~| PA_Select_BC_high;
    wire _notPA_Select_B_low_high = PA_Select_BC_low ~| PA_Select_BC_low;
    wire _notPA_Select_C_low_low = PA_Select_C_low ~| PA_Select_BC_low;

    assign High[8] = notB[0] ~| _notPA_Select_B_high_high;
    assign High[9] = notB[1] ~| _notPA_Select_B_high_high;
    assign High[10] = notB[2] ~| _notPA_Select_B_high_high;
    assign High[11] = notB[3] ~| _notPA_Select_B_high_high;
    assign High[12] = notB[4] ~| _notPA_Select_B_high_high;
    assign High[13] = notB[5] ~| _notPA_Select_B_high_high;
    assign High[14] = notB[6] ~| _notPA_Select_B_high_high;
    assign High[15] = notB[7] ~| _notPA_Select_B_high_high;
    assign Low[8] = notB[0] ~| _notPA_Select_B_low_high;
    assign Low[9] = notB[1] ~| _notPA_Select_B_low_high;
    assign Low[10] = notB[2] ~| _notPA_Select_B_low_high;
    assign Low[11] = notB[3] ~| _notPA_Select_B_low_high;
    assign Low[12] = notB[4] ~| _notPA_Select_B_low_high;
    assign Low[13] = notB[5] ~| _notPA_Select_B_low_high;
    assign Low[14] = notB[6] ~| _notPA_Select_B_low_high;
    assign Low[15] = notB[7] ~| _notPA_Select_B_low_high;

    wire _high_B0 = notB[0] ~| notPA_Select_B_high;
    wire _high_B1 = notB[1] ~| notPA_Select_B_high;
    wire _high_B2 = notB[2] ~| notPA_Select_B_high;
    wire _high_B3 = notB[3] ~| notPA_Select_B_high;
    wire _high_B4 = notB[4] ~| notPA_Select_B_high;
    wire _high_B5 = notB[5] ~| notPA_Select_B_high;
    wire _high_B6 = notB[6] ~| notPA_Select_B_high;
    wire _high_B7 = notB[7] ~| notPA_Select_B_high;
    wire _high_C0 = notC[0] ~| _notPA_Select_C_high_low;
    wire _high_C1 = notC[1] ~| _notPA_Select_C_high_low;
    wire _high_C2 = notC[2] ~| _notPA_Select_C_high_low;
    wire _high_C3 = notC[3] ~| _notPA_Select_C_high_low;
    wire _high_C4 = notC[4] ~| _notPA_Select_C_high_low;
    wire _high_C5 = notC[5] ~| _notPA_Select_C_high_low;
    wire _high_C6 = notC[6] ~| _notPA_Select_C_high_low;
    wire _high_C7 = notC[7] ~| _notPA_Select_C_high_low;
    wire _low_B0 = notB[0] ~| notPA_Select_B_low;
    wire _low_B1 = notB[1] ~| notPA_Select_B_low;
    wire _low_B2 = notB[2] ~| notPA_Select_B_low;
    wire _low_B3 = notB[3] ~| notPA_Select_B_low;
    wire _low_B4 = notB[4] ~| notPA_Select_B_low;
    wire _low_B5 = notB[5] ~| notPA_Select_B_low;
    wire _low_B6 = notB[6] ~| notPA_Select_B_low;
    wire _low_B7 = notB[7] ~| notPA_Select_B_low;
    wire _low_C0 = notC[0] ~| _notPA_Select_C_low_low;
    wire _low_C1 = notC[1] ~| _notPA_Select_C_low_low;
    wire _low_C2 = notC[2] ~| _notPA_Select_C_low_low;
    wire _low_C3 = notC[3] ~| _notPA_Select_C_low_low;
    wire _low_C4 = notC[4] ~| _notPA_Select_C_low_low;
    wire _low_C5 = notC[5] ~| _notPA_Select_C_low_low;
    wire _low_C6 = notC[6] ~| _notPA_Select_C_low_low;
    wire _low_C7 = notC[7] ~| _notPA_Select_C_low_low;

    wire _notHigh0 = _high_B0 ~| _high_C0;
    wire _notHigh1 = _high_B1 ~| _high_C1;
    wire _notHigh2 = _high_B2 ~| _high_C2;
    wire _notHigh3 = _high_B3 ~| _high_C3;
    wire _notHigh4 = _high_B4 ~| _high_C4;
    wire _notHigh5 = _high_B5 ~| _high_C5;
    wire _notHigh6 = _high_B6 ~| _high_C6;
    wire _notHigh7 = _high_B7 ~| _high_C7;
    wire _notLow0 = _low_B0 ~| _low_C0;
    wire _notLow1 = _low_B1 ~| _low_C1;
    wire _notLow2 = _low_B2 ~| _low_C2;
    wire _notLow3 = _low_B3 ~| _low_C3;
    wire _notLow4 = _low_B4 ~| _low_C4;
    wire _notLow5 = _low_B5 ~| _low_C5;
    wire _notLow6 = _low_B6 ~| _low_C6;
    wire _notLow7 = _low_B7 ~| _low_C7;

    assign High[0] = _notHigh0 ~| _notHigh0;
    assign High[1] = _notHigh1 ~| _notHigh1;
    assign High[2] = _notHigh2 ~| _notHigh2;
    assign High[3] = _notHigh3 ~| _notHigh3;
    assign High[4] = _notHigh4 ~| _notHigh4;
    assign High[5] = _notHigh5 ~| _notHigh5;
    assign High[6] = _notHigh6 ~| _notHigh6;
    assign High[7] = _notHigh7 ~| _notHigh7;
    assign Low[0] = _notLow0 ~| _notLow0;
    assign Low[1] = _notLow1 ~| _notLow1;
    assign Low[2] = _notLow2 ~| _notLow2;
    assign Low[3] = _notLow3 ~| _notLow3;
    assign Low[4] = _notLow4 ~| _notLow4;
    assign Low[5] = _notLow5 ~| _notLow5;
    assign Low[6] = _notLow6 ~| _notLow6;
    assign Low[7] = _notLow7 ~| _notLow7;

endmodule