// 18(34)
module DECODER_op_X1_10_alu(
        input wire enable,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd,
        output wire PA_Select_A_high,
        output wire PR_InvertIn,
        output wire PF_Write_S,
        output wire PF_Write_Z,
        output wire PF_Write_H,
        output wire PF_Write_PV,
        output wire PF_Write_N,
        output wire PF_Write_C,
        output wire PF_Select_S_bit7,
        output wire PF_Select_Z_bit24, // >
        output wire PR_Write_A,
        output wire PA_ADD,
        output wire PA_ADC,
        output wire PA_SUB,
        output wire PA_SBC,
        output wire PA_AND,
        output wire PA_XOR,
        output wire PA_OR,
        output wire PF_Select_H_bit21, // <
        output wire PF_Select_C_bit23, // >
        output wire PF_Select_H_bit22, // <
        output wire PF_Select_N_bit17,
        output wire PF_Select_C_bit26, // >
        output wire PF_Select_PV_bit25,
        output wire PF_Select_H_bit17,
        output wire PF_Select_H_bit16,
        output wire PF_Select_PV_bit27, // <
        output wire PF_Select_C_bit16, // >
        output wire PF_Select_N_bit16
    );

    // wire [7:0] notSource = ~Source;

    assign PR_Reset_XPT = enable;
    assign P2_Set_CM1 = enable;
    assign Pa_Ophd = enable;
    assign PA_Select_A_high = enable;
    assign PR_InvertIn = enable;
    assign PF_Write_S = enable;
    assign PF_Write_Z = enable;
    assign PF_Write_H = enable;
    assign PF_Write_PV = enable;
    assign PF_Write_N = enable;
    assign PF_Write_C = enable;
    assign PF_Select_S_bit7 = enable;
    assign PF_Select_Z_bit24 = enable;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _1000xxxx;
    wire _1001xxxx;
    wire _1010xxxx;
    wire _1011xxxx;

    DECODER_2bit_decoder d_10ddxxxx( // 8
        .notEnable(_not_enable),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(_1000xxxx),
        .out01(_1001xxxx),
        .out10(_1010xxxx),
        .out11(_1011xxxx)
    );

    wire _not1000xxxx = _1000xxxx ~| _1000xxxx;
    wire _not1001xxxx = _1001xxxx ~| _1001xxxx;
    wire _not1010xxxx = _1010xxxx ~| _1010xxxx;
    wire _not1011xxxx = _1011xxxx ~| _1011xxxx;

    wire _ADD;
    wire _ADC;
    wire _SUB;
    wire _SBC;
    wire _AND;
    wire _XOR;
    wire _OR;
    wire _CP;

    DECODER_1bit_decoder d_1000dxxx(
        .notEnable(_not1000xxxx),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_ADD),
        .out1(_ADC)
    );

    DECODER_1bit_decoder d_1001dxxx(
        .notEnable(_not1001xxxx),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_SUB),
        .out1(_SBC)
    );

    DECODER_1bit_decoder d_1010dxxx(
        .notEnable(_not1010xxxx),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_AND),
        .out1(_XOR)
    );

    DECODER_1bit_decoder d_1011dxxx(
        .notEnable(_not1011xxxx),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_OR),
        .out1(_CP)
    );

    assign PR_Write_A = _not_enable ~| _CP;

    assign PA_ADD = _ADD;
    assign PA_ADC = _ADC;
    assign PA_SUB = (_SUB | _CP); // 2
    assign PA_SBC = _SBC;
    assign PA_AND = _AND;
    assign PA_XOR = _XOR;
    assign PA_OR = _OR;

    assign PF_Select_H_bit21 = _1000xxxx;
    assign PF_Select_C_bit23 = _1000xxxx;

    assign PF_Select_H_bit22 = (PA_SUB | _SBC); // 2
    assign PF_Select_N_bit17 = PF_Select_H_bit22;
    assign PF_Select_C_bit26 = PF_Select_H_bit22;

    assign PF_Select_PV_bit25 = (PF_Select_H_bit22 | _1000xxxx); // 2

    assign PF_Select_H_bit17 = _AND;

    assign PF_Select_H_bit16 = (_XOR | _OR); // 2

    assign PF_Select_PV_bit27 = (PF_Select_H_bit16 | _AND); // 2
    assign PF_Select_C_bit16 = PF_Select_PV_bit27;

    assign PF_Select_N_bit16 = (PF_Select_PV_bit27 | _1000xxxx); // 2

endmodule