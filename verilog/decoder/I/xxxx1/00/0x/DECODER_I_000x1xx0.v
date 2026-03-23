// 3(18)
module DECODER_I_000x1xx0(
        input wire enable,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire PR_Reset_XPT,
        output wire P2_Set_CMR,
        output wire PR_Write_IX_low,
        output wire PR_Write_IY_low,
        output wire P2_Set_ILDlnnlA_1,
        output wire P2_Set_ILDIXnn_1,
        output wire P2_Set_ILDHLlnnl_1,
        output wire P2_Set_ILDIYnn_1,
        output wire P2_Set_ILDIXlnnl_1,
        output wire P2_Set_ILDIYlnnl_1,
        output wire P2_Set_ICALLnn_1
    );

    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _00001xx0;
    wire _00011xx0;

    DECODER_1bit_decoder d_000d1xx0(
        .notEnable(_not_enable),
        .In(ITABLE[4]),
        .notIn(notITABLE[4]),
        .out0(_00001xx0),
        .out1(_00011xx0)
    );

    wire _not00001xx0 = _00001xx0 ~| _00001xx0;
    wire _not00011xx0 = _00011xx0 ~| _00011xx0;

    DECODER_2bit_decoder d_00001dd0( // 8
        .notEnable(_not00001xx0),
        .In(ITABLE[2:1]),
        .notIn(notITABLE[2:1]),
        .out00(P2_Set_ILDlnnlA_1),
        .out01(P2_Set_ILDIXnn_1),
        .out10(P2_Set_ILDHLlnnl_1),
        .out11(P2_Set_ILDIYnn_1)
    );

    DECODER_2bit_decoder d_00011dd0( // 5
        .notEnable(_not00011xx0),
        .In(ITABLE[2:1]),
        .notIn(notITABLE[2:1]),
        .out0x(P2_Set_ILDIXlnnl_1),
        .out10(P2_Set_ICALLnn_1),
        .out11(P2_Set_ILDIYlnnl_1)
    );

    assign PR_Write_IX_low = P2_Set_ILDIXnn_1;
    assign PR_Write_IY_low = P2_Set_ILDIYnn_1;

    assign PR_Reset_XPT = enable;
    assign P2_Set_CMR = enable;

endmodule