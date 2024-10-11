// JP nn
// 1(3)
module DECODER_I_0000011(
        input wire enable,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire PR_Reset_XPT,
        output wire P2_Set_CMA,
        output wire P2_Set_IJPnn_1,
        output wire P2_Set_CM1, // <
        output wire P2_Reset_ITABLE,
        output wire PA_Select_OP_high,
        output wire PA_NOP,
        output wire PR_Write_PC_high,
        output wire PR_Write_PC_low,
        output wire PR_InvertIn,
        output wire Pa_Ophd // >
    );

    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _0;
    wire _1;

    DECODER_1bit_decoder d_0000011d(
        .notEnable(_not_enable),
        .In(ITABLE[0]),
        .notIn(notITABLE[0]),
        .out0(_0),
        .out1(_1)
    );

    assign PR_Reset_XPT = enable;

    assign P2_Set_CMA = _0;
    assign P2_Set_IJPnn_1 = _0;

    assign P2_Set_CM1 = _1;
    assign P2_Reset_ITABLE = _1;
    assign PA_Select_OP_high = _1;
    assign PA_NOP = _1;
    assign PR_Write_PC_high = _1;
    assign PR_Write_PC_low = _1;
    assign PR_InvertIn = _1;
    assign Pa_Ophd = _1;

endmodule
