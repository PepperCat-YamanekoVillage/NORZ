// 2(15)
module FLIPFLOP_L(
        input wire Clk,
        input wire notClk,
        input wire P2_Set_LHALT,
        input wire P2_Reset_LHALT,
        input wire P2_Reset_ALLUNOFFICIALFF,
        output wire notLHALT
    );

    wire _not_P2_Reset = P2_Reset_LHALT ~| P2_Reset_ALLUNOFFICIALFF;
    wire _P2_Reset = _not_P2_Reset ~| _not_P2_Reset;

    FLIPFLOP_dff_LCX lhalt(
        .Clk(Clk),
        .notClk(notClk),
        .P2_Set(P2_Set_LHALT),
        .P2_Reset(_P2_Reset),
        .notLCX(notLHALT)
    );

endmodule