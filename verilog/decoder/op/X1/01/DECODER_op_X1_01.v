// HALTを除く
// 36(128)
module DECODER_op_X1_01(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire PI_SelectAd_HL,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd, // >
        output wire PR_Write_B,
        output wire PR_Write_C,
        output wire PR_Write_D,
        output wire PR_Write_E,
        output wire PR_Write_H,
        output wire PR_Write_L,
        output wire PR_Write_A,
        output wire PR_InvertIn,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PI_SelectDt_B,
        output wire PI_SelectDt_C,
        output wire PI_SelectDt_D,
        output wire PI_SelectDt_E,
        output wire PI_SelectDt_H,
        output wire PI_SelectDt_L,
        output wire PI_SelectDt_A,
        output wire PA_NOP,
        output wire PA_Select_B_low,
        output wire PA_Select_C_low,
        output wire PA_Select_D_low,
        output wire PA_Select_E_low,
        output wire PA_Select_H_low,
        output wire PA_Select_L_low,
        output wire PA_Select_A_low
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _01xxx110 = ~(_not_enable | notSource[2] | notSource[1] | Source[0]); // 5
    wire _01110xxx = ~(_not_enable | notSource[5] | notSource[4] | Source[3]); // 5
    wire _01other = ~(_not_enable | _01xxx110 | _01110xxx); // 3

    wire _PI_SelectAd_HL_L110;
    wire _PR_Reset_XPT_L110; // <
    wire _P2_Set_CM1_L110;
    wire _Pa_Ophd_L110; // >
    wire _PR_Write_B_L110;
    wire _PR_Write_C_L110;
    wire _PR_Write_D_L110;
    wire _PR_Write_E_L110;
    wire _PR_Write_H_L110;
    wire _PR_Write_L_L110;
    wire _PR_Write_A_L110;
    wire _PR_InvertIn_L110;

    DECODER_op_X1_01xxx110 d01xxx110(
        .enable(_01xxx110),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PI_SelectAd_HL(_PI_SelectAd_HL_L110),
        .PC_R0(PC_R0),
        .PC_R1(PC_R1),
        .PC_R2(PC_R2),
        .PR_Reset_XPT(_PR_Reset_XPT_L110), // <
        .P2_Set_CM1(_P2_Set_CM1_L110),
        .Pa_Ophd(_Pa_Ophd_L110), // >
        .PR_Write_B(_PR_Write_B_L110),
        .PR_Write_C(_PR_Write_C_L110),
        .PR_Write_D(_PR_Write_D_L110),
        .PR_Write_E(_PR_Write_E_L110),
        .PR_Write_H(_PR_Write_H_L110),
        .PR_Write_L(_PR_Write_L_L110),
        .PR_Write_A(_PR_Write_A_L110),
        .PR_InvertIn(_PR_InvertIn_L110)
    );

    wire _PI_SelectAd_HL_U110;
    wire _PR_Reset_XPT_U110; // <
    wire _P2_Set_CM1_U110;
    wire _Pa_Ophd_U110; // >

    DECODER_op_X1_01110xxx d01110xxx(
        .enable(_01110xxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PI_SelectAd_HL(_PI_SelectAd_HL_U110),
        .PC_W0(PC_W0),
        .PC_W1(PC_W1),
        .PC_W2(PC_W2),
        .PR_Reset_XPT(_PR_Reset_XPT_U110), // <
        .P2_Set_CM1(_P2_Set_CM1_U110),
        .Pa_Ophd(_Pa_Ophd_U110), // >
        .PI_SelectDt_B(PI_SelectDt_B),
        .PI_SelectDt_C(PI_SelectDt_C),
        .PI_SelectDt_D(PI_SelectDt_D),
        .PI_SelectDt_E(PI_SelectDt_E),
        .PI_SelectDt_H(PI_SelectDt_H),
        .PI_SelectDt_L(PI_SelectDt_L),
        .PI_SelectDt_A(PI_SelectDt_A)
    );

    wire _PR_Reset_XPT_otr; // <
    wire _P2_Set_CM1_otr;
    wire _Pa_Ophd_otr; // >
    wire _PR_Write_B_otr;
    wire _PR_Write_C_otr;
    wire _PR_Write_D_otr;
    wire _PR_Write_E_otr;
    wire _PR_Write_H_otr;
    wire _PR_Write_L_otr;
    wire _PR_Write_A_otr;
    wire _PR_InvertIn_otr;

    DECODER_op_X1_01other d01other(
        .enable(_01other),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_otr), // <
        .P2_Set_CM1(_P2_Set_CM1_otr),
        .Pa_Ophd(_Pa_Ophd_otr),
        .PA_NOP(PA_NOP), // >
        .PA_Select_B_low(PA_Select_B_low),
        .PA_Select_C_low(PA_Select_C_low),
        .PA_Select_D_low(PA_Select_D_low),
        .PA_Select_E_low(PA_Select_E_low),
        .PA_Select_H_low(PA_Select_H_low),
        .PA_Select_L_low(PA_Select_L_low),
        .PA_Select_A_low(PA_Select_A_low),
        .PR_Write_B(_PR_Write_B_otr),
        .PR_Write_C(_PR_Write_C_otr),
        .PR_Write_D(_PR_Write_D_otr),
        .PR_Write_E(_PR_Write_E_otr),
        .PR_Write_H(_PR_Write_H_otr),
        .PR_Write_L(_PR_Write_L_otr),
        .PR_Write_A(_PR_Write_A_otr),
        .PR_InvertIn(_PR_InvertIn_otr)
    );

    assign PR_Reset_XPT = (_PR_Reset_XPT_L110 | _PR_Reset_XPT_U110 | _PR_Reset_XPT_otr); // 4
    assign P2_Set_CM1 = PR_Reset_XPT;
    assign Pa_Ophd = PR_Reset_XPT;

    assign PI_SelectAd_HL = (_PI_SelectAd_HL_L110 | _PI_SelectAd_HL_U110); // 2
    assign PR_Write_B = (_PR_Write_B_L110 | _PR_Write_B_otr); // 2
    assign PR_Write_C = (_PR_Write_C_L110 | _PR_Write_C_otr); // 2
    assign PR_Write_D = (_PR_Write_D_L110 | _PR_Write_D_otr); // 2
    assign PR_Write_E = (_PR_Write_E_L110 | _PR_Write_E_otr); // 2
    assign PR_Write_H = (_PR_Write_H_L110 | _PR_Write_H_otr); // 2
    assign PR_Write_L = (_PR_Write_L_L110 | _PR_Write_L_otr); // 2
    assign PR_Write_A = (_PR_Write_A_L110 | _PR_Write_A_otr); // 2
    assign PR_InvertIn = (_PR_InvertIn_L110 | _PR_InvertIn_otr); // 2

endmodule