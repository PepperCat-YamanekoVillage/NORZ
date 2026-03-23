// EXX / JP (HL)
// 3(5)
module DECODER_op_X1_11ee1001(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [3:0] _decodedXPT,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd, // >
        output wire PR_Exx,
        output wire PA_NOP, // <
        output wire PA_Select_HL_low,
        output wire PR_Write_PC_high,
        output wire PR_Write_PC_low // >
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    assign _decodedXPT[3] = _not_enable ~| notXPT[0];

    assign PR_Reset_XPT = _decodedXPT[3];
    assign P2_Set_CM1 = _decodedXPT[3];
    assign Pa_Ophd = _decodedXPT[3];

    //
    // decoder
    //

    wire _nott3 = _decodedXPT[3] ~| _decodedXPT[3];

    wire _EXX;
    wire _JP;

    DECODER_1bit_decoder d_11xe1001(
        .notEnable(_nott3),
        .In(Source[4]),
        .notIn(notSource[4]),
        .out0(_JP),
        .out1(_EXX)
    );

    assign PR_Exx = _EXX;

    assign PA_NOP = _JP;
    assign PA_Select_HL_low = PA_NOP;
    assign PR_Write_PC_high = PA_NOP;
    assign PR_Write_PC_low = PA_NOP;

endmodule