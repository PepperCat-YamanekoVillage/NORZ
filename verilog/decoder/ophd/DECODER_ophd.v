// 10(37)
module DECODER_ophd(
        input wire Clk,
        input wire notClk,
        input wire decodingIn,
        input wire notPa_ophd,
        input wire BUSRQ,
        input wire TNMI,
        input wire TINT,
        input wire notIFF1,
        input wire IMFa,
        input wire IMFb,
        output wire P2_Set_CBUSRQ,
        output wire PI_Nullify_MREQ,
        output wire PI_Nullify_RD,
        output wire PI_Nullify_WR,
        output wire PI_Nullify_IORQ,
        output wire PI_Flag_BUSAK,
        output wire PR_Halt_XPT,
        output wire PhI_Flag_BUSAK,
        output wire P2_Set_CNMI,
        output wire P2_Reset_TNMI,
        output wire P2_Reset_LHALT,
        output wire P2_EvacuateIFF,
        output wire P2_Reset_IFF1,
        output wire PC_M1,
        output wire P2_Set_CINT0,
        output wire P2_Set_CINT1,
        output wire P2_Set_CINT2,
        output wire P2_Reset_TINT,
        output wire P2_Reset_IFF2,
        output wire PI_Activate_Ad_high,
        output wire PI_Activate_Ad_low,
        output wire PI_SelectAd_PC,
        output wire PI_Flag_M1,
        output wire not_decodingOut
    );

    // wire notClk = ~Clk;

    wire _notP_ophd;

    DECODER_dff dff(
        .Clk(Clk),
        .notClk(notClk),
        .notD(notPa_ophd),
        .notQ(_notP_ophd)
    );

    wire _not_decodingIn = decodingIn ~| decodingIn;
    wire _enable_busrq = _not_decodingIn ~| _notP_ophd;
    wire _not_enable_busrq = _enable_busrq ~| _enable_busrq;

    wire _P2_Reset_LHALT_nmi;
    wire _P2_Reset_LHALT_int;
    wire _P2_Reset_IFF1_nmi;
    wire _P2_Reset_IFF1_int;

    assign P2_Reset_LHALT = _P2_Reset_LHALT_nmi | _P2_Reset_LHALT_int; // 2
    assign P2_Reset_IFF1 = _P2_Reset_IFF1_nmi | _P2_Reset_IFF1_int; // 2

    wire _not_enable_nmi;
    wire _not_enable_int;

    wire _enable;
    wire _0 = _enable ~| _notP_ophd;
    wire _decodingOut = _0 ~| _not_decodingIn;
    assign not_decodingOut = _decodingOut ~| _decodingOut;

    DECODER_ophd_busrq busrq(
        .BUSRQ(BUSRQ),
        .not_enable_busrq(_not_enable_busrq),
        .P2_Set_CBUSRQ(P2_Set_CBUSRQ),
        .PI_Nullify_MREQ(PI_Nullify_MREQ),
        .PI_Nullify_RD(PI_Nullify_RD),
        .PI_Nullify_WR(PI_Nullify_WR),
        .PI_Nullify_IORQ(PI_Nullify_IORQ),
        .PI_Flag_BUSAK(PI_Flag_BUSAK),
        .PR_Halt_XPT(PR_Halt_XPT),
        .PhI_Flag_BUSAK(PhI_Flag_BUSAK),
        .not_enable_nmi(_not_enable_nmi)
    );

    DECODER_ophd_nmi nmi(
        .TNMI(TNMI),
        .not_enable_nmi(_not_enable_nmi),
        .P2_Set_CNMI(P2_Set_CNMI),
        .P2_Reset_TNMI(P2_Reset_TNMI),
        .P2_Reset_LHALT(_P2_Reset_LHALT_nmi),
        .P2_EvacuateIFF(P2_EvacuateIFF),
        .P2_Reset_IFF1(_P2_Reset_IFF1_nmi),
        .PC_M1(PC_M1),
        .not_enable_int(_not_enable_int)
    );

    DECODER_ophd_int int_(
        .TINT(TINT),
        .notIFF1(notIFF1),
        .IMFa(IMFa),
        .IMFb(IMFb),
        .not_enable_int(_not_enable_int),
        .P2_Set_CINT0(P2_Set_CINT0),
        .P2_Set_CINT1(P2_Set_CINT1),
        .P2_Set_CINT2(P2_Set_CINT2),
        .P2_Reset_LHALT(_P2_Reset_LHALT_int),
        .P2_Reset_TINT(P2_Reset_TINT),
        .P2_Reset_IFF1(_P2_Reset_IFF1_int),
        .P2_Reset_IFF2(P2_Reset_IFF2),
        .PI_Activate_Ad_high(PI_Activate_Ad_high),
        .PI_Activate_Ad_low(PI_Activate_Ad_low),
        .PI_SelectAd_PC(PI_SelectAd_PC),
        .PI_Flag_M1(PI_Flag_M1),
        .enable(_enable)
    );

endmodule