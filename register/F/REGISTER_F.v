// 11(256)
module REGISTER_F(
        // input wire clk,
        input wire Clk,
        input wire notClk,
        input wire [7:0] notALUResult,
        input wire notALUResult15,
        input wire [7:0] notShadowF,
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
        input wire PR_Ex,
        input wire notPR_Ex,
        input wire PR_Write_F,
        output wire [7:0] F,
        output wire [7:0] notF
    );

    // wire Clk = clk;
    // wire notClk = ~clk;
    // wire notPR_Ex = ~PR_Ex;

    wire _notPR_Write_F = PR_Write_F ~| PR_Write_F;

    // or

    wire _not_SZ = PF_Write_S ~| PF_Write_Z;
    wire _SZ = _not_SZ ~| _not_SZ;
    wire _not_HPV = PF_Write_H ~| PF_Write_PV;
    wire _HPV = _not_HPV ~| _not_HPV;
    wire _not_CN = PF_Write_C ~| PF_Write_N;
    wire _CN = _not_CN ~| _not_CN;

    wire _not_SZHPV = _SZ ~| _HPV;
    wire _SZHPV = _not_SZHPV ~| _not_SZHPV;

    wire _notPF_Write_X = _CN ~| _SZHPV;

    wire _PF_Write_X = _notPF_Write_X ~| _notPF_Write_X;

    REGISTER_F_S s(
        .Clk(Clk),
        .notClk(notClk),
        .notALUResult7(notALUResult[7]),
        .notALUResult15(notALUResult15),
        .notShadowF_S(notShadowF[7]),
        .notCY8(notCY8),
        .PF_Write_S(PF_Write_S),
        .notPF_Select_S_bit7(notPF_Select_S_bit7),
        .notPF_Select_S_bit15(notPF_Select_S_bit15),
        .notPF_Select_S_bit23(notPF_Select_S_bit23),
        .PR_Ex(PR_Ex),
        .notPR_Ex(notPR_Ex),
        .PR_Write(PR_Write_F),
        .notPR_Write(_notPR_Write_F),
        .F_S(F[7]),
        .notF_S(notF[7])
    );

    REGISTER_F_Z z(
        .Clk(Clk),
        .notClk(notClk),
        .notALUResult(notALUResult),
        .notShadowF_Z(notShadowF[6]),
        .notIs8bitEqual(notIs8bitEqual),
        .notCY4(notCY4),
        .notIsResultLow0(notIsResultLow0),
        .isResult0(isResult0),
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
        .PR_Ex(PR_Ex),
        .notPR_Ex(notPR_Ex),
        .PR_Write(PR_Write_F),
        .notPR_Write(_notPR_Write_F),
        .F_Z(F[6]),
        .notF_Z(notF[6])
    );

    REGISTER_F_X x(
        .Clk(Clk),
        .notClk(notClk),
        .notALUResult5(notALUResult[5]),
        .notShadowF_X(notShadowF[5]),
        .PF_Write_X(_PF_Write_X),
        .notPF_Write_X(_notPF_Write_X),
        .PR_Ex(PR_Ex),
        .notPR_Ex(notPR_Ex),
        .PR_Write(PR_Write_F),
        .notPR_Write(_notPR_Write_F),
        .F_Z(F[5]),
        .notF_Z(notF[5])
    );

    REGISTER_F_H h(
        .Clk(Clk),
        .notClk(notClk),
        .notShadowF_H(notShadowF[4]),
        .notALUResult4(notALUResult[4]),
        .notCY4(notCY4),
        .CY12(CY12),
        .DAA_Flag_H(DAA_Flag_H),
        .notFlag_C(notF[0]),
        .PF_Write_H(PF_Write_H),
        .PF_Select_H_bit17(PF_Select_H_bit17),
        .notPF_Select_H_bit21(notPF_Select_H_bit21),
        .notPF_Select_H_bit22(notPF_Select_H_bit22),
        .notPF_Select_H_bit28(notPF_Select_H_bit28),
        .notPF_Select_H_bit30(notPF_Select_H_bit30),
        .notPF_Select_H_bit31(notPF_Select_H_bit31),
        .notPF_Select_H_bit35(notPF_Select_H_bit35),
        .PR_Ex(PR_Ex),
        .notPR_Ex(notPR_Ex),
        .PR_Write(PR_Write_F),
        .notPR_Write(_notPR_Write_F),
        .F_H(F[4]),
        .notF_H(notF[4])
    );

    REGISTER_F_X y(
        .Clk(Clk),
        .notClk(notClk),
        .notALUResult5(notALUResult[3]),
        .notShadowF_X(notShadowF[3]),
        .PF_Write_X(_PF_Write_X),
        .notPF_Write_X(_notPF_Write_X),
        .PR_Ex(PR_Ex),
        .notPR_Ex(notPR_Ex),
        .PR_Write(PR_Write_F),
        .notPR_Write(_notPR_Write_F),
        .F_Z(F[3]),
        .notF_Z(notF[3])
    );

    REGISTER_F_PV pv(
        .Clk(Clk),
        .notClk(notClk),
        .notShadowF_PV(notShadowF[2]),
        .notALUResult2(notALUResult[2]),
        .IFF2(IFF2),
        .CINT(CINT),
        .is16bitEqual(is16bitEqual),
        .is8bitOverflow(is8bitOverflow),
        .notIs8bitEvenParity(notIs8bitEvenParity),
        .is16bitOverflow(is16bitOverflow),
        .PF_Write_PV(PF_Write_PV),
        .notPF_Select_PV_bit18(notPF_Select_PV_bit18),
        .notPF_Select_PV_bit20(notPF_Select_PV_bit20),
        .notPF_Select_PV_bit25(notPF_Select_PV_bit25),
        .notPF_Select_PV_bit27(notPF_Select_PV_bit27),
        .notPF_Select_PV_bit33(notPF_Select_PV_bit33),
        .PR_Ex(PR_Ex),
        .notPR_Ex(notPR_Ex),
        .PR_Write(PR_Write_F),
        .notPR_Write(_notPR_Write_F),
        .F_PV(F[2]),
        .notF_PV(notF[2])
    );

    REGISTER_F_N n(
        .Clk(Clk),
        .notClk(notClk),
        .notShadowF_N(notShadowF[1]),
        .notALUResult1(notALUResult[1]),
        .PF_Write_N(PF_Write_N),
        .PF_Select_N_bit17(PF_Select_N_bit17),
        .PR_Ex(PR_Ex),
        .notPR_Ex(notPR_Ex),
        .PR_Write(PR_Write_F),
        .notPR_Write(_notPR_Write_F),
        .F_N(F[1]),
        .notF_N(notF[1])
    );

    REGISTER_F_C c(
        .Clk(Clk),
        .notClk(notClk),
        .notShadowF_C(notShadowF[0]),
        .notALUResult0(notALUResult[0]),
        .notCY8(notCY8),
        .CY16(CY16),
        .notFlag_S(notF[7]),
        .notALULow0(notALULow0),
        .notALULow7(notALULow7),
        .PF_Write_C(PF_Write_C),
        .PF_Select_C_bit17(PF_Select_C_bit17),
        .notPF_Select_C_bit23(notPF_Select_C_bit23),
        .notPF_Select_C_bit26(notPF_Select_C_bit26),
        .notPF_Select_C_bit29(notPF_Select_C_bit29),
        .notPF_Select_C_bit32(notPF_Select_C_bit32),
        .notPF_Select_C_bit36(notPF_Select_C_bit36),
        .notPF_Select_C_bit37(notPF_Select_C_bit37),
        .notPF_Select_C_bit38(notPF_Select_C_bit38),
        .PR_Ex(PR_Ex),
        .notPR_Ex(notPR_Ex),
        .PR_Write(PR_Write_F),
        .PF_Select_C_bit0(PF_Select_C_bit0),
        .F_C(F[0]),
        .notF_C(notF[0])
    );

endmodule