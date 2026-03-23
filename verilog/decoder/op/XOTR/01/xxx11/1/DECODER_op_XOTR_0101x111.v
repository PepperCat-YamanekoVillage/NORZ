// LD A,I/R
// 3(5)
module DECODER_op_XOTR_0101x111(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_XOTR,
        output wire PA_NOP,
        output wire PR_Write_A,
        output wire PR_InvertIn,
        output wire PF_Write_Z,
        output wire PF_Write_PV,
        output wire PF_Write_S,
        output wire PF_Write_N,
        output wire PF_Write_H,
        output wire PF_Select_Z_bit19,
        output wire PF_Select_PV_bit18,
        output wire PF_Select_S_bit7,
        output wire PF_Select_N_bit16,
        output wire PF_Select_H_bit16,
        output wire Pa_Ophd, // >
        output wire PA_Select_I_low,
        output wire PA_Select_R_low
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    wire _decodedXPT4 = _not_enable ~| notXPT[2];

    //
    // decoder
    //

    wire _notdecodedXPT4 = _decodedXPT4 ~| _decodedXPT4;

    wire _I;
    wire _R;

    DECODER_1bit_decoder d_0101d111(
        .notEnable(_notdecodedXPT4),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_I),
        .out1(_R)
    );

    assign PR_Reset_XPT = _decodedXPT4;
    assign P2_Set_CM1 = _decodedXPT4;
    assign P2_Reset_XOTR = _decodedXPT4;
    assign PA_NOP = _decodedXPT4;
    assign PR_Write_A = _decodedXPT4;
    assign PR_InvertIn = _decodedXPT4;
    assign PF_Write_Z = _decodedXPT4;
    assign PF_Select_Z_bit19 = _decodedXPT4;
    assign PF_Write_PV = _decodedXPT4;
    assign PF_Select_PV_bit18 = _decodedXPT4;
    assign PF_Write_S = _decodedXPT4;
    assign PF_Select_S_bit7 = _decodedXPT4;
    assign PF_Write_N = _decodedXPT4;
    assign PF_Select_N_bit16 = _decodedXPT4;
    assign PF_Write_H = _decodedXPT4;
    assign PF_Select_H_bit16 = _decodedXPT4;
    assign Pa_Ophd = _decodedXPT4;

    assign PA_Select_I_low = _I;

    assign PA_Select_R_low = _R;

endmodule