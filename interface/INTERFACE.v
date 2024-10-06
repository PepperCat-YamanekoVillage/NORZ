// (952)
module INTERFACE(
        input wire [7:0] notA,
        input wire [7:0] notF,
        input wire [7:0] notB,
        input wire [7:0] notC,
        input wire [7:0] notD,
        input wire [7:0] notE,
        input wire [7:0] notH,
        input wire [7:0] notL,
        input wire [7:0] notDt,
        input wire [7:0] notDtex,
        input wire [7:0] notR,
        input wire [7:0] notI,
        input wire [7:0] notOP,
        input wire [7:0] notOPold,
        input wire [15:0] notPC,
        input wire [15:0] notSP,
        input wire [15:0] notIX,
        input wire [15:0] notIY,
        input wire [15:0] notALU,
        // Ad
        input wire notPI_SelectAd_PC,
        input wire notPI_SelectAd_SP,
        input wire notPI_SelectAd_BC,
        input wire notPI_SelectAd_DE,
        input wire notPI_SelectAd_HL,
        input wire notPI_SelectAd_IR,
        input wire notPI_SelectAd_DtexDt,
        input wire notPI_SelectAd_OPOPold,
        input wire notPI_SelectAd_ALU,
        input wire notPI_SelectAd_AOP,
        input wire PI_SelectAdt1,
        input wire notPI_Activate_Ad_high,
        input wire notPI_Activate_Ad_low,
        // Dt
        input wire notPI_SelectDt_PC_high,
        input wire notPI_SelectDt_PC_low,
        input wire notPI_SelectDt_IX_high,
        input wire notPI_SelectDt_IX_low,
        input wire notPI_SelectDt_IY_high,
        input wire notPI_SelectDt_IY_low,
        input wire notPI_SelectDt_A,
        input wire notPI_SelectDt_F,
        input wire notPI_SelectDt_B,
        input wire notPI_SelectDt_C,
        input wire notPI_SelectDt_D,
        input wire notPI_SelectDt_E,
        input wire notPI_SelectDt_H,
        input wire notPI_SelectDt_L,
        input wire notPI_SelectDt_OP,
        input wire notPI_SelectDt_Dt,
        input wire notPI_SelectDt_Dtex,
        input wire notPI_SelectDt_SP_low,
        input wire notPI_SelectDt_SP_high,
        input wire notPI_Activate_Dt,
        // out
        input wire notPI_Flag_BUSAK,
        input wire notPI_Flag_RFSH,
        input wire notPI_Flag_M1,
        input wire notPI_Flag_HALT,
        input wire PI_Nullify_MREQ,
        input wire PI_Nullify_RD,
        input wire PI_Nullify_WR,
        input wire PI_Nullify_IORQ,
        input wire notPI_Flag_MREQ,
        input wire notPI_Flag_RD,
        input wire notPI_Flag_WR,
        input wire notPI_Flag_IORQ,
        // interface
        output wire [15:0] interfaceAd,
        // 本当はinterfaceDt_inとinterfaceDt_outはinoutで同一だけどdigitalJSがエラーおこすので分けている
        input wire [7:0] interfaceDt_in,
        output wire [7:0] interfaceDt_out,
        output wire [7:0] Din,
        output wire interfaceBUSAK,
        output wire interfaceRFSH,
        output wire interfaceM1,
        output wire interfaceHALT,
        output wire interfaceMREQ,
        output wire interfaceRD,
        output wire interfaceWR,
        output wire interfaceIORQ
    );

    wire [15:0] _notSelectedAd;

    INTERFACE_Ad_mux admux(
        .notA(notA),
        .notB(notB),
        .notC(notC),
        .notD(notD),
        .notE(notE),
        .notH(notH),
        .notL(notL),
        .notDt(notDt),
        .notDtex(notDtex),
        .notR(notR),
        .notI(notI),
        .notOP(notOP),
        .notOPold(notOPold),
        .notPC(notPC),
        .notSP(notSP),
        .notALU(notALU),
        .notPI_SelectAd_PC(notPI_SelectAd_PC),
        .notPI_SelectAd_SP(notPI_SelectAd_SP),
        .notPI_SelectAd_BC(notPI_SelectAd_BC),
        .notPI_SelectAd_DE(notPI_SelectAd_DE),
        .notPI_SelectAd_HL(notPI_SelectAd_HL),
        .notPI_SelectAd_IR(notPI_SelectAd_IR),
        .notPI_SelectAd_DtexDt(notPI_SelectAd_DtexDt),
        .notPI_SelectAd_OPOPold(notPI_SelectAd_OPOPold),
        .notPI_SelectAd_ALU(notPI_SelectAd_ALU),
        .notPI_SelectAd_AOP(notPI_SelectAd_AOP),
        .notSelectedAd(_notSelectedAd)
    );

    wire [7:0] _selectedDt;

    INTERFACE_A a(
        .PI_SelectAdt1(PI_SelectAdt1),
        .notPI_Activate_Ad_high(notPI_Activate_Ad_high),
        .notPI_Activate_Ad_low(notPI_Activate_Ad_low),
        .notSelectedAd(_notSelectedAd),
        .interfaceAd(interfaceAd)
    );

    INTERFACE_Dt_mux dtmux(
        .notA(notA),
        .notF(notF),
        .notB(notB),
        .notC(notC),
        .notD(notD),
        .notE(notE),
        .notH(notH),
        .notL(notL),
        .notDt(notDt),
        .notDtex(notDtex),
        .notOP(notOP),
        .notPC(notPC),
        .notIX(notIX),
        .notIY(notIY),
        .notSP(notSP),
        .notPI_SelectDt_PC_high(notPI_SelectDt_PC_high),
        .notPI_SelectDt_PC_low(notPI_SelectDt_PC_low),
        .notPI_SelectDt_IX_high(notPI_SelectDt_IX_high),
        .notPI_SelectDt_IX_low(notPI_SelectDt_IX_low),
        .notPI_SelectDt_IY_high(notPI_SelectDt_IY_high),
        .notPI_SelectDt_IY_low(notPI_SelectDt_IY_low),
        .notPI_SelectDt_A(notPI_SelectDt_A),
        .notPI_SelectDt_F(notPI_SelectDt_F),
        .notPI_SelectDt_B(notPI_SelectDt_B),
        .notPI_SelectDt_C(notPI_SelectDt_C),
        .notPI_SelectDt_D(notPI_SelectDt_D),
        .notPI_SelectDt_E(notPI_SelectDt_E),
        .notPI_SelectDt_H(notPI_SelectDt_H),
        .notPI_SelectDt_L(notPI_SelectDt_L),
        .notPI_SelectDt_OP(notPI_SelectDt_OP),
        .notPI_SelectDt_Dt(notPI_SelectDt_Dt),
        .notPI_SelectDt_Dtex(notPI_SelectDt_Dtex),
        .notPI_SelectDt_SP_low(notPI_SelectDt_SP_low),
        .notPI_SelectDt_SP_high(notPI_SelectDt_SP_high),
        .selectedDt(_selectedDt)
    );

    INTERFACE_D d(
        .notPI_Activate_Dt(notPI_Activate_Dt),
        .interfaceDt_in(interfaceDt_in),
        .interfaceDt_out(interfaceDt_out),
        .selectedDt(_selectedDt),
        .Din(Din)
    );

    INTERFACE_out2 BUSAK(
        .notPI_Flag(notPI_Flag_BUSAK),
        .interface(interfaceBUSAK)
    );

    INTERFACE_out2 RFSH(
        .notPI_Flag(notPI_Flag_RFSH),
        .interface(interfaceRFSH)
    );

    INTERFACE_out2 M1(
        .notPI_Flag(notPI_Flag_M1),
        .interface(interfaceM1)
    );

    INTERFACE_out2 HALT(
        .notPI_Flag(notPI_Flag_HALT),
        .interface(interfaceHALT)
    );

    INTERFACE_out3 MREQ(
        .PI_Nullify(PI_Nullify_MREQ),
        .notPI_Flag(notPI_Flag_MREQ),
        .interface(interfaceMREQ)
    );

    INTERFACE_out3 RD(
        .PI_Nullify(PI_Nullify_RD),
        .notPI_Flag(notPI_Flag_RD),
        .interface(interfaceRD)
    );

    INTERFACE_out3 WR(
        .PI_Nullify(PI_Nullify_WR),
        .notPI_Flag(notPI_Flag_WR),
        .interface(interfaceWR)
    );

    INTERFACE_out3 IORQ(
        .PI_Nullify(PI_Nullify_IORQ),
        .notPI_Flag(notPI_Flag_IORQ),
        .interface(interfaceIORQ)
    );

endmodule