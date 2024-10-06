// FLIPFLOP_Cと大体同じ(Lの複数版)
// 12(116)
module FLIPFLOP_X(
        input wire Clk,
        input wire notClk,
        input wire P2_Set_XIX,
        input wire P2_Set_XIX4_0,
        input wire P2_Set_XIX4_1,
        input wire P2_Set_XIY,
        input wire P2_Set_XIY4_0,
        input wire P2_Set_XIY4_1,
        input wire P2_Set_XOTR,
        input wire P2_Set_XBIT,
        input wire P2_Reset_XIX,
        input wire P2_Reset_XIX4,
        input wire P2_Reset_XIY,
        input wire P2_Reset_XIY4,
        input wire P2_Reset_XOTR,
        input wire P2_Reset_XBIT,
        input wire P2_Reset_ALLUNOFFICIALFF,
        output wire XIX,
        output wire XIX4_0,
        output wire XIX4_1,
        output wire XIY,
        output wire XIY4_0,
        output wire XIY4_1,
        output wire XOTR,
        output wire XBIT,
        output wire notXIX,
        output wire notXIX4_0,
        output wire notXIX4_1,
        output wire notXIY,
        output wire notXIY4_0,
        output wire notXIY4_1,
        output wire notXOTR,
        output wire notXBIT
    );

    wire _not_P2_Reset_XIX = P2_Reset_XIX ~| P2_Reset_ALLUNOFFICIALFF;
    wire _P2_Reset_XIX = _not_P2_Reset_XIX ~| _not_P2_Reset_XIX;
    wire _not_P2_Reset_XIX4 = P2_Reset_XIX4 ~| P2_Reset_ALLUNOFFICIALFF;
    wire _P2_Reset_XIX4 = _not_P2_Reset_XIX4 ~| _not_P2_Reset_XIX4;
    wire _not_P2_Reset_XIY = P2_Reset_XIY ~| P2_Reset_ALLUNOFFICIALFF;
    wire _P2_Reset_XIY = _not_P2_Reset_XIY ~| _not_P2_Reset_XIY;
    wire _not_P2_Reset_XIY4 = P2_Reset_XIY4 ~| P2_Reset_ALLUNOFFICIALFF;
    wire _P2_Reset_XIY4 = _not_P2_Reset_XIY4 ~| _not_P2_Reset_XIY4;
    wire _not_P2_Reset_XOTR = P2_Reset_XOTR ~| P2_Reset_ALLUNOFFICIALFF;
    wire _P2_Reset_XOTR = _not_P2_Reset_XOTR ~| _not_P2_Reset_XOTR;
    wire _not_P2_Reset_XBIT = P2_Reset_XBIT ~| P2_Reset_ALLUNOFFICIALFF;
    wire _P2_Reset_XBIT = _not_P2_Reset_XBIT ~| _not_P2_Reset_XBIT;

    FLIPFLOP_dff_LCX xix(
        .Clk(Clk),
        .notClk(notClk),
        .P2_Set(P2_Set_XIX),
        .P2_Reset(_P2_Reset_XIX),
        .LCX(XIX),
        .notLCX(notXIX)
    );

    FLIPFLOP_dff_LCX xix4_0(
        .Clk(Clk),
        .notClk(notClk),
        .P2_Set(P2_Set_XIX4_0),
        .P2_Reset(_P2_Reset_XIX4),
        .LCX(XIX4_0),
        .notLCX(notXIX4_0)
    );

    FLIPFLOP_dff_LCX xix4_1(
        .Clk(Clk),
        .notClk(notClk),
        .P2_Set(P2_Set_XIX4_1),
        .P2_Reset(_P2_Reset_XIX4),
        .LCX(XIX4_1),
        .notLCX(notXIX4_1)
    );

    FLIPFLOP_dff_LCX xiy(
        .Clk(Clk),
        .notClk(notClk),
        .P2_Set(P2_Set_XIY),
        .P2_Reset(_P2_Reset_XIY),
        .LCX(XIY),
        .notLCX(notXIY)
    );

    FLIPFLOP_dff_LCX xiy4_0(
        .Clk(Clk),
        .notClk(notClk),
        .P2_Set(P2_Set_XIY4_0),
        .P2_Reset(_P2_Reset_XIY4),
        .LCX(XIY4_0),
        .notLCX(notXIY4_0)
    );

    FLIPFLOP_dff_LCX xiy4_1(
        .Clk(Clk),
        .notClk(notClk),
        .P2_Set(P2_Set_XIY4_1),
        .P2_Reset(_P2_Reset_XIY4),
        .LCX(XIY4_1),
        .notLCX(notXIY4_1)
    );

    FLIPFLOP_dff_LCX xotr(
        .Clk(Clk),
        .notClk(notClk),
        .P2_Set(P2_Set_XOTR),
        .P2_Reset(_P2_Reset_XOTR),
        .LCX(XOTR),
        .notLCX(notXOTR)
    );

    FLIPFLOP_dff_LCX xbit(
        .Clk(Clk),
        .notClk(notClk),
        .P2_Set(P2_Set_XBIT),
        .P2_Reset(_P2_Reset_XBIT),
        .LCX(XBIT),
        .notLCX(notXBIT)
    );

endmodule