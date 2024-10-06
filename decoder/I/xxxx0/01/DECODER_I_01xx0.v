// 5(161)
module DECODER_I_01xx0(
        input wire enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire P2_Set_CMR,
        output wire P2_Set_ILDddnn_BC_1,
        output wire P2_Set_ILDddnn_DE_1,
        output wire P2_Set_ILDddnn_HL_1,
        output wire P2_Set_ILDddnn_SP_1,
        output wire PR_Write_C,
        output wire PR_Write_E,
        output wire PR_Write_L,
        output wire PR_Write_SP_low,
        output wire PR_Reset_XPT,
        output wire P2_Set_CM1, // <
        output wire P2_Reset_ITABLE,
        output wire Pa_Ophd, // >
        output wire PR_InvertIn,
        output wire PR_Write_B,
        output wire PR_Write_D,
        output wire PR_Write_H,
        output wire PR_Write_SP_high,
        output wire P2_Set_ILDddlnnl_BC_1,
        output wire P2_Set_ILDddlnnl_DE_1,
        output wire P2_Set_ILDddlnnl_HL_1,
        output wire P2_Set_ILDddlnnl_SP_1,
        output wire PI_SelectAd_OPOPold,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PI_SelectAdt1,
        output wire PA_Select_IX_high,
        output wire PA_Select_IY_high,
        output wire PA_Select_OP_low, // <
        output wire PA_ADD,
        output wire PR_Write_Dt,
        output wire PR_Write_Dtex, // >
        output wire PI_SelectAd_DtexDt,
        output wire PI_SelectDt_A,
        output wire PI_SelectDt_B,
        output wire PI_SelectDt_C,
        output wire PI_SelectDt_D,
        output wire PI_SelectDt_E,
        output wire PI_SelectDt_H,
        output wire PI_SelectDt_L,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _010x0xxx;
    wire _011x0xxx;

    DECODER_1bit_decoder d_01dx0xxx(
        .notEnable(_not_enable),
        .In(ITABLE[5]),
        .notIn(notITABLE[5]),
        .out0(_010x0xxx),
        .out1(_011x0xxx)
    );

    wire _PR_Reset_XPT_0; // <
    wire _P2_Set_CM1_0;
    wire _P2_Reset_ITABLE_0;
    wire _Pa_Ophd_0; // >

    DECODER_I_010x0 d010x0(
        .enable(_010x0xxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .PA_Select_IX_high(PA_Select_IX_high),
        .PA_Select_IY_high(PA_Select_IY_high),
        .PA_Select_OP_low(PA_Select_OP_low), // <
        .PA_ADD(PA_ADD),
        .PR_Write_Dt(PR_Write_Dt),
        .PR_Write_Dtex(PR_Write_Dtex), // >
        .PI_SelectAd_DtexDt(PI_SelectAd_DtexDt),
        .PI_SelectDt_A(PI_SelectDt_A),
        .PI_SelectDt_B(PI_SelectDt_B),
        .PI_SelectDt_C(PI_SelectDt_C),
        .PI_SelectDt_D(PI_SelectDt_D),
        .PI_SelectDt_E(PI_SelectDt_E),
        .PI_SelectDt_H(PI_SelectDt_H),
        .PI_SelectDt_L(PI_SelectDt_L),
        .PC_W0(PC_W0),
        .PC_W1(PC_W1),
        .PC_W2(PC_W2),
        .PR_Reset_XPT(_PR_Reset_XPT_0), // <
        .P2_Set_CM1(_P2_Set_CM1_0),
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_0),
        .Pa_Ophd(_Pa_Ophd_0) // >
    );

    wire _PR_Reset_XPT_1;
    wire _P2_Set_CM1_1; // <
    wire _P2_Reset_ITABLE_1;
    wire _Pa_Ophd_1; // >

    DECODER_I_011x0 d011x0(
        .enable(_011x0xxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .P2_Set_CMR(P2_Set_CMR),
        .P2_Set_ILDddnn_BC_1(P2_Set_ILDddnn_BC_1),
        .P2_Set_ILDddnn_DE_1(P2_Set_ILDddnn_DE_1),
        .P2_Set_ILDddnn_HL_1(P2_Set_ILDddnn_HL_1),
        .P2_Set_ILDddnn_SP_1(P2_Set_ILDddnn_SP_1),
        .PR_Write_C(PR_Write_C),
        .PR_Write_E(PR_Write_E),
        .PR_Write_L(PR_Write_L),
        .PR_Write_SP_low(PR_Write_SP_low),
        .PR_Reset_XPT(_PR_Reset_XPT_1),
        .P2_Set_CM1(_P2_Set_CM1_1), // <
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_1),
        .PR_InvertIn(PR_InvertIn),
        .Pa_Ophd(_Pa_Ophd_1), // >
        .PR_Write_B(PR_Write_B),
        .PR_Write_D(PR_Write_D),
        .PR_Write_H(PR_Write_H),
        .PR_Write_SP_high(PR_Write_SP_high),
        .P2_Set_ILDddlnnl_BC_1(P2_Set_ILDddlnnl_BC_1),
        .P2_Set_ILDddlnnl_DE_1(P2_Set_ILDddlnnl_DE_1),
        .P2_Set_ILDddlnnl_HL_1(P2_Set_ILDddlnnl_HL_1),
        .P2_Set_ILDddlnnl_SP_1(P2_Set_ILDddlnnl_SP_1),
        .PI_SelectAd_OPOPold(PI_SelectAd_OPOPold),
        .PC_R0(PC_R0),
        .PC_R1(PC_R1),
        .PC_R2(PC_R2),
        .PI_SelectAdt1(PI_SelectAdt1)
    );

    assign PR_Reset_XPT = (_PR_Reset_XPT_0 | _PR_Reset_XPT_1); // 2
    assign P2_Set_CM1 = (_P2_Set_CM1_0 | _P2_Set_CM1_1); // 2
    assign P2_Reset_ITABLE = P2_Set_CM1;
    assign Pa_Ophd = P2_Set_CM1;

endmodule