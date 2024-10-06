// ADD HL,ss
// 5(13)
module DECODER_op_X1_00xx1001(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [10:0] _decodedXPT,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd,
        output wire PA_ADD,
        output wire PR_Write_H,
        output wire PR_Write_L,
        output wire PF_Write_C,
        output wire PF_Write_N,
        output wire PF_Write_H,
        output wire PF_Select_C_bit32,
        output wire PF_Select_N_bit16,
        output wire PF_Select_H_bit31,
        output wire PA_Select_HL_high, // >
        output wire PA_Select_BC_low,
        output wire PA_Select_DE_low,
        output wire PA_Select_HL_low,
        output wire PA_Select_SP_low
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    assign _decodedXPT[10] = ~(_not_enable | notXPT[3] | notXPT[1]); // 3

    assign PR_Reset_XPT = _decodedXPT[10];
    assign P2_Set_CM1 = _decodedXPT[10];
    assign Pa_Ophd = _decodedXPT[10];
    assign PA_ADD = _decodedXPT[10];
    assign PR_Write_H = _decodedXPT[10];
    assign PR_Write_L = _decodedXPT[10];
    assign PF_Write_C = _decodedXPT[10];
    assign PF_Write_N = _decodedXPT[10];
    assign PF_Write_H = _decodedXPT[10];
    assign PF_Select_C_bit32 = _decodedXPT[10];
    assign PF_Select_N_bit16 = _decodedXPT[10];
    assign PF_Select_H_bit31 = _decodedXPT[10];
    assign PA_Select_HL_high = _decodedXPT[10];

    //
    // decoder
    //

    wire _nott10 = _decodedXPT[10] ~| _decodedXPT[10];

    DECODER_2bit_decoder d_00dd1001( // 8
        .notEnable(_nott10),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(PA_Select_BC_low),
        .out01(PA_Select_DE_low),
        .out10(PA_Select_HL_low),
        .out11(PA_Select_SP_low)
    );

endmodule