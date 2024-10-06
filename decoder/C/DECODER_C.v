// 62(285)
module DECODER_C(
        input wire Clk,
        input wire not_decodingIn,
        input wire notCRESET,
        input wire notCBUSRQ,
        input wire notCNMI,
        input wire notCINT0_RST,
        input wire notCINT0_CALL,
        input wire notCINT0,
        input wire notCINT1,
        input wire notCINT2,
        input wire notCM1, // XPT 0,1のみXOR
        input wire notCMR, // XPT 0,1のみXOR
        input wire notCMA, // XPT 0,1のみXOR
        input wire BUSRQ,
        input wire TWAIT,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [5:0] OP,
        input wire [5:0] notOP,
        output wire PR_Reset_XPT,
        output wire PA_NOP,
        output wire PR_Write_PC_low,
        output wire PR_Write_PC_high,
        output wire PR_Write_I,
        output wire PR_Write_R,
        output wire P2_Reset_CRESET,
        output wire P2_Set_CM1,
        output wire P2_IM0,
        output wire P2_Reset_IFF1,
        output wire P2_Reset_IFF2,
        output wire Pa_Ophd,
        output wire P2_Set_CBUSRQ,
        output wire PI_Nullify_MREQ,
        output wire PI_Nullify_RD,
        output wire PI_Nullify_WR,
        output wire PI_Nullify_IORQ,
        output wire PI_Flag_BUSACK,
        output wire PhI_Flag_BUSACK,
        output wire PR_Halt_XPT,
        output wire P2_Reset_CBUSRQ,
        output wire PC_M1,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PR_Dec_SP,
        output wire PI_SelectDt_PC_high,
        output wire PI_SelectDt_PC_low,
        output wire PI_SelectAd_SP,
        output wire P2_Reset_CNMI,
        output wire PA_Select_0x66_low,
        output wire PA_Select_0x8_low,
        output wire PA_Select_0x10_low,
        output wire PA_Select_0x18_low,
        output wire PA_Select_0x20_low,
        output wire PA_Select_0x28_low,
        output wire PA_Select_0x30_low,
        output wire PA_Select_0x38_low,
        output wire PC_MR0,
        output wire PC_MR1,
        output wire PC_MR2,
        output wire P2_Reset_CINT,
        output wire PA_Select_OPOPold_low,
        output wire P2_Set_CINT0_RST,
        output wire P2_Set_CINT0_CALL,
        output wire PA_Select_IOP_low,
        output wire PI_SelectAd_PC,
        output wire PI_Flag_M1,
        output wire PI_Activate_Ad_high,
        output wire PI_Activate_Ad_low,
        output wire PhI_Flag_IORQ,
        output wire PI_Flag_IORQ,
        output wire PA_Select_Din_low,
        output wire PR_Write_OP,
        output wire PI_SelectAd_IR,
        output wire PI_Flag_RFSH,
        output wire PhI_Flag_MREQ,
        output wire PR_Inc_R,
        output wire PC_MR,
        output wire PD_Source_Dtcs,
        output wire PC_MA,
        output wire not_decodingOut,
    );

    // wire [4:0] notXPT = ~XPT;

    wire _PR_Reset_XPT_creset;// <
    wire _PA_NOP_creset;
    wire _PR_Write_PC_low_creset;
    wire _PR_Write_PC_high_creset;
    wire _P2_Set_CM1_creset;
    wire _Pa_Ophd_creset;// >

    wire _not_decodingOut_creset;

    DECODER_CRESET creset(
        .not_decodingIn(not_decodingIn),
        .notCRESET(notCRESET),
        .PR_Reset_XPT(_PR_Reset_XPT_creset),
        .PA_NOP(_PA_NOP_creset),
        .PR_Write_PC_low(_PR_Write_PC_low_creset),
        .PR_Write_PC_high(_PR_Write_PC_high_creset),
        .PR_Write_I(PR_Write_I),
        .PR_Write_R(PR_Write_R),
        .P2_Reset_CRESET(P2_Reset_CRESET),
        .P2_Set_CM1(_P2_Set_CM1_creset),
        .P2_IM0(P2_IM0),
        .P2_Reset_IFF1(P2_Reset_IFF1),
        .P2_Reset_IFF2(P2_Reset_IFF2),
        .Pa_Ophd(_Pa_Ophd_creset),
        .not_decodingOut(_not_decodingOut_creset)
    );

    wire _PR_Halt_XPT_cbusrq;
    wire _PR_Reset_XPT_cbusrq; // <
    wire _P2_Set_CM1_cbusrq;
    wire _Pa_Ophd_cbusrq; // >

    wire _not_decodingOut_cbusrq;

    DECODER_CBUSRQ cbusrq(
        .not_decodingIn(_not_decodingOut_creset),
        .notCBUSRQ(notCBUSRQ),
        .BUSRQ(BUSRQ),
        .XPT(XPT[0]),
        .notXPT(notXPT[0]),
        .P2_Set_CBUSRQ(P2_Set_CBUSRQ),
        .PI_Nullify_MREQ(PI_Nullify_MREQ),
        .PI_Nullify_RD(PI_Nullify_RD),
        .PI_Nullify_WR(PI_Nullify_WR),
        .PI_Nullify_IORQ(PI_Nullify_IORQ),
        .PI_Flag_BUSACK(PI_Flag_BUSACK),
        .PhI_Flag_BUSACK(PhI_Flag_BUSACK),
        .PR_Halt_XPT(_PR_Halt_XPT_cbusrq),
        .PR_Reset_XPT(_PR_Reset_XPT_cbusrq),
        .P2_Set_CM1(_P2_Set_CM1_cbusrq),
        .P2_Reset_CBUSRQ(P2_Reset_CBUSRQ),
        .Pa_Ophd(_Pa_Ophd_cbusrq),
        .not_decodingOut(_not_decodingOut_cbusrq)
    );

    wire _PC_M1_cnmi;
    wire _PC_W0_cnmi;
    wire _PC_W1_cnmi;
    wire _PC_W2_cnmi;
    wire _PR_Dec_SP_cnmi;
    wire _PI_SelectDt_PC_high_cnmi;
    wire _PI_SelectDt_PC_low_cnmi;
    wire _notPI_SelectAd_SP_cnmi;
    wire _PR_Reset_XPT_cnmi; // <
    wire _P2_Set_CM1_cnmi;
    wire _PA_NOP_cnmi;
    wire _PR_Write_PC_high_cnmi;
    wire _PR_Write_PC_low_cnmi;
    wire _Pa_Ophd_cnmi; // >

    wire _not_decodingOut_cnmi;

    DECODER_CNMI cnmi(
        .not_decodingIn(_not_decodingOut_cbusrq),
        .notCNMI(notCNMI),
        .XPT(XPT[3:0]),
        .notXPT(notXPT[3:0]),
        .PC_M1(_PC_M1_cnmi),
        .PC_W0(_PC_W0_cnmi),
        .PC_W1(_PC_W1_cnmi),
        .PC_W2(_PC_W2_cnmi),
        .PR_Dec_SP(_PR_Dec_SP_cnmi),
        .PI_SelectDt_PC_high(_PI_SelectDt_PC_high_cnmi),
        .PI_SelectDt_PC_low(_PI_SelectDt_PC_low_cnmi),
        .notPI_SelectAd_SP(_notPI_SelectAd_SP_cnmi),
        .PR_Reset_XPT(_PR_Reset_XPT_cnmi),
        .P2_Set_CM1(_P2_Set_CM1_cnmi),
        .P2_Reset_CNMI(P2_Reset_CNMI),
        .PA_Select_0x66_low(PA_Select_0x66_low),
        .PA_NOP(_PA_NOP_cnmi),
        .PR_Write_PC_high(_PR_Write_PC_high_cnmi),
        .PR_Write_PC_low(_PR_Write_PC_low_cnmi),
        .Pa_Ophd(_Pa_Ophd_cnmi),
        .not_decodingOut(_not_decodingOut_cnmi)
    );

    wire _PA_Select_0x38_low_cint0_rst;

    wire _not_decodingOut_cint0_rst;

    wire _enable_cint_cint0_rst;

    wire _is_11xx = notXPT[3] ~| notXPT[2];
    wire _is_xx00 = XPT[1] ~| XPT[0];
    wire _not_is_11xx = _is_11xx ~| _is_11xx;
    wire _not_is_xx00 = _is_xx00 ~| _is_xx00;
    wire _is_1100 = _not_is_11xx ~| _not_is_xx00;
    wire _not_isXPT12 = _is_1100 ~| _is_1100;

    DECODER_CINT0_RST cint0_rst(
        .not_decodingIn(_not_decodingOut_cnmi),
        .notCINT0_RST(notCINT0_RST),
        .OP5_3(OP[5:3]),
        .notOP5_3(notOP[5:3]),
        .not_isXPT12(_not_isXPT12),
        .enable_cint(_enable_cint_cint0_rst),
        .PA_Select_0x8_low(PA_Select_0x8_low),  // 001
        .PA_Select_0x10_low(PA_Select_0x10_low), // 010
        .PA_Select_0x18_low(PA_Select_0x18_low), // 011
        .PA_Select_0x20_low(PA_Select_0x20_low), // 100
        .PA_Select_0x28_low(PA_Select_0x28_low), // 101
        .PA_Select_0x30_low(PA_Select_0x30_low), // 110
        .PA_Select_0x38_low(_PA_Select_0x38_low_cint0_rst), // 111
        .not_decodingOut(_not_decodingOut_cint0_rst)
    );

    wire _PC_W0_cint0_call;
    wire _PC_W1_cint0_call;
    wire _PC_W2_cint0_call;
    wire _PR_Dec_SP_cint0_call;
    wire _PI_SelectDt_PC_high_cint0_call;
    wire _PI_SelectAd_SP_cint0_call;
    wire _PI_SelectDt_PC_low_cint0_call;
    wire _PR_Reset_XPT_cint0_call; // <
    wire _P2_Set_CM1_cint0_call;
    wire _P2_Reset_CINT_cint0_call;
    wire _PA_NOP_cint0_call;
    wire _PR_Write_PC_high_cint0_call;
    wire _PR_Write_PC_low_cint0_call;
    wire _Pa_Ophd_cint0_call; // >

    wire _not_decodingOut_cint0_call;

    DECODER_CINT0_CALL cint0_call(
        .not_decodingIn(_not_decodingOut_cint0_rst),
        .notCINT0_CALL(notCINT0_CALL),
        .XPT(XPT),
        .notXPT(notXPT),
        .PC_MR0(PC_MR0),
        .PC_MR1(PC_MR1),
        .PC_MR2(PC_MR2),
        .PC_W0(_PC_W0_cint0_call),
        .PC_W1(_PC_W1_cint0_call),
        .PC_W2(_PC_W2_cint0_call),
        .PR_Dec_SP(_PR_Dec_SP_cint0_call),
        .PI_SelectDt_PC_high(_PI_SelectDt_PC_high_cint0_call),
        .PI_SelectAd_SP(_PI_SelectAd_SP_cint0_call),
        .PI_SelectDt_PC_low(_PI_SelectDt_PC_low_cint0_call),
        .PR_Reset_XPT(_PR_Reset_XPT_cint0_call), // < 18
        .P2_Set_CM1(_P2_Set_CM1_cint0_call),
        .P2_Reset_CINT(_P2_Reset_CINT_cint0_call),
        .PA_Select_OPOPold_low(PA_Select_OPOPold_low),
        .PA_NOP(_PA_NOP_cint0_call),
        .PR_Write_PC_high(_PR_Write_PC_high_cint0_call),
        .PR_Write_PC_low(_PR_Write_PC_low_cint0_call),
        .Pa_Ophd(_Pa_Ophd_cint0_call), // >
        .not_decodingOut(_not_decodingOut_cint0_call)
    );

    wire _not_decodingOut_cint0;

    wire _enable_cint_cint0;
    wire _P2_Reset_CINT_cint0;

    DECODER_CINT0 cint0(
        .not_decodingIn(_not_decodingOut_cint0_call),
        .notCINT0(notCINT0),
        .OP1(OP[1]),
        .notXPT0(notXPT[0]),
        .XPT1(XPT[1]),
        .notXPT2(notXPT[2]),
        .enable_cint(_enable_cint_cint0),
        .P2_Reset_CINT(_P2_Reset_CINT_cint0),
        .P2_Set_CINT0_RST(P2_Set_CINT0_RST),
        .P2_Set_CINT0_CALL(P2_Set_CINT0_CALL),
        .not_decodingOut(_not_decodingOut_cint0)
    );

    wire _PA_Select_0x38_low_cint1;

    wire _not_decodingOut_cint1;

    wire _enable_cint_cint1;

    DECODER_CINT1 cint1(
        .not_decodingIn(_not_decodingOut_cint0),
        .notCINT1(notCINT1),
        .not_isXPT12(_not_isXPT12),
        .enable_cint(_enable_cint_cint1),
        .PA_Select_0x38_low(_PA_Select_0x38_low_cint1),
        .not_decodingOut(_not_decodingOut_cint1)
    );

    wire _not_decodingOut_cint2;

    wire _enable_cint_cint2;

    DECODER_CINT2 cint2(
        .not_decodingIn(_not_decodingOut_cint1),
        .notCINT2(notCINT2),
        .not_isXPT12(_not_isXPT12),
        .enable_cint(_enable_cint_cint2),
        .PA_Select_IOP_low(PA_Select_IOP_low),
        .not_decodingOut(_not_decodingOut_cint2)
    );

    wire _PC_W0_cint;
    wire _PC_W1_cint;
    wire _PC_W2_cint;
    wire _PA_NOP_cint;
    wire _PR_Halt_XPT_cint;
    wire _PR_Dec_SP_cint;
    wire _PI_SelectDt_PC_high_cint;
    wire _PI_SelectAd_SP_cint;
    wire _PI_SelectDt_PC_low_cint;
    wire _PR_Reset_XPT_cint; // <
    wire _P2_Set_CM1_cint;
    wire _P2_Reset_CINT_cint;
    wire _PR_Write_PC_high_cint;
    wire _PR_Write_PC_low_cint;
    wire _Pa_Ophd_cint; // >

    wire _enable_cint = ~(_enable_cint_cint0 | _enable_cint_cint0_rst | _enable_cint_cint1 | _enable_cint_cint2); // 5

    DECODER_cint cint(
        .notEnable(_enable_cint),
        .TWAIT(TWAIT),
        .XPT(XPT[3:0]),
        .notXPT(notXPT[3:0]),
        .PC_W0(_PC_W0_cint),
        .PC_W1(_PC_W1_cint),
        .PC_W2(_PC_W2_cint),
        .PI_SelectAd_PC(PI_SelectAd_PC), // < 1~3
        .PI_Flag_M1(PI_Flag_M1), // >
        .PI_Activate_Ad_high(PI_Activate_Ad_high), // < 1~5
        .PI_Activate_Ad_low(PI_Activate_Ad_low), // >
        .PhI_Flag_IORQ(PhI_Flag_IORQ),
        .PI_Flag_IORQ(PI_Flag_IORQ), // < 3
        .PA_Select_Din_low(PA_Select_Din_low),
        .PR_Write_OP(PR_Write_OP), // >
        .PA_NOP(_PA_NOP_cint),
        .PR_Halt_XPT(_PR_Halt_XPT_cint),
        .PI_SelectAd_IR(PI_SelectAd_IR), // < 4~5
        .PI_Flag_RFSH(PI_Flag_RFSH), // >
        .PhI_Flag_MREQ(PhI_Flag_MREQ),
        .PR_Inc_R(PR_Inc_R),
        .PR_Dec_SP(_PR_Dec_SP_cint),
        .PI_SelectDt_PC_high(_PI_SelectDt_PC_high_cint),
        .PI_SelectAd_SP(_PI_SelectAd_SP_cint),
        .PI_SelectDt_PC_low(_PI_SelectDt_PC_low_cint),
        .PR_Reset_XPT(_PR_Reset_XPT_cint), // < 12
        .P2_Set_CM1(_P2_Set_CM1_cint),
        .P2_Reset_CINT(_P2_Reset_CINT_cint),
        .PR_Write_PC_high(_PR_Write_PC_high_cint),
        .PR_Write_PC_low(_PR_Write_PC_low_cint),
        .Pa_Ophd(_Pa_Ophd_cint) // >
    );

    wire _PC_M1_cm1;

    wire _not_decodingOut_cm1;

    DECODER_CM1 cm1(
        .not_decodingIn(_not_decodingOut_cint2),
        .notCM1(notCM1),
        .XPT1(XPT[1]),
        .PC_M1(_PC_M1_cm1),
        .not_decodingOut(_not_decodingOut_cm1)
    );

    wire _not_decodingOut_cmr;

    DECODER_CMR cmr(
        .Clk(Clk),
        .not_decodingIn(_not_decodingOut_cm1),
        .notCMR(notCMR),
        .notXPT1(notXPT[1]),
        .PC_MR(PC_MR),
        .PD_Source_Dtcs(PD_Source_Dtcs),
        .not_decodingOut(_not_decodingOut_cmr)
    );

    DECODER_CMA cma(
        .Clk(Clk),
        .not_decodingIn(_not_decodingOut_cmr),
        .notCMA(notCMA),
        .notXPT1(notXPT[1]),
        .PC_MA(PC_MA),
        .not_decodingOut(not_decodingOut)
    );

    // call cint
    wire _call_cint = (_P2_Reset_CINT_cint0_call | _P2_Reset_CINT_cint); // 2
    assign P2_Reset_CINT = (_call_cint | _P2_Reset_CINT_cint0); // 2

    // call cnmi creset +
    wire _cnmi_creset = (_PA_NOP_creset | _PA_NOP_cnmi); // 2

    assign PA_NOP = (_cnmi_creset | _PA_NOP_cint0_call | _PA_NOP_cint); // 6

    // call cint creset cnmi
    assign PR_Write_PC_low = (_cnmi_creset | _call_cint); // 2
    assign PR_Write_PC_high = PR_Write_PC_low;

    // call cint creset cnmi cbusrq
    assign Pa_Ophd = (PR_Write_PC_low | _Pa_Ophd_cbusrq); // 2
    assign P2_Set_CM1 = Pa_Ophd;
    assign PR_Reset_XPT = Pa_Ophd;

    assign PR_Halt_XPT = (_PR_Halt_XPT_cbusrq | _PR_Halt_XPT_cint); // 2

    assign PC_M1 = (_PC_M1_cnmi | _PC_M1_cm1); // 2

    assign PC_W0 = (_PC_W0_cnmi | _PC_W0_cint0_call | _PC_W0_cint); // 4
    assign PC_W1 = (_PC_W1_cnmi | _PC_W1_cint0_call | _PC_W1_cint); // 4
    assign PC_W2 = (_PC_W2_cnmi | _PC_W2_cint0_call | _PC_W2_cint); // 4

    assign PR_Dec_SP = (_PR_Dec_SP_cnmi | _PR_Dec_SP_cint0_call | _PR_Dec_SP_cint); // 4

    assign PI_SelectDt_PC_high = (_PI_SelectDt_PC_high_cnmi | _PI_SelectDt_PC_high_cint0_call | _PI_SelectDt_PC_high_cint); // 4
    assign PI_SelectDt_PC_low = (_PI_SelectDt_PC_low_cnmi | _PI_SelectDt_PC_low_cint0_call | _PI_SelectDt_PC_low_cint); // 4

    assign PA_Select_0x38_low = (_PA_Select_0x38_low_cint0_rst | _PA_Select_0x38_low_cint1); // 2

    wire _PI_SelectAd_SP_cnmi = _notPI_SelectAd_SP_cnmi~|_notPI_SelectAd_SP_cnmi;
    assign PI_SelectAd_SP = (_PI_SelectAd_SP_cnmi | _PI_SelectAd_SP_cint0_call | _PI_SelectAd_SP_cint); // 4


endmodule