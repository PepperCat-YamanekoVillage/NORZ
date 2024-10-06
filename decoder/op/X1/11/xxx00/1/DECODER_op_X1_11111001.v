// LD SP,HL
// 4
module DECODER_op_X1_11111001(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        output wire [5:0] _decodedXPT,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd,
        output wire PA_NOP,
        output wire PA_Select_HL_low,
        output wire PR_Write_SP // >
    );

    // wire [4:0] notXPT = ~XPT;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    assign _decodedXPT[5] = ~(_not_enable | XPT[1] | notXPT[0]); // 3

    assign PR_Reset_XPT = _decodedXPT[5];
    assign P2_Set_CM1 = _decodedXPT[5];
    assign Pa_Ophd = _decodedXPT[5];
    assign PA_NOP = _decodedXPT[5];
    assign PA_Select_HL_low = _decodedXPT[5];
    assign PR_Write_SP = _decodedXPT[5];

endmodule