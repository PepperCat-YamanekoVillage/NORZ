// 12(155)
module FLIPFLOP_C(
        input wire Clk,
        input wire notClk,
        input wire P2_Set_CM1,
        input wire P2_Set_CMR,
        input wire P2_Set_CMA,
        input wire P2_Set_CBUSRQ,
        input wire P2_Set_CRESET,
        input wire P2_Set_CNMI,
        input wire P2_Set_CINT0,
        input wire P2_Set_CINT0_RST,
        input wire P2_Set_CINT0_CALL,
        input wire P2_Set_CINT1,
        input wire P2_Set_CINT2,
        input wire P2_Reset_CM1,
        input wire P2_Reset_CMR,
        input wire P2_Reset_CMA,
        input wire P2_Reset_CBUSRQ,
        input wire P2_Reset_CRESET,
        input wire P2_Reset_CNMI,
        input wire P2_Reset_CINT,
        input wire P2_Reset_ALLUNOFFICIALFF,
        output wire CM1,
        output wire CMR,
        output wire CMA,
        output wire CBUSRQ,
        output wire CRESET,
        output wire CNMI,
        output wire CINT0,
        output wire CINT0_RST,
        output wire CINT0_CALL,
        output wire CINT1,
        output wire CINT2,
        output wire notCM1,
        output wire notCMR,
        output wire notCMA,
        output wire notCBUSRQ,
        output wire notCRESET,
        output wire notCNMI,
        output wire notCINT0,
        output wire notCINT0_RST,
        output wire notCINT0_CALL,
        output wire notCINT1,
        output wire notCINT2
    );

    wire _not_P2_Reset_CM1 = P2_Reset_CM1 ~| P2_Reset_ALLUNOFFICIALFF;
    wire _P2_Reset_CM1 = _not_P2_Reset_CM1 ~| _not_P2_Reset_CM1;
    wire _not_P2_Reset_CMR = P2_Reset_CMR ~| P2_Reset_ALLUNOFFICIALFF;
    wire _P2_Reset_CMR = _not_P2_Reset_CMR ~| _not_P2_Reset_CMR;
    wire _not_P2_Reset_CMA = P2_Reset_CMA ~| P2_Reset_ALLUNOFFICIALFF;
    wire _P2_Reset_CMA = _not_P2_Reset_CMA ~| _not_P2_Reset_CMA;
    wire _not_P2_Reset_CBUSRQ = P2_Reset_CBUSRQ ~| P2_Reset_ALLUNOFFICIALFF;
    wire _P2_Reset_CBUSRQ = _not_P2_Reset_CBUSRQ ~| _not_P2_Reset_CBUSRQ;
    wire _not_P2_Reset_CNMI = P2_Reset_CNMI ~| P2_Reset_ALLUNOFFICIALFF;
    wire _P2_Reset_CNMI = _not_P2_Reset_CNMI ~| _not_P2_Reset_CNMI;
    wire _not_P2_Reset_CINT = P2_Reset_CINT ~| P2_Reset_ALLUNOFFICIALFF;
    wire _P2_Reset_CINT = _not_P2_Reset_CINT ~| _not_P2_Reset_CINT;

    FLIPFLOP_dff_LCX cm1(
        .Clk(Clk),
        .notClk(notClk),
        .P2_Set(P2_Set_CM1),
        .P2_Reset(_P2_Reset_CM1),
        .LCX(CM1),
        .notLCX(notCM1)
    );

    FLIPFLOP_dff_LCX cmr(
        .Clk(Clk),
        .notClk(notClk),
        .P2_Set(P2_Set_CMR),
        .P2_Reset(_P2_Reset_CMR),
        .LCX(CMR),
        .notLCX(notCMR)
    );

    FLIPFLOP_dff_LCX cma(
        .Clk(Clk),
        .notClk(notClk),
        .P2_Set(P2_Set_CMA),
        .P2_Reset(_P2_Reset_CMA),
        .LCX(CMA),
        .notLCX(notCMA)
    );

    FLIPFLOP_dff_LCX cbusrq(
        .Clk(Clk),
        .notClk(notClk),
        .P2_Set(P2_Set_CBUSRQ),
        .P2_Reset(_P2_Reset_CBUSRQ),
        .LCX(CBUSRQ),
        .notLCX(notCBUSRQ)
    );

    FLIPFLOP_dff_LCX creset(
        .Clk(Clk),
        .notClk(notClk),
        .P2_Set(P2_Set_CRESET),
        .P2_Reset(P2_Reset_CRESET),
        .LCX(CRESET),
        .notLCX(notCRESET)
    );

    FLIPFLOP_dff_LCX cnmi(
        .Clk(Clk),
        .notClk(notClk),
        .P2_Set(P2_Set_CNMI),
        .P2_Reset(_P2_Reset_CNMI),
        .LCX(CNMI),
        .notLCX(notCNMI)
    );

    FLIPFLOP_dff_LCX cint0(
        .Clk(Clk),
        .notClk(notClk),
        .P2_Set(P2_Set_CINT0),
        .P2_Reset(_P2_Reset_CINT),
        .LCX(CINT0),
        .notLCX(notCINT0)
    );

    FLIPFLOP_dff_LCX cint0_RST(
        .Clk(Clk),
        .notClk(notClk),
        .P2_Set(P2_Set_CINT0_RST),
        .P2_Reset(_P2_Reset_CINT),
        .LCX(CINT0_RST),
        .notLCX(notCINT0_RST)
    );

    FLIPFLOP_dff_LCX cint0_CALL(
        .Clk(Clk),
        .notClk(notClk),
        .P2_Set(P2_Set_CINT0_CALL),
        .P2_Reset(_P2_Reset_CINT),
        .LCX(CINT0_CALL),
        .notLCX(notCINT0_CALL)
    );

    FLIPFLOP_dff_LCX cint1(
        .Clk(Clk),
        .notClk(notClk),
        .P2_Set(P2_Set_CINT1),
        .P2_Reset(_P2_Reset_CINT),
        .LCX(CINT1),
        .notLCX(notCINT1)
    );

    FLIPFLOP_dff_LCX cint2(
        .Clk(Clk),
        .notClk(notClk),
        .P2_Set(P2_Set_CINT2),
        .P2_Reset(_P2_Reset_CINT),
        .LCX(CINT2),
        .notLCX(notCINT2)
    );

endmodule