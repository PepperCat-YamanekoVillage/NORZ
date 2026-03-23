// ケーブル削減のため、レジスタ基板に搭載することになると思う
// SP/IX/IYも同じ
// 32
module ALU_input_mux_PC(
        input wire [15:0] notPC,
        input wire notPA_Select_PC_high,
        input wire notPA_Select_PC_low,
        output wire [15:0] High,
        output wire [15:0] Low
    );

    assign High[0] = notPC[0] ~| notPA_Select_PC_high;
    assign High[1] = notPC[1] ~| notPA_Select_PC_high;
    assign High[2] = notPC[2] ~| notPA_Select_PC_high;
    assign High[3] = notPC[3] ~| notPA_Select_PC_high;
    assign High[4] = notPC[4] ~| notPA_Select_PC_high;
    assign High[5] = notPC[5] ~| notPA_Select_PC_high;
    assign High[6] = notPC[6] ~| notPA_Select_PC_high;
    assign High[7] = notPC[7] ~| notPA_Select_PC_high;
    assign High[8] = notPC[8] ~| notPA_Select_PC_high;
    assign High[9] = notPC[9] ~| notPA_Select_PC_high;
    assign High[10] = notPC[10] ~| notPA_Select_PC_high;
    assign High[11] = notPC[11] ~| notPA_Select_PC_high;
    assign High[12] = notPC[12] ~| notPA_Select_PC_high;
    assign High[13] = notPC[13] ~| notPA_Select_PC_high;
    assign High[14] = notPC[14] ~| notPA_Select_PC_high;
    assign High[15] = notPC[15] ~| notPA_Select_PC_high;
    assign Low[0] = notPC[0] ~| notPA_Select_PC_low;
    assign Low[1] = notPC[1] ~| notPA_Select_PC_low;
    assign Low[2] = notPC[2] ~| notPA_Select_PC_low;
    assign Low[3] = notPC[3] ~| notPA_Select_PC_low;
    assign Low[4] = notPC[4] ~| notPA_Select_PC_low;
    assign Low[5] = notPC[5] ~| notPA_Select_PC_low;
    assign Low[6] = notPC[6] ~| notPA_Select_PC_low;
    assign Low[7] = notPC[7] ~| notPA_Select_PC_low;
    assign Low[8] = notPC[8] ~| notPA_Select_PC_low;
    assign Low[9] = notPC[9] ~| notPA_Select_PC_low;
    assign Low[10] = notPC[10] ~| notPA_Select_PC_low;
    assign Low[11] = notPC[11] ~| notPA_Select_PC_low;
    assign Low[12] = notPC[12] ~| notPA_Select_PC_low;
    assign Low[13] = notPC[13] ~| notPA_Select_PC_low;
    assign Low[14] = notPC[14] ~| notPA_Select_PC_low;
    assign Low[15] = notPC[15] ~| notPA_Select_PC_low;

endmodule