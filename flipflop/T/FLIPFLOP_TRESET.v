// 8(35)
module FLIPFLOP_TRESET(
        input wire Clk,
        input wire notClk,
        input wire RESET,
        input wire P2_Reset_TRSET,
        input wire P2_Reset_ALLUNOFFICIALFF,
        output wire TRESET
    );

    wire _TRESET0;
    wire _notTRESET0;
    wire _TRESET1;
    wire _notTRESET1;
    wire _notTRESET2;
    wire _notRESET = RESET ~| RESET;

    FLIPFLOP_dff treset0(
        .Clk(Clk),
        .notClk(notClk),
        .notD(RESET),
        .Q(_notTRESET0),
        .notQ(_TRESET0)
    );

    wire _new_TRESET1 = _TRESET0 ~| RESET;

    FLIPFLOP_dff treset1(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_TRESET1),
        .Q(_TRESET1),
        .notQ(_notTRESET1)
    );

    wire _not_Reset_TRESET = P2_Reset_TRSET ~| P2_Reset_ALLUNOFFICIALFF;
    wire _Reset_TRESET = _not_Reset_TRESET ~| _not_Reset_TRESET;

    wire _new_TRESET2_in = _TRESET1 ~| RESET;
    wire _new_not_TRESET2_in = _TRESET1 ~| RESET;
    wire _new_TRESET2_inold = _new_not_TRESET2_in ~| _notTRESET2;

    wire _new_not_TRESET2 = _new_TRESET2_inold ~| _Reset_TRESET;

    FLIPFLOP_dff treset2(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_not_TRESET2),
        .Q(TRESET),
        .notQ(_notTRESET2)
    );

endmodule