// 23(105)
module DECODER_I_011x0(
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
        output wire PR_InvertIn,
        output wire Pa_Ophd, // >
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
        output wire PI_SelectAdt1
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

    wire _P2_Set_CMR_0;
    wire _PR_Write_C_0;
    wire _PR_Write_E_0;
    wire _PR_Write_L_0;
    wire _PR_Write_SP_low_0;
    wire _PR_Reset_XPT_0;
    wire _P2_Set_CM1_0; // <
    wire _P2_Reset_ITABLE_0;
    wire _PR_InvertIn_0;
    wire _Pa_Ophd_0; // >
    wire _PR_Write_B_0;
    wire _PR_Write_D_0;
    wire _PR_Write_H_0;
    wire _PR_Write_SP_high_0;

    DECODER_I_01100 d_01100xxx(
        .enable(_010x0xxx),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .P2_Set_CMR(_P2_Set_CMR_0),
        .P2_Set_ILDddnn_BC_1(P2_Set_ILDddnn_BC_1),
        .P2_Set_ILDddnn_DE_1(P2_Set_ILDddnn_DE_1),
        .P2_Set_ILDddnn_HL_1(P2_Set_ILDddnn_HL_1),
        .P2_Set_ILDddnn_SP_1(P2_Set_ILDddnn_SP_1),
        .PR_Write_C(_PR_Write_C_0),
        .PR_Write_E(_PR_Write_E_0),
        .PR_Write_L(_PR_Write_L_0),
        .PR_Write_SP_low(_PR_Write_SP_low_0),
        .PR_Reset_XPT(_PR_Reset_XPT_0),
        .P2_Set_CM1(_P2_Set_CM1_0), // <
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_0),
        .PR_InvertIn(_PR_InvertIn_0),
        .Pa_Ophd(_Pa_Ophd_0), // >
        .PR_Write_B(_PR_Write_B_0),
        .PR_Write_D(_PR_Write_D_0),
        .PR_Write_H(_PR_Write_H_0),
        .PR_Write_SP_high(_PR_Write_SP_high_0)
    );

    wire _P2_Set_CMR_1;
    wire _PR_Write_C_1;
    wire _PR_Write_E_1;
    wire _PR_Write_L_1;
    wire _PR_Write_SP_low_1;
    wire _PR_Reset_XPT_1;
    wire _P2_Set_CM1_1; // <
    wire _P2_Reset_ITABLE_1;
    wire _PR_InvertIn_1;
    wire _Pa_Ophd_1; // >
    wire _PR_Write_B_1;
    wire _PR_Write_D_1;
    wire _PR_Write_H_1;
    wire _PR_Write_SP_high_1;

    DECODER_I_01110 d_01110xxx(
        .enable(_011x0xxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .P2_Set_CMR(_P2_Set_CMR_1),
        .P2_Set_ILDddlnnl_BC_1(P2_Set_ILDddlnnl_BC_1),
        .P2_Set_ILDddlnnl_DE_1(P2_Set_ILDddlnnl_DE_1),
        .P2_Set_ILDddlnnl_HL_1(P2_Set_ILDddlnnl_HL_1),
        .P2_Set_ILDddlnnl_SP_1(P2_Set_ILDddlnnl_SP_1),
        .PR_Reset_XPT(_PR_Reset_XPT_1),
        .PI_SelectAd_OPOPold(PI_SelectAd_OPOPold),
        .PC_R0(PC_R0),
        .PC_R1(PC_R1),
        .PC_R2(PC_R2),
        .PR_Write_C(_PR_Write_C_1),
        .PR_Write_E(_PR_Write_E_1),
        .PR_Write_L(_PR_Write_L_1),
        .PR_Write_SP_low(_PR_Write_SP_low_1),
        .PI_SelectAdt1(PI_SelectAdt1),
        .P2_Set_CM1(_P2_Set_CM1_1), // <
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_1),
        .PR_InvertIn(_PR_InvertIn_1),
        .Pa_Ophd(_Pa_Ophd_1), // >
        .PR_Write_B(_PR_Write_B_1),
        .PR_Write_D(_PR_Write_D_1),
        .PR_Write_H(_PR_Write_H_1),
        .PR_Write_SP_high(_PR_Write_SP_high_1)
    );

    assign P2_Set_CMR = (_P2_Set_CMR_0 | _P2_Set_CMR_1); // 2
    assign PR_Write_C = (_PR_Write_C_0 | _PR_Write_C_1); // 2
    assign PR_Write_E = (_PR_Write_E_0 | _PR_Write_E_1); // 2
    assign PR_Write_L = (_PR_Write_L_0 | _PR_Write_L_1); // 2
    assign PR_Write_SP_low = (_PR_Write_SP_low_0 | _PR_Write_SP_low_1); // 2
    assign PR_Reset_XPT = (_PR_Reset_XPT_0 | _PR_Reset_XPT_1); // 2
    assign P2_Set_CM1 = (_P2_Set_CM1_0 | _P2_Set_CM1_1); // 2
    assign P2_Reset_ITABLE = P2_Set_CM1;
    assign PR_InvertIn = P2_Set_CM1;
    assign Pa_Ophd = P2_Set_CM1;
    assign PR_Write_B = (_PR_Write_B_0 | _PR_Write_B_1); // 2
    assign PR_Write_D = (_PR_Write_D_0 | _PR_Write_D_1); // 2
    assign PR_Write_H = (_PR_Write_H_0 | _PR_Write_H_1); // 2
    assign PR_Write_SP_high = (_PR_Write_SP_high_0 | _PR_Write_SP_high_1); // 2

endmodule