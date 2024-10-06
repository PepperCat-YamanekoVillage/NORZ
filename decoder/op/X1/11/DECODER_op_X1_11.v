// 59(526)
module DECODER_op_X1_11(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        input wire Flag_Z,
        input wire Flag_C,
        input wire Flag_PV,
        input wire Flag_S,
        output wire PR_Reset_XPT,
        output wire P2_Set_CM1,
        output wire Pa_Ophd,
        output wire PI_SelectAd_SP,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_Inc_SP,
        output wire PR_Write_PC_low,
        output wire PR_Write_PC_high,
        output wire PR_InvertIn,
        output wire PA_NOP,
        output wire PA_Select_HL_low,
        output wire PR_Write_SP,
        output wire PR_Exx,
        output wire PR_Write_B,
        output wire PR_Write_C,
        output wire PR_Write_D,
        output wire PR_Write_E,
        output wire PR_Write_H,
        output wire PR_Write_L,
        output wire PR_Write_A,
        output wire PR_Write_F,
        output wire PR_Write_Dt,// <
        output wire PR_Write_Dtex, // >
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PI_SelectDt_Dt,
        output wire PI_SelectDt_Dtex,
        output wire PI_SelectAdt1,
        output wire P2_Set_XBIT,
        output wire PR_Ex_DE_HL,
        output wire P2_Reset_IFF1, // <
        output wire P2_Reset_IFF2, // >
        output wire P2_Set_IFF1, // <
        output wire P2_Set_IFF2, // >
        output wire P2_Set_CMR,
        output wire P2_Set_IJPccnn_0_0,
        output wire P2_Set_IJPccnn_1_0,
        output wire P2_Set_IJPccnn_2_0,
        output wire P2_Set_IJPccnn_3_0,
        output wire P2_Set_IJPccnn_4_0,
        output wire P2_Set_IJPccnn_5_0,
        output wire P2_Set_IJPccnn_6_0,
        output wire P2_Set_IJPccnn_7_0,
        output wire P2_Set_IJPnn_0,
        output wire P2_Set_IOUTlnlA,
        output wire P2_Set_IINAlnl,
        output wire PR_Dec_SP,
        output wire PI_SelectDt_B,
        output wire PI_SelectDt_C,
        output wire PI_SelectDt_D,
        output wire PI_SelectDt_E,
        output wire PI_SelectDt_H,
        output wire PI_SelectDt_L,
        output wire PI_SelectDt_A,
        output wire PI_SelectDt_F,
        output wire P2_Set_ICALLccnn_0_0,
        output wire P2_Set_ICALLccnn_1_0,
        output wire P2_Set_ICALLccnn_2_0,
        output wire P2_Set_ICALLccnn_3_0,
        output wire P2_Set_ICALLccnn_4_0,
        output wire P2_Set_ICALLccnn_5_0,
        output wire P2_Set_ICALLccnn_6_0,
        output wire P2_Set_ICALLccnn_7_0,
        output wire P2_Set_ICALLnn_0,
        output wire P2_Set_XIX,
        output wire P2_Set_XOTR,
        output wire P2_Set_XIY,
        output wire P2_Set_CMA,
        output wire P2_Set_IADDAn,
        output wire P2_Set_IADCAn,
        output wire P2_Set_ISUBAn,
        output wire P2_Set_ISBCAn,
        output wire P2_Set_IANDn,
        output wire P2_Set_IXORn,
        output wire P2_Set_IORn,
        output wire P2_Set_ICPn,
        output wire PI_SelectDt_PC_high,
        output wire PI_SelectDt_PC_low,
        output wire PA_Select_0x8_low,
        output wire PA_Select_0x10_low,
        output wire PA_Select_0x18_low,
        output wire PA_Select_0x20_low,
        output wire PA_Select_0x28_low,
        output wire PA_Select_0x30_low,
        output wire PA_Select_0x38_low
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _11xxx00x;
    wire _11xxx01x;
    wire _11xxx10x;
    wire _11xxx11x;

    DECODER_2bit_decoder d_11xxxddx( // 8
        .notEnable(_not_enable),
        .In(Source[2:1]),
        .notIn(notSource[2:1]),
        .out00(_11xxx00x),
        .out01(_11xxx01x),
        .out10(_11xxx10x),
        .out11(_11xxx11x)
    );

    wire _PR_Reset_XPT_00; // <
    wire _P2_Set_CM1_00;
    wire _Pa_Ophd_00; // >
    wire _PI_SelectAd_SP_00;
    wire _PC_R0_00;
    wire _PC_R1_00;
    wire _PC_R2_00;
    wire _PR_Write_PC_low_00;
    wire _PR_Write_PC_high_00;
    wire _PR_InvertIn_00;
    wire _PA_NOP_00; // <
    wire _PA_Select_HL_low_00; // >
    wire _PR_Write_H_00;
    wire _PR_Write_L_00;

    DECODER_op_X1_11xxx00 d11xxx00(
        .enable(_11xxx00x),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .Flag_Z(Flag_Z),
        .Flag_C(Flag_C),
        .Flag_PV(Flag_PV),
        .Flag_S(Flag_S),
        .PR_Reset_XPT(_PR_Reset_XPT_00), // <
        .P2_Set_CM1(_P2_Set_CM1_00),
        .Pa_Ophd(_Pa_Ophd_00), // >
        .PI_SelectAd_SP(_PI_SelectAd_SP_00),
        .PC_R0(_PC_R0_00),
        .PC_R1(_PC_R1_00),
        .PC_R2(_PC_R2_00),
        .PR_Inc_SP(PR_Inc_SP),
        .PR_Write_PC_low(_PR_Write_PC_low_00),
        .PR_Write_PC_high(_PR_Write_PC_high_00),
        .PR_InvertIn(_PR_InvertIn_00),
        .PA_NOP(_PA_NOP_00), // <
        .PA_Select_HL_low(_PA_Select_HL_low_00), // >
        .PR_Write_SP(PR_Write_SP),
        .PR_Exx(PR_Exx),
        .PR_Write_B(PR_Write_B),
        .PR_Write_C(PR_Write_C),
        .PR_Write_D(PR_Write_D),
        .PR_Write_E(PR_Write_E),
        .PR_Write_H(_PR_Write_H_00),
        .PR_Write_L(_PR_Write_L_00),
        .PR_Write_A(PR_Write_A),
        .PR_Write_F(PR_Write_F)
    );

    wire _PR_Reset_XPT_01;
    wire _PA_Select_HL_low_01; // <
    wire _PA_NOP_01; // >
    wire _PC_R0_01;
    wire _PC_R1_01;
    wire _PC_R2_01;
    wire _PR_Write_L_01;
    wire _PR_Write_H_01; // <
    wire _PR_InvertIn_01; // >
    wire _PC_W0_01;
    wire _PC_W1_01;
    wire _PC_W2_01;
    wire _PI_SelectAd_SP_01;
    wire _P2_Set_CM1_01;
    wire _Pa_Ophd_01;
    wire _P2_Set_CMR_01;

    DECODER_op_X1_11xxx01 d11xxx01(
        .enable(_11xxx01x),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_01),
        .PA_Select_HL_low(_PA_Select_HL_low_01), // <
        .PA_NOP(_PA_NOP_01),
        .PR_Write_Dt(PR_Write_Dt),
        .PR_Write_Dtex(PR_Write_Dtex), // >
        .PC_R0(_PC_R0_01),
        .PC_R1(_PC_R1_01),
        .PC_R2(_PC_R2_01),
        .PR_Write_L(_PR_Write_L_01),
        .PR_Write_H(_PR_Write_H_01), // <
        .PR_InvertIn(_PR_InvertIn_01), // >
        .PC_W0(_PC_W0_01),
        .PC_W1(_PC_W1_01),
        .PC_W2(_PC_W2_01),
        .PI_SelectDt_Dt(PI_SelectDt_Dt),
        .PI_SelectDt_Dtex(PI_SelectDt_Dtex),
        .PI_SelectAdt1(PI_SelectAdt1),
        .PI_SelectAd_SP(_PI_SelectAd_SP_01),
        .P2_Set_CM1(_P2_Set_CM1_01),
        .Pa_Ophd(_Pa_Ophd_01),
        .P2_Set_XBIT(P2_Set_XBIT),
        .PR_Ex_DE_HL(PR_Ex_DE_HL),
        .P2_Reset_IFF1(P2_Reset_IFF1), // <
        .P2_Reset_IFF2(P2_Reset_IFF2), // >
        .P2_Set_IFF1(P2_Set_IFF1), // <
        .P2_Set_IFF2(P2_Set_IFF2), // >
        .P2_Set_CMR(_P2_Set_CMR_01),
        .P2_Set_IJPccnn_0_0(P2_Set_IJPccnn_0_0),
        .P2_Set_IJPccnn_1_0(P2_Set_IJPccnn_1_0),
        .P2_Set_IJPccnn_2_0(P2_Set_IJPccnn_2_0),
        .P2_Set_IJPccnn_3_0(P2_Set_IJPccnn_3_0),
        .P2_Set_IJPccnn_4_0(P2_Set_IJPccnn_4_0),
        .P2_Set_IJPccnn_5_0(P2_Set_IJPccnn_5_0),
        .P2_Set_IJPccnn_6_0(P2_Set_IJPccnn_6_0),
        .P2_Set_IJPccnn_7_0(P2_Set_IJPccnn_7_0),
        .P2_Set_IJPnn_0(P2_Set_IJPnn_0),
        .P2_Set_IOUTlnlA(P2_Set_IOUTlnlA),
        .P2_Set_IINAlnl(P2_Set_IINAlnl)
    );

    wire _PR_Reset_XPT_10;
    wire _PR_Dec_SP_10;
    wire _PC_W0_10;
    wire _PC_W1_10;
    wire _PC_W2_10;
    wire _PI_SelectAd_SP_10;
    wire _P2_Set_CM1_10;
    wire _Pa_Ophd_10;
    wire _P2_Set_CMR_10;

    DECODER_op_X1_11xxx10 d11xxx10(
        .enable(_11xxx10x),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_10),
        .PR_Dec_SP(_PR_Dec_SP_10),
        .PC_W0(_PC_W0_10),
        .PC_W1(_PC_W1_10),
        .PC_W2(_PC_W2_10),
        .PI_SelectDt_B(PI_SelectDt_B),
        .PI_SelectDt_C(PI_SelectDt_C),
        .PI_SelectDt_D(PI_SelectDt_D),
        .PI_SelectDt_E(PI_SelectDt_E),
        .PI_SelectDt_H(PI_SelectDt_H),
        .PI_SelectDt_L(PI_SelectDt_L),
        .PI_SelectDt_A(PI_SelectDt_A),
        .PI_SelectDt_F(PI_SelectDt_F),
        .PI_SelectAd_SP(_PI_SelectAd_SP_10),
        .P2_Set_CM1(_P2_Set_CM1_10),
        .Pa_Ophd(_Pa_Ophd_10),
        .P2_Set_CMR(_P2_Set_CMR_10),
        .P2_Set_ICALLccnn_0_0(P2_Set_ICALLccnn_0_0),
        .P2_Set_ICALLccnn_1_0(P2_Set_ICALLccnn_1_0),
        .P2_Set_ICALLccnn_2_0(P2_Set_ICALLccnn_2_0),
        .P2_Set_ICALLccnn_3_0(P2_Set_ICALLccnn_3_0),
        .P2_Set_ICALLccnn_4_0(P2_Set_ICALLccnn_4_0),
        .P2_Set_ICALLccnn_5_0(P2_Set_ICALLccnn_5_0),
        .P2_Set_ICALLccnn_6_0(P2_Set_ICALLccnn_6_0),
        .P2_Set_ICALLccnn_7_0(P2_Set_ICALLccnn_7_0),
        .P2_Set_ICALLnn_0(P2_Set_ICALLnn_0),
        .P2_Set_XIX(P2_Set_XIX),
        .P2_Set_XOTR(P2_Set_XOTR),
        .P2_Set_XIY(P2_Set_XIY)
    );

    wire _PR_Reset_XPT_11;
    wire _PR_Dec_SP_11;
    wire _PC_W0_11;
    wire _PC_W1_11;
    wire _PC_W2_11;
    wire _PI_SelectAd_SP_11;
    wire _P2_Set_CM1_11; // <
    wire _Pa_Ophd_11;
    wire _PA_NOP_11;
    wire _PR_Write_PC_high_11;
    wire _PR_Write_PC_low_11; // >

    DECODER_op_X1_11xxx11 d11xxx11(
        .enable(_11xxx11x),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_11), // <
        .P2_Set_CMA(P2_Set_CMA), // >
        .P2_Set_IADDAn(P2_Set_IADDAn),
        .P2_Set_IADCAn(P2_Set_IADCAn),
        .P2_Set_ISUBAn(P2_Set_ISUBAn),
        .P2_Set_ISBCAn(P2_Set_ISBCAn),
        .P2_Set_IANDn(P2_Set_IANDn),
        .P2_Set_IXORn(P2_Set_IXORn),
        .P2_Set_IORn(P2_Set_IORn),
        .P2_Set_ICPn(P2_Set_ICPn),
        .PR_Dec_SP(_PR_Dec_SP_11),
        .PC_W0(_PC_W0_11),
        .PC_W1(_PC_W1_11),
        .PC_W2(_PC_W2_11),
        .PI_SelectDt_PC_high(PI_SelectDt_PC_high),
        .PI_SelectDt_PC_low(PI_SelectDt_PC_low),
        .PI_SelectAd_SP(_PI_SelectAd_SP_11),
        .P2_Set_CM1(_P2_Set_CM1_11), // <
        .Pa_Ophd(_Pa_Ophd_11),
        .PA_NOP(_PA_NOP_11),
        .PR_Write_PC_high(_PR_Write_PC_high_11),
        .PR_Write_PC_low(_PR_Write_PC_low_11), // >
        .PA_Select_0x8_low(PA_Select_0x8_low),
        .PA_Select_0x10_low(PA_Select_0x10_low),
        .PA_Select_0x18_low(PA_Select_0x18_low),
        .PA_Select_0x20_low(PA_Select_0x20_low),
        .PA_Select_0x28_low(PA_Select_0x28_low),
        .PA_Select_0x30_low(PA_Select_0x30_low),
        .PA_Select_0x38_low(PA_Select_0x38_low)
    );

    assign PR_Reset_XPT = (_PR_Reset_XPT_00 | _PR_Reset_XPT_01 | _PR_Reset_XPT_10 | _PR_Reset_XPT_11); // 6
    assign P2_Set_CMR = (_P2_Set_CMR_01 | _P2_Set_CMR_10); // 2

    wire _end03 = (_P2_Set_CM1_00 | _P2_Set_CM1_11); //2
    assign P2_Set_CM1 = (_end03 | _P2_Set_CM1_01 | _P2_Set_CM1_10); // 4
    assign Pa_Ophd = (_end03 | _Pa_Ophd_01 | _Pa_Ophd_10); // 4

    assign PI_SelectAd_SP = (_PI_SelectAd_SP_00 | _PI_SelectAd_SP_01 | _PI_SelectAd_SP_10 | _PI_SelectAd_SP_11); // 6
    assign PC_W0 = (_PC_W0_01 | _PC_W0_10 | _PC_W0_11); // 4
    assign PC_W1 = (_PC_W1_01 | _PC_W1_10 | _PC_W1_11); // 4
    assign PC_W2 = (_PC_W2_01 | _PC_W2_10 | _PC_W2_11); // 4
    assign PC_R0 = (_PC_R0_00 | _PC_R0_01); // 2
    assign PC_R1 = (_PC_R1_00 | _PC_R1_01); // 2
    assign PC_R2 = (_PC_R2_00 | _PC_R2_01); // 2
    assign PR_Write_PC_low = (_PR_Write_PC_low_00 | _PR_Write_PC_low_11); // 2
    assign PR_Write_PC_high = (_PR_Write_PC_high_00 | _PR_Write_PC_high_11); // 2
    assign PR_Dec_SP = (_PR_Dec_SP_10 | _PR_Dec_SP_11); // 2
    assign PA_Select_HL_low = (_PA_Select_HL_low_00 | _PA_Select_HL_low_01); // 2
    assign PA_NOP = (PA_Select_HL_low | _PA_NOP_11); // 2
    assign PR_InvertIn = (_PR_InvertIn_00 | _PR_InvertIn_01); // 2
    assign PR_Write_H = (_PR_Write_H_00 | _PR_Write_H_01); // 2
    assign PR_Write_L = (_PR_Write_L_00 | _PR_Write_L_01); // 2

endmodule