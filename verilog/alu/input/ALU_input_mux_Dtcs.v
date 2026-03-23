// Dinも同じ
// 8
module ALU_input_mux_Dtcs(
        input wire [7:0] notDtcs,
        input wire notPA_Select_Dtcs_low,
        output wire [7:0] Low
    );

    assign Low[0] = notDtcs[0] ~| notPA_Select_Dtcs_low;
    assign Low[1] = notDtcs[1] ~| notPA_Select_Dtcs_low;
    assign Low[2] = notDtcs[2] ~| notPA_Select_Dtcs_low;
    assign Low[3] = notDtcs[3] ~| notPA_Select_Dtcs_low;
    assign Low[4] = notDtcs[4] ~| notPA_Select_Dtcs_low;
    assign Low[5] = notDtcs[5] ~| notPA_Select_Dtcs_low;
    assign Low[6] = notDtcs[6] ~| notPA_Select_Dtcs_low;
    assign Low[7] = notDtcs[7] ~| notPA_Select_Dtcs_low;

endmodule