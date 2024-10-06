// 3(73)
module DECODER_op_XOTR_01xxx11(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_XOTR,
        output wire Pa_Ophd, // >
        output wire P2_IM0,
        output wire P2_IM1,
        output wire P2_IM2,
        output wire PA_Select_A_low,
        output wire PA_NOP,
        output wire PR_Write_I,
        output wire PR_InvertIn,
        output wire PR_Write_R,
        output wire PR_Write_A, // <
        output wire PF_Write_Z,
        output wire PF_Write_PV,
        output wire PF_Write_S,
        output wire PF_Write_N,
        output wire PF_Write_H,
        output wire PF_Select_S_bit7,
        output wire PF_Select_N_bit16,
        output wire PF_Select_H_bit16, // >
        output wire PF_Select_Z_bit19,
        output wire PF_Select_PV_bit18,
        output wire PA_Select_I_low,
        output wire PA_Select_R_low,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_Write_Dt,
        output wire PA_Select_Dt_high,
        output wire PF_Select_Z_bit24,
        output wire PF_Select_PV_bit27,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PI_SelectDt_Dt,
        output wire PI_SelectAd_HL,
        output wire PA_RRD,
        output wire PA_RLD
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _01xxx110;
    wire _01xxx111;

    DECODER_1bit_decoder d_01xxx11d(
        .notEnable(_not_enable),
        .In(Source[0]),
        .notIn(notSource[0]),
        .out0(_01xxx110),
        .out1(_01xxx111),
    );

    wire _PR_Reset_XPT_0; // <
    wire _P2_Set_CM1_0;
    wire _P2_Reset_XOTR_0;
    wire _Pa_Ophd_0; // >

    DECODER_op_XOTR_01xxx110 d01xxx110(
        .enable(_01xxx110),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_0), // <
        .P2_Set_CM1(_P2_Set_CM1_0),
        .P2_Reset_XOTR(_P2_Reset_XOTR_0),
        .Pa_Ophd(_Pa_Ophd_0), // >
        .P2_IM0(P2_IM0),
        .P2_IM1(P2_IM1),
        .P2_IM2(P2_IM2)
    );

    wire _PR_Reset_XPT_1; // <
    wire _P2_Set_CM1_1;
    wire _P2_Reset_XOTR_1;
    wire _Pa_Ophd_1; // >

    DECODER_op_XOTR_01xxx111 d01xxx111(
        .enable(_01xxx111),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_1), // <
        .P2_Set_CM1(_P2_Set_CM1_1),
        .P2_Reset_XOTR(_P2_Reset_XOTR_1),
        .Pa_Ophd(_Pa_Ophd_1), // >
        .PA_Select_A_low(PA_Select_A_low),
        .PA_NOP(PA_NOP),
        .PR_Write_I(PR_Write_I),
        .PR_InvertIn(PR_InvertIn),
        .PR_Write_R(PR_Write_R),
        .PR_Write_A(PR_Write_A), // <
        .PF_Write_Z(PF_Write_Z),
        .PF_Write_PV(PF_Write_PV),
        .PF_Write_S(PF_Write_S),
        .PF_Write_N(PF_Write_N),
        .PF_Write_H(PF_Write_H),
        .PF_Select_S_bit7(PF_Select_S_bit7),
        .PF_Select_N_bit16(PF_Select_N_bit16),
        .PF_Select_H_bit16(PF_Select_H_bit16), // >
        .PF_Select_Z_bit19(PF_Select_Z_bit19),
        .PF_Select_PV_bit18(PF_Select_PV_bit18),
        .PA_Select_I_low(PA_Select_I_low),
        .PA_Select_R_low(PA_Select_R_low),
        .PC_R0(PC_R0),
        .PC_R1(PC_R1),
        .PC_R2(PC_R2),
        .PR_Write_Dt(PR_Write_Dt),
        .PA_Select_Dt_high(PA_Select_Dt_high),
        .PF_Select_Z_bit24(PF_Select_Z_bit24),
        .PF_Select_PV_bit27(PF_Select_PV_bit27),
        .PC_W0(PC_W0),
        .PC_W1(PC_W1),
        .PC_W2(PC_W2),
        .PI_SelectDt_Dt(PI_SelectDt_Dt),
        .PI_SelectAd_HL(PI_SelectAd_HL),
        .PA_RRD(PA_RRD),
        .PA_RLD(PA_RLD)
    );

    assign PR_Reset_XPT = (_PR_Reset_XPT_0 | _PR_Reset_XPT_1); // 2
    assign P2_Set_CM1 = PR_Reset_XPT;
    assign P2_Reset_XOTR = PR_Reset_XPT;
    assign Pa_Ophd = PR_Reset_XPT;

endmodule