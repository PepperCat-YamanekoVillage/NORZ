// INC/DEC ss
// 5(15)
module DECODER_op_X1_00xxx011(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [5:0] _decodedXPT,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd,
        output wire PA_Select_0x1_low, // >
        output wire PA_ADD,
        output wire PA_SUB,
        output wire PA_Select_BC_high, // <
        output wire PR_Write_B,
        output wire PR_Write_C, // >
        output wire PA_Select_DE_high, // <
        output wire PR_Write_D,
        output wire PR_Write_E, // >
        output wire PA_Select_HL_high, // <
        output wire PR_Write_H,
        output wire PR_Write_L, // >
        output wire PA_Select_SP_high, // <
        output wire PR_Write_SP_high,
        output wire PR_Write_SP_low // >
    );

    wire [4:0] notXPT = ~XPT;
    wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    assign _decodedXPT[5] = ~(_not_enable | XPT[1] | notXPT[0]); // 3

    assign PR_Reset_XPT = _decodedXPT[5];
    assign P2_Set_CM1 = _decodedXPT[5];
    assign Pa_Ophd = _decodedXPT[5];
    assign PA_Select_0x1_low = _decodedXPT[5];

    //
    // decoder
    // 

    wire _nott5 = _decodedXPT[5] ~| _decodedXPT[5];

    DECODER_1bit_decoder d_00xxd011(
        .notEnable(_nott5),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(PA_ADD),
        .out1(PA_SUB)
    );

    wire _BC;
    wire _DE;
    wire _HL;
    wire _SP;

    DECODER_2bit_decoder d_00ddx011( // 8
        .notEnable(_nott5),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(_BC),
        .out01(_DE),
        .out10(_HL),
        .out11(_SP)
    );

    assign PA_Select_BC_high = _BC;
    assign PR_Write_B = _BC;
    assign PR_Write_C = _BC;

    assign PA_Select_DE_high = _DE;
    assign PR_Write_D = _DE;
    assign PR_Write_E = _DE;

    assign PA_Select_HL_high = _HL;
    assign PR_Write_H = _HL;
    assign PR_Write_L = _HL;

    assign PA_Select_SP_high = _SP;
    assign PR_Write_SP_high = _SP;
    assign PR_Write_SP_low = _SP;

endmodule