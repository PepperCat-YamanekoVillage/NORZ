// LD IX/IY,nn
// 1(3)
module DECODER_I_00001x11(
        input wire enable,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire PR_Write_IX_high,
        output wire PR_Write_IY_high,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_ITABLE,
        output wire PR_InvertIn,
        output wire Pa_Ophd // >
    );

    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    DECODER_1bit_decoder d_00001d11(
        .notEnable(_not_enable),
        .In(ITABLE[2]),
        .notIn(notITABLE[2]),
        .out0(PR_Write_IX_high),
        .out1(PR_Write_IY_high),
    );

    assign PR_Reset_XPT = enable;
    assign P2_Set_CM1 = enable;
    assign P2_Reset_ITABLE = enable;
    assign PR_InvertIn = enable;
    assign Pa_Ophd = enable;

endmodule