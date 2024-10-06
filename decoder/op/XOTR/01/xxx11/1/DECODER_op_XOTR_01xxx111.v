// 13(60)
module DECODER_op_XOTR_01xxx111(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_XOTR,
        output wire Pa_Ophd, // >
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

    wire _0100x111;
    wire _0101x111;
    wire _0110x111;

    DECODER_2bit_decoder d_01ddx111( // 5
        .notEnable(_not_enable),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(_0100x111),
        .out01(_0101x111),
        .out1x(_0110x111)
    );

    wire _PR_Reset_XPT_00; // <
    wire _P2_Set_CM1_00;
    wire _P2_Reset_XOTR_00;
    wire _PA_Select_A_low_00;
    wire _PA_NOP_00;
    wire _Pa_Ophd_00; // >
    wire _PR_InvertIn_00;

    DECODER_op_XOTR_0100x111 d0100x111(
        .enable(_0100x111),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_00), // <
        .P2_Set_CM1(_P2_Set_CM1_00),
        .P2_Reset_XOTR(_P2_Reset_XOTR_00),
        .PA_Select_A_low(_PA_Select_A_low_00),
        .PA_NOP(_PA_NOP_00),
        .Pa_Ophd(_Pa_Ophd_00), // >
        .PR_Write_I(PR_Write_I),
        .PR_InvertIn(_PR_InvertIn_00),
        .PR_Write_R(PR_Write_R)
    );

    wire _PR_Reset_XPT_01; // <
    wire _P2_Set_CM1_01;
    wire _P2_Reset_XOTR_01;
    wire _PA_NOP_01;
    wire _PR_Write_A_01;
    wire _PR_InvertIn_01;
    wire _PF_Write_Z_01;
    wire _PF_Write_PV_01;
    wire _PF_Write_S_01;
    wire _PF_Write_N_01;
    wire _PF_Write_H_01;
    wire _PF_Select_S_bit7_01;
    wire _PF_Select_N_bit16_01;
    wire _PF_Select_H_bit16_01;
    wire _Pa_Ophd_01; // >

    DECODER_op_XOTR_0101x111 d0101x111(
        .enable(_0101x111),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_01), // <
        .P2_Set_CM1(_P2_Set_CM1_01),
        .P2_Reset_XOTR(_P2_Reset_XOTR_01),
        .PA_NOP(_PA_NOP_01),
        .PR_Write_A(_PR_Write_A_01),
        .PR_InvertIn(_PR_InvertIn_01),
        .PF_Write_Z(_PF_Write_Z_01),
        .PF_Write_PV(_PF_Write_PV_01),
        .PF_Write_S(_PF_Write_S_01),
        .PF_Write_N(_PF_Write_N_01),
        .PF_Write_H(_PF_Write_H_01),
        .PF_Select_Z_bit19(PF_Select_Z_bit19),
        .PF_Select_PV_bit18(PF_Select_PV_bit18),
        .PF_Select_S_bit7(_PF_Select_S_bit7_01),
        .PF_Select_N_bit16(_PF_Select_N_bit16_01),
        .PF_Select_H_bit16(_PF_Select_H_bit16_01),
        .Pa_Ophd(_Pa_Ophd_01), // >
        .PA_Select_I_low(PA_Select_I_low),
        .PA_Select_R_low(PA_Select_R_low)
    );

    wire _PA_Select_A_low_10; // <
    wire _PR_Write_A_10;
    wire _PR_InvertIn_10;
    wire _PF_Write_Z_10;
    wire _PF_Write_PV_10;
    wire _PF_Write_S_10;
    wire _PF_Write_N_10;
    wire _PF_Write_H_10;
    wire _PF_Select_S_bit7_10;
    wire _PF_Select_N_bit16_10;
    wire _PF_Select_H_bit16_10; // >
    wire _PR_Reset_XPT_10; // <
    wire _P2_Set_CM1_10;
    wire _P2_Reset_XOTR_10;
    wire _Pa_Ophd_10; // >

    DECODER_op_XOTR_0110x111 d0110x111(
        .enable(_0110x111),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PC_R0(PC_R0),
        .PC_R1(PC_R1),
        .PC_R2(PC_R2),
        .PR_Write_Dt(PR_Write_Dt),
        .PA_Select_A_low(_PA_Select_A_low_10), // <
        .PA_Select_Dt_high(PA_Select_Dt_high),
        .PR_Write_A(_PR_Write_A_10),
        .PR_InvertIn(_PR_InvertIn_10),
        .PF_Write_Z(_PF_Write_Z_10),
        .PF_Write_PV(_PF_Write_PV_10),
        .PF_Write_S(_PF_Write_S_10),
        .PF_Write_N(_PF_Write_N_10),
        .PF_Write_H(_PF_Write_H_10),
        .PF_Select_Z_bit24(PF_Select_Z_bit24),
        .PF_Select_PV_bit27(PF_Select_PV_bit27),
        .PF_Select_S_bit7(_PF_Select_S_bit7_10),
        .PF_Select_N_bit16(_PF_Select_N_bit16_10),
        .PF_Select_H_bit16(_PF_Select_H_bit16_10), // >
        .PC_W0(PC_W0),
        .PC_W1(PC_W1),
        .PC_W2(PC_W2),
        .PR_Reset_XPT(_PR_Reset_XPT_10), // <
        .P2_Set_CM1(_P2_Set_CM1_10),
        .P2_Reset_XOTR(_P2_Reset_XOTR_10),
        .Pa_Ophd(_Pa_Ophd_10), //>
        .PI_SelectDt_Dt(PI_SelectDt_Dt),
        .PI_SelectAd_HL(PI_SelectAd_HL),
        .PA_RRD(PA_RRD),
        .PA_RLD(PA_RLD)
    );

    assign PA_NOP = (_PA_NOP_00 | _PA_NOP_01); // 2

    assign PR_Reset_XPT = (PA_NOP | _PR_Reset_XPT_10); // 2
    assign P2_Set_CM1 = PR_Reset_XPT;
    assign P2_Reset_XOTR = PR_Reset_XPT;
    assign Pa_Ophd = PR_Reset_XPT;

    assign PR_Write_A = (_PR_Write_A_01 | _PR_Write_A_10); // 2
    assign PF_Write_Z = PR_Write_A;
    assign PF_Write_PV = PR_Write_A;
    assign PF_Write_S = PR_Write_A;
    assign PF_Write_N = PR_Write_A;
    assign PF_Write_H = PR_Write_A;
    assign PF_Select_S_bit7 = PR_Write_A;
    assign PF_Select_N_bit16 = PR_Write_A;
    assign PF_Select_H_bit16 = PR_Write_A;

    assign PA_Select_A_low = (_PA_Select_A_low_00 | _PA_Select_A_low_10); // 2

    assign PR_InvertIn = (_PR_InvertIn_00 | _PR_InvertIn_01 | _PR_InvertIn_10); // 4

endmodule