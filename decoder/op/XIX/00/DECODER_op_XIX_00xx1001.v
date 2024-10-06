// ADD IX,pp / ADD IY,rr
// 15(23)
module DECODER_op_XIX_00xx1001(
        input wire enable,
        input wire is_Y,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [10:0] _decodedXPT,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd,
        output wire PA_ADD,
        output wire PF_Write_C,
        output wire PF_Write_N,
        output wire PF_Write_H,
        output wire PF_Select_C_bit32,
        output wire PF_Select_N_bit16,
        output wire PF_Select_H_bit31, // >
        output wire PA_Select_IX_high, // <
        output wire PR_Write_IX_high,
        output wire PR_Write_IX_low,
        output wire P2_Reset_XIX, // >
        output wire PA_Select_IY_high, // <
        output wire PR_Write_IY_high,
        output wire PR_Write_IY_low,
        output wire P2_Reset_XIY, // >
        output wire PA_Select_BC_low,
        output wire PA_Select_DE_low,
        output wire PA_Select_SP_low,
        output wire PA_Select_IX_low,
        output wire PA_Select_IY_low
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    assign _decodedXPT[10] = ~(_not_enable | notXPT[3] | XPT[2] | notXPT[1] | XPT[0]); // 7

    assign PR_Reset_XPT = _decodedXPT[10];
    assign P2_Set_CM1 = _decodedXPT[10];
    assign Pa_Ophd = _decodedXPT[10];
    assign PA_ADD = _decodedXPT[10];
    assign PF_Write_C = _decodedXPT[10];
    assign PF_Write_N = _decodedXPT[10];
    assign PF_Write_H = _decodedXPT[10];
    assign PF_Select_C_bit32 = _decodedXPT[10];
    assign PF_Select_N_bit16 = _decodedXPT[10];
    assign PF_Select_H_bit31 = _decodedXPT[10];

    wire _nott10 = _decodedXPT[10] ~| _decodedXPT[10];

    wire _not_is_Y = is_Y ~| is_Y;

    assign PA_Select_IX_high = _nott10 ~| is_Y;
    assign PR_Write_IX_high = PA_Select_IX_high;
    assign PR_Write_IX_low = PA_Select_IX_high;
    assign P2_Reset_XIX = PA_Select_IX_high;

    assign PA_Select_IY_high = _nott10 ~| _not_is_Y;
    assign PR_Write_IY_high = PA_Select_IY_high;
    assign PR_Write_IY_low = PA_Select_IY_high;
    assign P2_Reset_XIY = PA_Select_IY_high;

    //
    // decoder
    //

    wire _PA_Select_IXorIY_low;

    DECODER_2bit_decoder d_00dd1001( // 8
        .notEnable(_nott10),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(PA_Select_BC_low),
        .out01(PA_Select_DE_low),
        .out10(_PA_Select_IXorIY_low),
        .out11(PA_Select_SP_low)
    );

    wire _notPA_Select_IXorIY_low = _PA_Select_IXorIY_low ~| _PA_Select_IXorIY_low;

    assign PA_Select_IX_low = _notPA_Select_IXorIY_low ~| is_Y;
    assign PA_Select_IY_low = _notPA_Select_IXorIY_low ~| _not_is_Y;

endmodule