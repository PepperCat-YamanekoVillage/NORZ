// INC/DEC IX/IY
// 8(10)
module DECODER_op_XIX_0010x011(
        input wire enable,
        input wire is_Y,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [5:0] _decodedXPT,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd,
        output wire PA_Select_0x1_low, // >
        output wire PA_Select_IX_high, // <
        output wire PR_Write_IX_high,
        output wire PR_Write_IX_low,
        output wire P2_Reset_XIX, // >
        output wire PA_Select_IY_high, // <
        output wire PR_Write_IY_high,
        output wire PR_Write_IY_low,
        output wire P2_Reset_XIY, // >
        output wire PA_ADD,
        output wire PA_SUB
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    assign _decodedXPT[5] = ~(_not_enable | XPT[1] | notXPT[0]); // 3

    assign PR_Reset_XPT = _decodedXPT[5];
    assign P2_Set_CM1 = _decodedXPT[5];
    assign Pa_Ophd = _decodedXPT[5];
    assign PA_Select_0x1_low = _decodedXPT[5];

    wire _nott5 = _decodedXPT[5] ~| _decodedXPT[5];

    wire _not_is_Y = is_Y ~| is_Y;

    assign PA_Select_IX_high = _nott5 ~| is_Y;
    assign PR_Write_IX_high = PA_Select_IX_high;
    assign PR_Write_IX_low = PA_Select_IX_high;
    assign P2_Reset_XIX = PA_Select_IX_high;

    assign PA_Select_IY_high = _nott5 ~| _not_is_Y;
    assign PR_Write_IY_high = PA_Select_IY_high;
    assign PR_Write_IY_low = PA_Select_IY_high;
    assign P2_Reset_XIY = PA_Select_IY_high;

    //
    // decoder
    //

    DECODER_1bit_decoder d_0010d011(
        .notEnable(_nott5),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(PA_ADD),
        .out1(PA_SUB),
    ); 

endmodule