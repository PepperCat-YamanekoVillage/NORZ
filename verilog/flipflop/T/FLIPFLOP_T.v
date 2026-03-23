// (87)
module FLIPFLOP_T(
        input wire Clk,
        input wire notClk,
        input wire INT,
        input wire NMI,
        input wire RESET,
        input wire WAIT,
        input wire notIFF1,
        input wire P2_Reset_TINT,
        input wire P2_Reset_TNMI,
        input wire P2_Reset_ALLUNOFFICIALFF,
        output wire TINT,
        output wire TNMI,
        output wire TRESET,
        output wire TWAIT
    );

    FLIPFLOP_TINT tint(
        .Clk(Clk),
        .notClk(notClk),
        .INT(INT),
        .notIFF1(notIFF1),
        .P2_Reset_TINT(P2_Reset_TINT),
        .P2_Reset_ALLUNOFFICIALFF(P2_Reset_ALLUNOFFICIALFF),
        .TINT(TINT)
    );

    FLIPFLOP_TNMI tnmi(
        .Clk(Clk),
        .notClk(notClk),
        .NMI(NMI),
        .P2_Reset_TNMI(P2_Reset_TNMI),
        .P2_Reset_ALLUNOFFICIALFF(P2_Reset_ALLUNOFFICIALFF),
        .TNMI(TNMI)
    );

    FLIPFLOP_TRESET treset(
        .Clk(Clk),
        .notClk(notClk),
        .RESET(RESET),
        .P2_Reset_ALLUNOFFICIALFF(P2_Reset_ALLUNOFFICIALFF),
        .TRESET(TRESET)
    );

    FLIPFLOP_TWAIT twait(
        .Clk(Clk),
        .notClk(notClk),
        .WAIT(WAIT),
        .TWAIT(TWAIT)
    );

endmodule