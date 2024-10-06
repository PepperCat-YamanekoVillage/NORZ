// 49(531)
module DECODER_op_XIX(
        input wire not_enable,
        input wire is_Y,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire PR_Inc_PC,
        output wire PR_Reset_XPT,
        output wire P2_Set_CM1, // <
        output wire Pa_Ophd, // >
        output wire PA_ADD,
        output wire PF_Write_C, // <
        output wire PF_Write_N,
        output wire PF_Write_H,
        output wire PF_Select_C_bit32,
        output wire PF_Select_N_bit16,
        output wire PF_Select_H_bit31, // >
        output wire PA_Select_IX_high,
        output wire PR_Write_IX_high,
        output wire PR_Write_IX_low,
        output wire P2_Reset_XIX,
        output wire PA_Select_IY_high,
        output wire PR_Write_IY_high,
        output wire PR_Write_IY_low,
        output wire P2_Reset_XIY,
        output wire PA_Select_BC_low,
        output wire PA_Select_DE_low,
        output wire PA_Select_SP_low,
        output wire PA_Select_IX_low,
        output wire PA_Select_IY_low,
        output wire PA_Select_0x1_low,
        output wire PA_SUB,
        output wire P2_Set_CMR,
        output wire P2_Set_ILDIXlnnl_0,
        output wire P2_Set_ILDIYlnnl_0,
        output wire P2_Set_ILDIXnn_0,
        output wire P2_Set_ILDIYnn_0,
        output wire P2_Set_ILDlnnlIX_0,
        output wire P2_Set_ILDlnnlIY_0,
        output wire P2_Set_IINClIXtdl,
        output wire P2_Set_IINClIYtdl,
        output wire P2_Set_IDEClIXtdl,
        output wire P2_Set_IDEClIYtdl,
        output wire P2_Set_ILDlIXtdln_0,
        output wire P2_Set_ILDlIYtdln_0,
        output wire P2_Set_ILDrlIXtdl_B,
        output wire P2_Set_ILDrlIXtdl_C,
        output wire P2_Set_ILDrlIXtdl_D,
        output wire P2_Set_ILDrlIXtdl_E,
        output wire P2_Set_ILDrlIXtdl_H,
        output wire P2_Set_ILDrlIXtdl_L,
        output wire P2_Set_ILDrlIXtdl_A,
        output wire P2_Set_ILDlIXtdlr_B,
        output wire P2_Set_ILDlIXtdlr_C,
        output wire P2_Set_ILDlIXtdlr_D,
        output wire P2_Set_ILDlIXtdlr_E,
        output wire P2_Set_ILDlIXtdlr_H,
        output wire P2_Set_ILDlIXtdlr_L,
        output wire P2_Set_ILDlIXtdlr_A,
        output wire P2_Set_ILDrlIYtdl_B,
        output wire P2_Set_ILDrlIYtdl_C,
        output wire P2_Set_ILDrlIYtdl_D,
        output wire P2_Set_ILDrlIYtdl_E,
        output wire P2_Set_ILDrlIYtdl_H,
        output wire P2_Set_ILDrlIYtdl_L,
        output wire P2_Set_ILDrlIYtdl_A,
        output wire P2_Set_ILDlIYtdlr_B,
        output wire P2_Set_ILDlIYtdlr_C,
        output wire P2_Set_ILDlIYtdlr_D,
        output wire P2_Set_ILDlIYtdlr_E,
        output wire P2_Set_ILDlIYtdlr_H,
        output wire P2_Set_ILDlIYtdlr_L,
        output wire P2_Set_ILDlIYtdlr_A,
        output wire P2_Set_IADDAlIXtdl,
        output wire P2_Set_IADCAlIXtdl,
        output wire P2_Set_ISUBAlIXtdl,
        output wire P2_Set_ISBCAlIXtdl,
        output wire P2_Set_IANDlIXtdl,
        output wire P2_Set_IXORlIXtdl,
        output wire P2_Set_IORlIXtdl,
        output wire P2_Set_ICPlIXtdl,
        output wire P2_Set_IADDAlIYtdl,
        output wire P2_Set_IADCAlIYtdl,
        output wire P2_Set_ISUBAlIYtdl,
        output wire P2_Set_ISBCAlIYtdl,
        output wire P2_Set_IANDlIYtdl,
        output wire P2_Set_IXORlIYtdl,
        output wire P2_Set_IORlIYtdl,
        output wire P2_Set_ICPlIYtdl,
        output wire P2_Set_XIX4_0,
        output wire P2_Set_XIY4_0,
        output wire PI_SelectAd_SP,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_Inc_SP,
        output wire PR_InvertIn,
        output wire PA_NOP,
        output wire PR_Write_Dt,
        output wire PR_Write_Dtex,
        output wire PI_SelectDt_Dt,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PI_SelectDt_Dtex,
        output wire PI_SelectAdt1,
        output wire PR_Dec_SP,
        output wire PI_SelectDt_IX_high,
        output wire PI_SelectDt_IY_high,
        output wire PI_SelectDt_IX_low,
        output wire PI_SelectDt_IY_low,
        output wire PR_Write_PC_high,
        output wire PR_Write_PC_low,
        output wire PR_Write_SP
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    // t00010
    wire _decodedXPT2 = ~(not_enable | XPT[4] | XPT[3] | XPT[2] | notXPT[1] | XPT[0]); // 9
    assign PR_Inc_PC = _decodedXPT2;

    //
    // decoder
    //

    wire _00xxxxxx;
    wire _01xxxxxx;
    wire _10xxxxxx;
    wire _11xxxxxx;

    DECODER_2bit_decoder d_ddxxxxxx( // 8
        .notEnable(not_enable),
        .In(Source[7:6]),
        .notIn(notSource[7:6]),
        .out00(_00xxxxxx),
        .out01(_01xxxxxx),
        .out10(_10xxxxxx),
        .out11(_11xxxxxx)
    );

    wire _PR_Reset_XPT_00;
    wire _P2_Set_CM1_00; // <
    wire _Pa_Ophd_00; // >
    wire _PA_Select_IX_high_00;
    wire _PR_Write_IX_high_00;
    wire _PR_Write_IX_low_00;
    wire _P2_Reset_XIX_00;
    wire _PA_Select_IY_high_00;
    wire _PR_Write_IY_high_00;
    wire _PR_Write_IY_low_00;
    wire _P2_Reset_XIY_00;
    wire _PA_Select_IX_low_00;
    wire _PA_Select_IY_low_00;
    wire _P2_Set_CMR_00;

    DECODER_op_XIX_00 d00(
        .enable(_00xxxxxx),
        .is_Y(is_Y),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_00),
        .P2_Set_CM1(_P2_Set_CM1_00), // <
        .Pa_Ophd(_Pa_Ophd_00), // >
        .PA_ADD(PA_ADD),
        .PF_Write_C(PF_Write_C), // <
        .PF_Write_N(PF_Write_N),
        .PF_Write_H(PF_Write_H),
        .PF_Select_C_bit32(PF_Select_C_bit32),
        .PF_Select_N_bit16(PF_Select_N_bit16),
        .PF_Select_H_bit31(PF_Select_H_bit31), // >
        .PA_Select_IX_high(_PA_Select_IX_high_00), // <
        .PR_Write_IX_high(_PR_Write_IX_high_00),
        .PR_Write_IX_low(_PR_Write_IX_low_00), // >
        .P2_Reset_XIX(_P2_Reset_XIX_00),
        .PA_Select_IY_high(_PA_Select_IY_high_00), // <
        .PR_Write_IY_high(_PR_Write_IY_high_00),
        .PR_Write_IY_low(_PR_Write_IY_low_00), // >
        .P2_Reset_XIY(_P2_Reset_XIY_00),
        .PA_Select_BC_low(PA_Select_BC_low),
        .PA_Select_DE_low(PA_Select_DE_low),
        .PA_Select_SP_low(PA_Select_SP_low),
        .PA_Select_IX_low(_PA_Select_IX_low_00),
        .PA_Select_IY_low(_PA_Select_IY_low_00),
        .PA_Select_0x1_low(PA_Select_0x1_low),
        .PA_SUB(PA_SUB),
        .P2_Set_CMR(_P2_Set_CMR_00),
        .P2_Set_ILDIXlnnl_0(P2_Set_ILDIXlnnl_0),
        .P2_Set_ILDIYlnnl_0(P2_Set_ILDIYlnnl_0),
        .P2_Set_ILDIXnn_0(P2_Set_ILDIXnn_0),
        .P2_Set_ILDIYnn_0(P2_Set_ILDIYnn_0),
        .P2_Set_ILDlnnlIX_0(P2_Set_ILDlnnlIX_0),
        .P2_Set_ILDlnnlIY_0(P2_Set_ILDlnnlIY_0),
        .P2_Set_IINClIXtdl(P2_Set_IINClIXtdl),
        .P2_Set_IINClIYtdl(P2_Set_IINClIYtdl),
        .P2_Set_IDEClIXtdl(P2_Set_IDEClIXtdl),
        .P2_Set_IDEClIYtdl(P2_Set_IDEClIYtdl),
        .P2_Set_ILDlIXtdln_0(P2_Set_ILDlIXtdln_0),
        .P2_Set_ILDlIYtdln_0(P2_Set_ILDlIYtdln_0)
    );

    wire _PR_Reset_XPT_01; // <
    wire _P2_Set_CMR_01; // >
    wire _P2_Reset_XIX_01;
    wire _P2_Reset_XIY_01;

    DECODER_op_XIX_01 d01(
        .enable(_01xxxxxx),
        .is_Y(is_Y),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_01), // <
        .P2_Set_CMR(_P2_Set_CMR_01), // >
        .P2_Reset_XIX(_P2_Reset_XIX_01),
        .P2_Reset_XIY(_P2_Reset_XIY_01),
        .P2_Set_ILDrlIXtdl_B(P2_Set_ILDrlIXtdl_B),
        .P2_Set_ILDrlIXtdl_C(P2_Set_ILDrlIXtdl_C),
        .P2_Set_ILDrlIXtdl_D(P2_Set_ILDrlIXtdl_D),
        .P2_Set_ILDrlIXtdl_E(P2_Set_ILDrlIXtdl_E),
        .P2_Set_ILDrlIXtdl_H(P2_Set_ILDrlIXtdl_H),
        .P2_Set_ILDrlIXtdl_L(P2_Set_ILDrlIXtdl_L),
        .P2_Set_ILDrlIXtdl_A(P2_Set_ILDrlIXtdl_A),
        .P2_Set_ILDlIXtdlr_B(P2_Set_ILDlIXtdlr_B),
        .P2_Set_ILDlIXtdlr_C(P2_Set_ILDlIXtdlr_C),
        .P2_Set_ILDlIXtdlr_D(P2_Set_ILDlIXtdlr_D),
        .P2_Set_ILDlIXtdlr_E(P2_Set_ILDlIXtdlr_E),
        .P2_Set_ILDlIXtdlr_H(P2_Set_ILDlIXtdlr_H),
        .P2_Set_ILDlIXtdlr_L(P2_Set_ILDlIXtdlr_L),
        .P2_Set_ILDlIXtdlr_A(P2_Set_ILDlIXtdlr_A),
        .P2_Set_ILDrlIYtdl_B(P2_Set_ILDrlIYtdl_B),
        .P2_Set_ILDrlIYtdl_C(P2_Set_ILDrlIYtdl_C),
        .P2_Set_ILDrlIYtdl_D(P2_Set_ILDrlIYtdl_D),
        .P2_Set_ILDrlIYtdl_E(P2_Set_ILDrlIYtdl_E),
        .P2_Set_ILDrlIYtdl_H(P2_Set_ILDrlIYtdl_H),
        .P2_Set_ILDrlIYtdl_L(P2_Set_ILDrlIYtdl_L),
        .P2_Set_ILDrlIYtdl_A(P2_Set_ILDrlIYtdl_A),
        .P2_Set_ILDlIYtdlr_B(P2_Set_ILDlIYtdlr_B),
        .P2_Set_ILDlIYtdlr_C(P2_Set_ILDlIYtdlr_C),
        .P2_Set_ILDlIYtdlr_D(P2_Set_ILDlIYtdlr_D),
        .P2_Set_ILDlIYtdlr_E(P2_Set_ILDlIYtdlr_E),
        .P2_Set_ILDlIYtdlr_H(P2_Set_ILDlIYtdlr_H),
        .P2_Set_ILDlIYtdlr_L(P2_Set_ILDlIYtdlr_L),
        .P2_Set_ILDlIYtdlr_A(P2_Set_ILDlIYtdlr_A)
    );

    wire _PR_Reset_XPT_10; // <
    wire _P2_Set_CMR_10; // >
    wire _P2_Reset_XIX_10;
    wire _P2_Reset_XIY_10;

    DECODER_op_XIX_10 d10(
        .enable(_10xxxxxx),
        .is_Y(is_Y),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_10), // <
        .P2_Set_CMR(_P2_Set_CMR_10), // >
        .P2_Reset_XIX(_P2_Reset_XIX_10),
        .P2_Reset_XIY(_P2_Reset_XIY_10),
        .P2_Set_IADDAlIXtdl(P2_Set_IADDAlIXtdl),
        .P2_Set_IADCAlIXtdl(P2_Set_IADCAlIXtdl),
        .P2_Set_ISUBAlIXtdl(P2_Set_ISUBAlIXtdl),
        .P2_Set_ISBCAlIXtdl(P2_Set_ISBCAlIXtdl),
        .P2_Set_IANDlIXtdl(P2_Set_IANDlIXtdl),
        .P2_Set_IXORlIXtdl(P2_Set_IXORlIXtdl),
        .P2_Set_IORlIXtdl(P2_Set_IORlIXtdl),
        .P2_Set_ICPlIXtdl(P2_Set_ICPlIXtdl),
        .P2_Set_IADDAlIYtdl(P2_Set_IADDAlIYtdl),
        .P2_Set_IADCAlIYtdl(P2_Set_IADCAlIYtdl),
        .P2_Set_ISUBAlIYtdl(P2_Set_ISUBAlIYtdl),
        .P2_Set_ISBCAlIYtdl(P2_Set_ISBCAlIYtdl),
        .P2_Set_IANDlIYtdl(P2_Set_IANDlIYtdl),
        .P2_Set_IXORlIYtdl(P2_Set_IXORlIYtdl),
        .P2_Set_IORlIYtdl(P2_Set_IORlIYtdl),
        .P2_Set_ICPlIYtdl(P2_Set_ICPlIYtdl)
    );

    wire _P2_Set_CM1_11; // <
    wire _Pa_Ophd_11; // >
    wire _PR_Reset_XPT_11;
    wire _P2_Set_CMR_11;
    wire _P2_Reset_XIX_11;
    wire _P2_Reset_XIY_11;
    wire _PR_Write_IX_low_11;
    wire _PR_Write_IY_low_11;
    wire _PA_Select_IX_high_11;
    wire _PA_Select_IY_high_11;
    wire _PA_Select_IX_low_11;
    wire _PA_Select_IY_low_11;
    wire _PR_Write_IX_high_11;
    wire _PR_Write_IY_high_11;

    DECODER_op_XIX_11 d11(
        .enable(_11xxxxxx),
        .is_Y(is_Y),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .P2_Set_CM1(_P2_Set_CM1_11), // <
        .Pa_Ophd(_Pa_Ophd_11), // >
        .PR_Reset_XPT(_PR_Reset_XPT_11),
        .P2_Set_CMR(_P2_Set_CMR_11),
        .P2_Reset_XIX(_P2_Reset_XIX_11),
        .P2_Reset_XIY(_P2_Reset_XIY_11),
        .P2_Set_XIX4_0(P2_Set_XIX4_0),
        .P2_Set_XIY4_0(P2_Set_XIY4_0),
        .PI_SelectAd_SP(PI_SelectAd_SP),
        .PC_R0(PC_R0),
        .PC_R1(PC_R1),
        .PC_R2(PC_R2),
        .PR_Inc_SP(PR_Inc_SP),
        .PR_InvertIn(PR_InvertIn),
        .PR_Write_IX_low(_PR_Write_IX_low_11),
        .PR_Write_IY_low(_PR_Write_IY_low_11),
        .PA_Select_IX_high(_PA_Select_IX_high_11),
        .PA_Select_IY_high(_PA_Select_IY_high_11),
        .PA_NOP(PA_NOP),
        .PR_Write_Dt(PR_Write_Dt),
        .PR_Write_Dtex(PR_Write_Dtex),
        .PI_SelectDt_Dt(PI_SelectDt_Dt),
        .PC_W0(PC_W0),
        .PC_W1(PC_W1),
        .PC_W2(PC_W2),
        .PI_SelectDt_Dtex(PI_SelectDt_Dtex),
        .PI_SelectAdt1(PI_SelectAdt1),
        .PA_Select_IX_low(_PA_Select_IX_low_11),
        .PA_Select_IY_low(_PA_Select_IY_low_11),
        .PR_Write_IX_high(_PR_Write_IX_high_11),
        .PR_Write_IY_high(_PR_Write_IY_high_11),
        .PR_Dec_SP(PR_Dec_SP),
        .PI_SelectDt_IX_high(PI_SelectDt_IX_high),
        .PI_SelectDt_IY_high(PI_SelectDt_IY_high),
        .PI_SelectDt_IX_low(PI_SelectDt_IX_low),
        .PI_SelectDt_IY_low(PI_SelectDt_IY_low),
        .PR_Write_PC_high(PR_Write_PC_high),
        .PR_Write_PC_low(PR_Write_PC_low),
        .PR_Write_SP(PR_Write_SP)
    );

    assign P2_Set_CM1 = (_P2_Set_CM1_00 | _P2_Set_CM1_11); // 2
    assign Pa_Ophd = P2_Set_CM1;

    wire _rst_01or10 = (_PR_Reset_XPT_01 | _PR_Reset_XPT_10); // 2
    assign PR_Reset_XPT = (_PR_Reset_XPT_00 | _PR_Reset_XPT_11 | _rst_01or10); // 4
    assign P2_Set_CMR = (_P2_Set_CMR_00 | _P2_Set_CMR_11 | _rst_01or10); // 4

    assign P2_Reset_XIX = (_P2_Reset_XIX_00 | _P2_Reset_XIX_01 | _P2_Reset_XIX_10 | _P2_Reset_XIX_11); // 6
    assign P2_Reset_XIY = (_P2_Reset_XIY_00 | _P2_Reset_XIY_01 | _P2_Reset_XIY_10 | _P2_Reset_XIY_11); // 6

    assign PA_Select_IX_high = (_PA_Select_IX_high_00 | _PA_Select_IX_high_11); // 2
    assign PA_Select_IY_high = (_PA_Select_IY_high_00 | _PA_Select_IY_high_11); // 2
    assign PA_Select_IX_low = (_PA_Select_IX_low_00 | _PA_Select_IX_low_11); // 2
    assign PA_Select_IY_low = (_PA_Select_IY_low_00 | _PA_Select_IY_low_11); // 2
    assign PR_Write_IX_high = (_PR_Write_IX_high_00 | _PR_Write_IX_high_11); // 2
    assign PR_Write_IY_high = (_PR_Write_IY_high_00 | _PR_Write_IY_high_11); // 2
    assign PR_Write_IX_low = (_PR_Write_IX_low_00 | _PR_Write_IX_low_11); // 2
    assign PR_Write_IY_low = (_PR_Write_IY_low_00 | _PR_Write_IY_low_11); // 2

endmodule