// 3(36)
module DECODER_op_X1_00xxx010(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire PR_Reset_XPT,
        output wire P2_Set_CM1, // <
        output wire Pa_Ophd, // >
        output wire PI_SelectAd_BC,
        output wire PI_SelectAd_DE,
        output wire PI_SelectDt_A,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PR_Write_A, // <
        output wire PR_InvertIn, // >
        output wire P2_Set_CMR,
        output wire P2_Set_ILDlnnlHL_0,
        output wire P2_Set_ILDHLlnnl_0,
        output wire P2_Set_ILDlnnlA_0,
        output wire P2_Set_ILDAlnnl_0
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _000xx010;
    wire _001xx010;

    DECODER_1bit_decoder d_00dxx010(
        .notEnable(_not_enable),
        .In(Source[5]),
        .notIn(notSource[5]),
        .out0(_000xx010),
        .out1(_001xx010)
    );

    wire _PR_Reset_XPT_0;

    DECODER_op_X1_000xx010 d000xx010(
        .enable(_000xx010),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_0), // <
        .P2_Set_CM1(P2_Set_CM1),
        .Pa_Ophd(Pa_Ophd), // >
        .PI_SelectAd_BC(PI_SelectAd_BC),
        .PI_SelectAd_DE(PI_SelectAd_DE),
        .PI_SelectDt_A(PI_SelectDt_A),
        .PC_R0(PC_R0),
        .PC_R1(PC_R1),
        .PC_R2(PC_R2),
        .PC_W0(PC_W0),
        .PC_W1(PC_W1),
        .PC_W2(PC_W2),
        .PR_Write_A(PR_Write_A), // <
        .PR_InvertIn(PR_InvertIn) // >
    );

    wire _PR_Reset_XPT_1;

    DECODER_op_X1_001xx010 d001xx010(
        .enable(_001xx010),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_1), // <
        .P2_Set_CMR(P2_Set_CMR), // >
        .P2_Set_ILDlnnlHL_0(P2_Set_ILDlnnlHL_0),
        .P2_Set_ILDHLlnnl_0(P2_Set_ILDHLlnnl_0),
        .P2_Set_ILDlnnlA_0(P2_Set_ILDlnnlA_0),
        .P2_Set_ILDAlnnl_0(P2_Set_ILDAlnnl_0)
    );

    assign PR_Reset_XPT = (_PR_Reset_XPT_0 | _PR_Reset_XPT_1); // 2


endmodule