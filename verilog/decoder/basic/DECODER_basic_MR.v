// 7(12)
module DECODER_basic_MR(
        input wire [1:0] XPT,
        input wire [1:0] notXPT,
        input wire PC_MR,
        input wire PC_MR0,
        input wire PC_MR1,
        input wire PC_MR2,
        output wire [2:0] _decodedXPT,
        output wire PC_MA0,
        output wire PC_MA1,
        output wire PC_MA2,
        output wire PR_SlideOP, // < 3
        output wire PA_NOP,
        output wire PR_Write_OP,
        output wire P2_Reset_CMR, // >
        output wire PR_Inc_PC
    );

    // wire [1:0] notXPT = ~XPT;

    wire _notPC_MR = PC_MR ~| PC_MR;

    DECODER_2bit_decoder d_dd( // 5
        .notEnable(_notPC_MR),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[0]),
        .out01(_decodedXPT[1]),
        .out1x(_decodedXPT[2])
    );

    // 0

    wire _notPC_MA0 = _decodedXPT[0] ~| PC_MR0;
    assign PC_MA0 = _notPC_MA0 ~| _notPC_MA0;

    // 1

    wire _notPC_MA1 = _decodedXPT[1] ~| PC_MR1;
    assign PC_MA1 = _notPC_MA1 ~| _notPC_MA1;

    // 2

    wire _notPC_MA2 = _decodedXPT[2] ~| PC_MR2;
    assign PC_MA2 = _notPC_MA2 ~| _notPC_MA2;
    assign PR_SlideOP = PC_MA2;
    assign PA_NOP = PC_MA2;
    assign PR_Write_OP = PC_MA2;
    assign P2_Reset_CMR = PC_MA2;

    assign PR_Inc_PC = _decodedXPT[2];

endmodule