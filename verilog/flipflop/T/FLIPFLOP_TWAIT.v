// (9)
module FLIPFLOP_TWAIT(
        input wire Clk,
        input wire notClk,
        input wire WAIT,
        output wire TWAIT
    );

    FLIPFLOP_dff twait(
        .Clk(notClk),
        .notClk(Clk),
        .notD(WAIT),
        .notQ(TWAIT)
    );

endmodule