// ケーブル削減のため、レジスタ基板に搭載することになると思う
// 40
module ALU_input_mux_AF(
        input wire [7:0] notA,
        input wire [7:0] notF,
        input wire notPA_Select_A_high,
        input wire notPA_Select_A_low,
        input wire notPA_Select_F_low,
        output wire [7:0] High,
        output wire [7:0] Low
    );

    assign High[0] = notA[0] ~| notPA_Select_A_high;
    assign High[1] = notA[1] ~| notPA_Select_A_high;
    assign High[2] = notA[2] ~| notPA_Select_A_high;
    assign High[3] = notA[3] ~| notPA_Select_A_high;
    assign High[4] = notA[4] ~| notPA_Select_A_high;
    assign High[5] = notA[5] ~| notPA_Select_A_high;
    assign High[6] = notA[6] ~| notPA_Select_A_high;
    assign High[7] = notA[7] ~| notPA_Select_A_high;

    wire _LowA0 = notA[0] ~| notPA_Select_A_low;
    wire _LowA1 = notA[1] ~| notPA_Select_A_low;
    wire _LowA2 = notA[2] ~| notPA_Select_A_low;
    wire _LowA3 = notA[3] ~| notPA_Select_A_low;
    wire _LowA4 = notA[4] ~| notPA_Select_A_low;
    wire _LowA5 = notA[5] ~| notPA_Select_A_low;
    wire _LowA6 = notA[6] ~| notPA_Select_A_low;
    wire _LowA7 = notA[7] ~| notPA_Select_A_low;

    wire _LowF0 = notF[0] ~| notPA_Select_F_low;
    wire _LowF1 = notF[1] ~| notPA_Select_F_low;
    wire _LowF2 = notF[2] ~| notPA_Select_F_low;
    wire _LowF3 = notF[3] ~| notPA_Select_F_low;
    wire _LowF4 = notF[4] ~| notPA_Select_F_low;
    wire _LowF5 = notF[5] ~| notPA_Select_F_low;
    wire _LowF6 = notF[6] ~| notPA_Select_F_low;
    wire _LowF7 = notF[7] ~| notPA_Select_F_low;

    wire _notLow0 = _LowA0 ~| _LowF0;
    wire _notLow1 = _LowA1 ~| _LowF1;
    wire _notLow2 = _LowA2 ~| _LowF2;
    wire _notLow3 = _LowA3 ~| _LowF3;
    wire _notLow4 = _LowA4 ~| _LowF4;
    wire _notLow5 = _LowA5 ~| _LowF5;
    wire _notLow6 = _LowA6 ~| _LowF6;
    wire _notLow7 = _LowA7 ~| _LowF7;

    assign Low[0] = _notLow0 ~| _notLow0;
    assign Low[1] = _notLow1 ~| _notLow1;
    assign Low[2] = _notLow2 ~| _notLow2;
    assign Low[3] = _notLow3 ~| _notLow3;
    assign Low[4] = _notLow4 ~| _notLow4;
    assign Low[5] = _notLow5 ~| _notLow5;
    assign Low[6] = _notLow6 ~| _notLow6;
    assign Low[7] = _notLow7 ~| _notLow7;

endmodule