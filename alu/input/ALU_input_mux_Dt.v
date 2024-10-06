// ケーブル削減のため、レジスタ基板に搭載することになると思う
// 16
module ALU_input_mux_Dt(
        input wire [7:0] notDt,
        input wire notPA_Select_Dt_high,
        input wire notPA_Select_Dt_low,
        output wire [7:0] High,
        output wire [7:0] Low
    );

    assign High[0] = notDt[0] ~| notPA_Select_Dt_high;
    assign High[1] = notDt[1] ~| notPA_Select_Dt_high;
    assign High[2] = notDt[2] ~| notPA_Select_Dt_high;
    assign High[3] = notDt[3] ~| notPA_Select_Dt_high;
    assign High[4] = notDt[4] ~| notPA_Select_Dt_high;
    assign High[5] = notDt[5] ~| notPA_Select_Dt_high;
    assign High[6] = notDt[6] ~| notPA_Select_Dt_high;
    assign High[7] = notDt[7] ~| notPA_Select_Dt_high;
    assign Low[0] = notDt[0] ~| notPA_Select_Dt_low;
    assign Low[1] = notDt[1] ~| notPA_Select_Dt_low;
    assign Low[2] = notDt[2] ~| notPA_Select_Dt_low;
    assign Low[3] = notDt[3] ~| notPA_Select_Dt_low;
    assign Low[4] = notDt[4] ~| notPA_Select_Dt_low;
    assign Low[5] = notDt[5] ~| notPA_Select_Dt_low;
    assign Low[6] = notDt[6] ~| notPA_Select_Dt_low;
    assign Low[7] = notDt[7] ~| notPA_Select_Dt_low;

endmodule