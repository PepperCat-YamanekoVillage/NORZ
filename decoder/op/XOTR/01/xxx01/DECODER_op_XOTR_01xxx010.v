// ADC/SBC HL,ss
// 12(22)
module DECODER_op_XOTR_01xxx010(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [10:0] _decodedXPT,
        output wire PA_Select_HL_high, // <
        output wire PR_Write_H,
        output wire PR_Write_L,
        output wire PF_Write_C,
        output wire PF_Write_Z,
        output wire PF_Write_PV,
        output wire PF_Write_S,
        output wire PF_Write_N,
        output wire PF_Write_H,
        output wire PF_Select_Z_bit34,
        output wire PF_Select_PV_bit33,
        output wire PF_Select_S_bit15, // >
        output wire PA_SBC, // <
        output wire PF_Select_C_bit36,
        output wire PF_Select_N_bit17,
        output wire PF_Select_H_bit35, // >
        output wire PA_ADC, // <
        output wire PF_Select_C_bit32,
        output wire PF_Select_N_bit16,
        output wire PF_Select_H_bit31, // >
        output wire PA_Select_BC_low,
        output wire PA_Select_DE_low,
        output wire PA_Select_HL_low,
        output wire PA_Select_SP_low,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_XOTR,
        output wire Pa_Ophd // >
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    wire _not_enable_or_XPT0 = (_not_enable | XPT[0]); // 2

    assign _decodedXPT[4] = ~(_not_enable_or_XPT0 | notXPT[2] | XPT[1]); // 3
    assign _decodedXPT[10] = ~(_not_enable_or_XPT0 | notXPT[3] | XPT[2] | notXPT[1]); // 5

    // 4

    assign PA_Select_HL_high = _decodedXPT[4];
    assign PR_Write_H = _decodedXPT[4];
    assign PR_Write_L = _decodedXPT[4];
    assign PF_Write_C = _decodedXPT[4];
    assign PF_Write_Z = _decodedXPT[4];
    assign PF_Write_PV = _decodedXPT[4];
    assign PF_Write_S = _decodedXPT[4];
    assign PF_Write_N = _decodedXPT[4];
    assign PF_Write_H = _decodedXPT[4];
    assign PF_Select_Z_bit34 = _decodedXPT[4];
    assign PF_Select_PV_bit33 = _decodedXPT[4];
    assign PF_Select_S_bit15 = _decodedXPT[4];

    //
    // decoder
    //

    wire _notdecodedXPT4 = _decodedXPT[4] ~| _decodedXPT[4];

    wire _01xx0010;
    wire _01xx1010;

    DECODER_1bit_decoder d_01xxd010(
        .notEnable(_notdecodedXPT4),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_01xx0010),
        .out1(_01xx1010),
    );

    assign PA_SBC = _01xx0010;
    assign PF_Select_C_bit36 = _01xx0010;
    assign PF_Select_N_bit17 = _01xx0010;
    assign PF_Select_H_bit35 = _01xx0010;

    assign PA_ADC = _01xx1010;
    assign PF_Select_C_bit32 = _01xx1010;
    assign PF_Select_N_bit16 = _01xx1010;
    assign PF_Select_H_bit31 = _01xx1010;

    DECODER_2bit_decoder d_01ddx010( // 8
        .notEnable(_notdecodedXPT4),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(PA_Select_BC_low),
        .out01(PA_Select_DE_low),
        .out10(PA_Select_HL_low),
        .out11(PA_Select_SP_low)
    );

    // 10

    assign PR_Reset_XPT = _decodedXPT[10];
    assign P2_Set_CM1 = _decodedXPT[10];
    assign P2_Reset_XOTR = _decodedXPT[10];
    assign Pa_Ophd = _decodedXPT[10];

endmodule