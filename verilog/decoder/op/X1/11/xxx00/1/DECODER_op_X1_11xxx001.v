// 23(83)
module DECODER_op_X1_11xxx001(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd, // >
        output wire PA_NOP, // <
        output wire PA_Select_HL_low, // >
        output wire PR_Write_SP,
        output wire PR_Exx,
        output wire PR_Write_PC_high,
        output wire PR_Write_PC_low,
        output wire PI_SelectAd_SP,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_Inc_SP,
        output wire PR_InvertIn,
        output wire PR_Write_B,
        output wire PR_Write_C,
        output wire PR_Write_D,
        output wire PR_Write_E,
        output wire PR_Write_H,
        output wire PR_Write_L,
        output wire PR_Write_A,
        output wire PR_Write_F
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _11xx0001;
    wire _11xx1001;

    DECODER_1bit_decoder d_11xxx001(
        .notEnable(_not_enable),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_11xx0001),
        .out1(_11xx1001)
    );

    wire _not11xx1001 = _11xx1001 ~| _11xx1001;

    wire _11111001 = ~(_not11xx1001 | notSource[5] | notSource[4]); // 3
    wire _11001001 = ~(_not11xx1001 | Source[5] | Source[4]); // 3
    wire _11ee1001 = ~(_not11xx1001 | _11111001 | _11001001); // 3
    wire _11eee001 = (_11xx0001 | _11001001); // 2

    wire _PR_Reset_XPT_111; // <
    wire _P2_Set_CM1_111;
    wire _Pa_Ophd_111;
    wire _PA_NOP_111;
    wire _PA_Select_HL_low_111; // >

    DECODER_op_X1_11111001 d11111001(
        .enable(_11111001),
        .XPT(XPT),
        .notXPT(notXPT),
        .PR_Reset_XPT(_PR_Reset_XPT_111), // <
        .P2_Set_CM1(_P2_Set_CM1_111),
        .Pa_Ophd(_Pa_Ophd_111),
        .PA_NOP(_PA_NOP_111),
        .PA_Select_HL_low(_PA_Select_HL_low_111),
        .PR_Write_SP(PR_Write_SP) // >
    );

    wire _PR_Reset_XPT_ee1; // <
    wire _P2_Set_CM1_ee1;
    wire _Pa_Ophd_ee1; // >
    wire _PA_NOP_ee1; // <
    wire _PA_Select_HL_low_ee1;
    wire _PR_Write_PC_high_ee1;
    wire _PR_Write_PC_low_ee1; // >

    DECODER_op_X1_11ee1001 d11ee1001(
        .enable(_11ee1001),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_ee1), // <
        .P2_Set_CM1(_P2_Set_CM1_ee1),
        .Pa_Ophd(_Pa_Ophd_ee1), // >
        .PR_Exx(PR_Exx),
        .PA_NOP(_PA_NOP_ee1), // <
        .PA_Select_HL_low(_PA_Select_HL_low_ee1),
        .PR_Write_PC_high(_PR_Write_PC_high_ee1),
        .PR_Write_PC_low(_PR_Write_PC_low_ee1) // >
    );

    wire _PR_Reset_XPT_eee; // <
    wire _P2_Set_CM1_eee;
    wire _Pa_Ophd_eee; // >
    wire _PR_Write_PC_low_eee;
    wire _PR_Write_PC_high_eee;

    DECODER_op_X1_11eee001 d11eee001(
        .enable(_11eee001),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PI_SelectAd_SP(PI_SelectAd_SP),
        .PC_R0(PC_R0),
        .PC_R1(PC_R1),
        .PC_R2(PC_R2),
        .PR_Inc_SP(PR_Inc_SP),
        .PR_Reset_XPT(_PR_Reset_XPT_eee), // <
        .P2_Set_CM1(_P2_Set_CM1_eee),
        .Pa_Ophd(_Pa_Ophd_eee),
        .PR_InvertIn(PR_InvertIn), // >
        .PR_Write_PC_low(_PR_Write_PC_low_eee),
        .PR_Write_PC_high(_PR_Write_PC_high_eee),
        .PR_Write_B(PR_Write_B),
        .PR_Write_C(PR_Write_C),
        .PR_Write_D(PR_Write_D),
        .PR_Write_E(PR_Write_E),
        .PR_Write_H(PR_Write_H),
        .PR_Write_L(PR_Write_L),
        .PR_Write_A(PR_Write_A),
        .PR_Write_F(PR_Write_F)
    );

    assign PR_Reset_XPT = (_PR_Reset_XPT_111 | _PR_Reset_XPT_ee1 | _PR_Reset_XPT_eee); // 4
    assign P2_Set_CM1 = PR_Reset_XPT;
    assign Pa_Ophd = PR_Reset_XPT;

    assign PA_NOP = (_PA_NOP_111 | _PA_NOP_ee1); // 2
    assign PA_Select_HL_low = PA_NOP;

    assign PR_Write_PC_high = (_PR_Write_PC_high_ee1 | _PR_Write_PC_high_eee); // 2
    assign PR_Write_PC_low = (_PR_Write_PC_low_ee1 | _PR_Write_PC_low_eee); // 2

endmodule