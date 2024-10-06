// 3(3834)
module REGISTER(
        input wire Clk,
        input wire notClk,
        input wire [15:0] notALUResult,
        input wire [7:0] Din,
        input wire notALULow0,
        input wire notALULow7,
        input wire notCY4,
        input wire notCY8,
        input wire CY12,
        input wire CY16,
        input wire notIs8bitEqual,
        input wire notIsResultLow0,
        input wire isResult0,
        input wire DAA_Flag_H,
        input wire IFF2,
        input wire CINT,
        input wire is16bitEqual,
        input wire is8bitOverflow,
        input wire notIs8bitEvenParity,
        input wire is16bitOverflow,
        input wire PR_InvertIn,
        // AF
        input wire PR_Write_A,
        input wire PR_Ex_AF_AF,
        input wire PF_Write_S,
        input wire notPF_Select_S_bit7,
        input wire notPF_Select_S_bit15,
        input wire notPF_Select_S_bit23,
        input wire PF_Write_Z,
        input wire notPF_Select_Z_bit19,
        input wire notPF_Select_Z_bit21,
        input wire notPF_Select_Z_bit24,
        input wire notPF_Select_Z_bit34,
        input wire notPF_Select_Z_bit40,
        input wire notPF_Select_Z_bit41,
        input wire notPF_Select_Z_bit42,
        input wire notPF_Select_Z_bit43,
        input wire notPF_Select_Z_bit44,
        input wire notPF_Select_Z_bit45,
        input wire notPF_Select_Z_bit46,
        input wire notPF_Select_Z_bit47,
        input wire PF_Write_H,
        input wire PF_Select_H_bit17,
        input wire notPF_Select_H_bit21,
        input wire notPF_Select_H_bit22,
        input wire notPF_Select_H_bit28,
        input wire notPF_Select_H_bit30,
        input wire notPF_Select_H_bit31,
        input wire notPF_Select_H_bit35,
        input wire PF_Write_PV,
        input wire notPF_Select_PV_bit18,
        input wire notPF_Select_PV_bit20,
        input wire notPF_Select_PV_bit25,
        input wire notPF_Select_PV_bit27,
        input wire notPF_Select_PV_bit33,
        input wire PF_Write_C,
        input wire PF_Select_C_bit17,
        input wire notPF_Select_C_bit23,
        input wire notPF_Select_C_bit26,
        input wire notPF_Select_C_bit29,
        input wire notPF_Select_C_bit32,
        input wire notPF_Select_C_bit36,
        input wire notPF_Select_C_bit37,
        input wire notPF_Select_C_bit38,
        input wire PF_Select_C_bit0,
        input wire PF_Write_N,
        input wire PF_Select_N_bit17,
        input wire PR_Write_F,
        // BC
        input wire PR_Exx,
        input wire PR_Write_B,
        input wire PR_Write_C,
        // DE
        input wire PR_EX_DE_HL,
        input wire PR_Write_D,
        input wire PR_Write_E,
        // HL
        input wire PR_Write_H,
        input wire PR_Write_L,
        // PC
        input wire PR_Write_PC_high,
        input wire PR_Write_PC_low,
        input wire PR_Inc_PC,
        // SP
        input wire PR_Write_SP_high,
        input wire PR_Write_SP_low,
        input wire PR_Inc_SP,
        input wire PR_Dec_SP,
        // IX
        input wire PR_Write_IX_high,
        input wire PR_Write_IX_low,
        // IY
        input wire PR_Write_IY_high,
        input wire PR_Write_IY_low,
        // I
        input wire PR_Write_I,
        // Dt
        input wire PR_Write_Dt,
        // Dtex
        input wire PR_Write_Dtex,
        // Dtcs
        input wire PI_ReadDtcs,
        // OP
        input wire PR_Write_OP,
        // OPold
        input wire PR_SlideOP,
        // R
        input wire PR_Write_R,
        input wire PR_Inc_R,
        // XPT
        input wire PR_Reset_XPT,
        input wire notPR_Halt_XPT,
        output wire [7:0] notA,
        output wire [7:0] notF,
        output wire [7:0] notB,
        output wire [7:0] notC,
        output wire [7:0] notD,
        output wire [7:0] notE,
        output wire [7:0] notH,
        output wire [7:0] notL,
        output wire [15:0] notPC,
        output wire [15:0] notSP,
        output wire [15:0] notIX,
        output wire [15:0] notIY,
        output wire [7:0] notI,
        output wire [7:0] notDt,
        output wire [7:0] notDtex,
        output wire [7:0] Dtcs,
        output wire [7:0] notDtcs,
        output wire [7:0] OP,
        output wire [7:0] notOP,
        output wire [7:0] OPold,
        output wire [7:0] notOPold,
        output wire [7:0] notR,
        output wire [4:0] XPT,
        output wire [4:0] notXPT
    );

    // wire notClk = ~Clk;

    wire [15:0] _invertedNotALUResult;

    //
    // Invert
    //

    REGISTER_invert invert(
        .notALUResult(notALUResult),
        .PR_InvertIn(PR_InvertIn),
        .invertedNotALUResult(_invertedNotALUResult)
    );

    //
    // AF
    //

    wire [7:0] _notShadowA;
    wire [7:0] _notShadowF;
    wire _notPR_Ex_AF_AF = PR_Ex_AF_AF ~| PR_Ex_AF_AF;

    REGISTER_A A(
        .Clk(Clk),
        .notClk(notClk),
        .notALUResult(_invertedNotALUResult[15:8]),
        .notShadowA(_notShadowA),
        .PR_Write(PR_Write_A),
        .PR_Ex(PR_Ex_AF_AF),
        .notPR_Ex(_notPR_Ex_AF_AF),
        .notA(notA)
    );

    REGISTER_shadow shadowA(
        .Clk(Clk),
        .notClk(notClk),
        .notA(notA),
        .PR_Ex(PR_Ex_AF_AF),
        .notPR_Ex(_notPR_Ex_AF_AF),
        .notShadowA(_notShadowA)
    );

    REGISTER_F F(
        .Clk(Clk),
        .notClk(notClk),
        .notALUResult(notALUResult[7:0]),
        .notALUResult15(notALUResult[15]),
        .notShadowF(_notShadowF),
        .notALULow0(notALULow0),
        .notALULow7(notALULow7),
        .notCY4(notCY4),
        .notCY8(notCY8),
        .CY12(CY12),
        .CY16(CY16),
        .notIs8bitEqual(notIs8bitEqual),
        .notIsResultLow0(notIsResultLow0),
        .isResult0(isResult0),
        .DAA_Flag_H(DAA_Flag_H),
        .IFF2(IFF2),
        .CINT(CINT),
        .is16bitEqual(is16bitEqual),
        .is8bitOverflow(is8bitOverflow),
        .notIs8bitEvenParity(notIs8bitEvenParity),
        .is16bitOverflow(is16bitOverflow),
        .PF_Write_S(PF_Write_S),
        .notPF_Select_S_bit7(notPF_Select_S_bit7),
        .notPF_Select_S_bit15(notPF_Select_S_bit15),
        .notPF_Select_S_bit23(notPF_Select_S_bit23),
        .PF_Write_Z(PF_Write_Z),
        .notPF_Select_Z_bit19(notPF_Select_Z_bit19),
        .notPF_Select_Z_bit21(notPF_Select_Z_bit21),
        .notPF_Select_Z_bit24(notPF_Select_Z_bit24),
        .notPF_Select_Z_bit34(notPF_Select_Z_bit34),
        .notPF_Select_Z_bit40(notPF_Select_Z_bit40),
        .notPF_Select_Z_bit41(notPF_Select_Z_bit41),
        .notPF_Select_Z_bit42(notPF_Select_Z_bit42),
        .notPF_Select_Z_bit43(notPF_Select_Z_bit43),
        .notPF_Select_Z_bit44(notPF_Select_Z_bit44),
        .notPF_Select_Z_bit45(notPF_Select_Z_bit45),
        .notPF_Select_Z_bit46(notPF_Select_Z_bit46),
        .notPF_Select_Z_bit47(notPF_Select_Z_bit47),
        .PF_Write_H(PF_Write_H),
        .PF_Select_H_bit17(PF_Select_H_bit17),
        .notPF_Select_H_bit21(notPF_Select_H_bit21),
        .notPF_Select_H_bit22(notPF_Select_H_bit22),
        .notPF_Select_H_bit28(notPF_Select_H_bit28),
        .notPF_Select_H_bit30(notPF_Select_H_bit30),
        .notPF_Select_H_bit31(notPF_Select_H_bit31),
        .notPF_Select_H_bit35(notPF_Select_H_bit35),
        .PF_Write_PV(PF_Write_PV),
        .notPF_Select_PV_bit18(notPF_Select_PV_bit18),
        .notPF_Select_PV_bit20(notPF_Select_PV_bit20),
        .notPF_Select_PV_bit25(notPF_Select_PV_bit25),
        .notPF_Select_PV_bit27(notPF_Select_PV_bit27),
        .notPF_Select_PV_bit33(notPF_Select_PV_bit33),
        .PF_Write_C(PF_Write_C),
        .PF_Select_C_bit17(PF_Select_C_bit17),
        .notPF_Select_C_bit23(notPF_Select_C_bit23),
        .notPF_Select_C_bit26(notPF_Select_C_bit26),
        .notPF_Select_C_bit29(notPF_Select_C_bit29),
        .notPF_Select_C_bit32(notPF_Select_C_bit32),
        .notPF_Select_C_bit36(notPF_Select_C_bit36),
        .notPF_Select_C_bit37(notPF_Select_C_bit37),
        .notPF_Select_C_bit38(notPF_Select_C_bit38),
        .PF_Select_C_bit0(PF_Select_C_bit0),
        .PF_Write_N(PF_Write_N),
        .PF_Select_N_bit17(PF_Select_N_bit17),
        .PR_Ex(PR_Ex_AF_AF),
        .notPR_Ex(_notPR_Ex_AF_AF),
        .PR_Write_F(PR_Write_F),
        .notF(notF)
    );

    REGISTER_shadow shadowF(
        .Clk(Clk),
        .notClk(notClk),
        .notA(notF),
        .PR_Ex(PR_Ex_AF_AF),
        .notPR_Ex(_notPR_Ex_AF_AF),
        .notShadowA(_notShadowF)
    );

    //
    // BC
    //

    wire [7:0] _notShadowB;
    wire [7:0] _notShadowC;

    wire _notPR_Exx = PR_Exx ~| PR_Exx;

    REGISTER_A B(
        .Clk(Clk),
        .notClk(notClk),
        .notALUResult(_invertedNotALUResult[15:8]),
        .notShadowA(_notShadowB),
        .PR_Write(PR_Write_B),
        .PR_Ex(PR_Exx),
        .notPR_Ex(_notPR_Exx),
        .notA(notB)
    );

    REGISTER_shadow shadowB(
        .Clk(Clk),
        .notClk(notClk),
        .notA(notB),
        .PR_Ex(PR_Exx),
        .notPR_Ex(_notPR_Exx),
        .notShadowA(_notShadowB)
    );

    REGISTER_A C(
        .Clk(Clk),
        .notClk(notClk),
        .notALUResult(_invertedNotALUResult[7:0]),
        .notShadowA(_notShadowC),
        .PR_Write(PR_Write_C),
        .PR_Ex(PR_Exx),
        .notPR_Ex(_notPR_Exx),
        .notA(notC)
    );

    REGISTER_shadow shadowC(
        .Clk(Clk),
        .notClk(notClk),
        .notA(notC),
        .PR_Ex(PR_Exx),
        .notPR_Ex(_notPR_Exx),
        .notShadowA(_notShadowC)
    );

    //
    // DE
    //

    wire [7:0] _notShadowD;
    wire [7:0] _notShadowE;

    wire _notPR_EX_DE_HL = PR_EX_DE_HL ~| PR_EX_DE_HL;

    REGISTER_D D(
        .Clk(Clk),
        .notClk(notClk),
        .notALUResult(_invertedNotALUResult[15:8]),
        .notShadowD(_notShadowD),
        .notH(notH),
        .PR_Write(PR_Write_D),
        .PR_Ex(PR_EX_DE_HL),
        .notPR_Ex(_notPR_EX_DE_HL),
        .PR_Exx(PR_Exx),
        .notPR_Exx(_notPR_Exx),
        .notD(notD)
    );

    REGISTER_shadow shadowD(
        .Clk(Clk),
        .notClk(notClk),
        .notA(notD),
        .PR_Ex(PR_Exx),
        .notPR_Ex(_notPR_Exx),
        .notShadowA(_notShadowD)
    );

    REGISTER_D E(
        .Clk(Clk),
        .notClk(notClk),
        .notALUResult(_invertedNotALUResult[7:0]),
        .notShadowD(_notShadowE),
        .notH(notL),
        .PR_Write(PR_Write_E),
        .PR_Ex(PR_EX_DE_HL),
        .notPR_Ex(_notPR_EX_DE_HL),
        .PR_Exx(PR_Exx),
        .notPR_Exx(_notPR_Exx),
        .notD(notE)
    );

    REGISTER_shadow shadowE(
        .Clk(Clk),
        .notClk(notClk),
        .notA(notE),
        .PR_Ex(PR_Exx),
        .notPR_Ex(_notPR_Exx),
        .notShadowA(_notShadowE)
    );

    //
    // HL
    //

    wire [7:0] _notShadowH;
    wire [7:0] _notShadowL;

    REGISTER_D H(
        .Clk(Clk),
        .notClk(notClk),
        .notALUResult(_invertedNotALUResult[15:8]),
        .notShadowD(_notShadowH),
        .notH(notD),
        .PR_Write(PR_Write_H),
        .PR_Ex(PR_EX_DE_HL),
        .notPR_Ex(_notPR_EX_DE_HL),
        .PR_Exx(PR_Exx),
        .notPR_Exx(_notPR_Exx),
        .notD(notH)
    );

    REGISTER_shadow shadowH(
        .Clk(Clk),
        .notClk(notClk),
        .notA(notH),
        .PR_Ex(PR_Exx),
        .notPR_Ex(_notPR_Exx),
        .notShadowA(_notShadowH)
    );

    REGISTER_D L(
        .Clk(Clk),
        .notClk(notClk),
        .notALUResult(_invertedNotALUResult[7:0]),
        .notShadowD(_notShadowL),
        .notH(notE),
        .PR_Write(PR_Write_L),
        .PR_Ex(PR_EX_DE_HL),
        .notPR_Ex(_notPR_EX_DE_HL),
        .PR_Exx(PR_Exx),
        .notPR_Exx(_notPR_Exx),
        .notD(notL)
    );

    REGISTER_shadow shadowL(
        .Clk(Clk),
        .notClk(notClk),
        .notA(notL),
        .PR_Ex(PR_Exx),
        .notPR_Ex(_notPR_Exx),
        .notShadowA(_notShadowL)
    );

    //
    // PC
    //

    REGISTER_PC PC(
        .Clk(Clk),
        .notClk(notClk),
        .notALUResult(_invertedNotALUResult),
        .PR_Write_PC_high(PR_Write_PC_high),
        .PR_Write_PC_low(PR_Write_PC_low),
        .PR_Inc_PC(PR_Inc_PC),
        .notPC(notPC)
    );

    //
    // SP
    //

    REGISTER_SP SP(
        .Clk(Clk),
        .notClk(notClk),
        .notALUResult(_invertedNotALUResult),
        .PR_Write_SP_high(PR_Write_SP_high),
        .PR_Write_SP_low(PR_Write_SP_low),
        .PR_Inc_SP(PR_Inc_SP),
        .PR_Dec_SP(PR_Dec_SP),
        .notSP(notSP)
    );

    //
    // IX
    //

    REGISTER_IX IX(
        .Clk(Clk),
        .notClk(notClk),
        .notALUResult(_invertedNotALUResult),
        .PR_Write_IX_high(PR_Write_IX_high),
        .PR_Write_IX_low(PR_Write_IX_low),
        .notIX(notIX)
    );

    //
    // IY
    //

    REGISTER_IX IY(
        .Clk(Clk),
        .notClk(notClk),
        .notALUResult(_invertedNotALUResult),
        .PR_Write_IX_high(PR_Write_IY_high),
        .PR_Write_IX_low(PR_Write_IY_low),
        .notIX(notIY)
    );

    //
    // I
    //

    REGISTER_I I(
        .Clk(Clk),
        .notClk(notClk),
        .notALUResult(_invertedNotALUResult[15:8]),
        .PR_Write_I(PR_Write_I),
        .notI(notI)
    );

    //
    // DtexDt
    //

    REGISTER_I Dtex(
        .Clk(Clk),
        .notClk(notClk),
        .notALUResult(_invertedNotALUResult[15:8]),
        .PR_Write_I(PR_Write_Dtex),
        .notI(notDtex)
    );

    REGISTER_I Dt(
        .Clk(Clk),
        .notClk(notClk),
        .notALUResult(_invertedNotALUResult[7:0]),
        .PR_Write_I(PR_Write_Dt),
        .notI(notDt)
    );

    //
    // Dtcs
    //

    REGISTER_I Dtcs_(
        .Clk(notClk),
        .notClk(Clk),
        .notALUResult(Din),
        .PR_Write_I(PI_ReadDtcs),
        .I(notDtcs),
        .notI(Dtcs)
    );

    //
    // OPOPold
    //

    REGISTER_I OP_(
        .Clk(Clk),
        .notClk(notClk),
        .notALUResult(notALUResult[7:0]),
        .PR_Write_I(PR_Write_OP),
        .I(OP),
        .notI(notOP)
    );

    REGISTER_I OPold_(
        .Clk(Clk),
        .notClk(notClk),
        .notALUResult(notOP),
        .PR_Write_I(PR_SlideOP),
        .I(OPold),
        .notI(notOPold)
    );

    //
    // R
    //

    REGISTER_R R(
        .Clk(Clk),
        .notClk(notClk),
        .notALUResult(_invertedNotALUResult[7:0]),
        .PR_Write_R(PR_Write_R),
        .PR_Inc_R(PR_Inc_R),
        .notR(notR)
    );

    //
    // XPT
    //

    REGISTER_XPT XPT_(
        .Clk(Clk),
        .notClk(notClk),
        .PR_Reset_XPT(PR_Reset_XPT),
        .notPR_Halt_XPT(notPR_Halt_XPT),
        .XPT(XPT),
        .notXPT(notXPT)
    );

endmodule