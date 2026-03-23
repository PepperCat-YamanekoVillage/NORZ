// 10(69)
module DECODER_op_bit(
        input wire enable,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire PF_Write_Z, // <
        output wire PF_Write_N,
        output wire PF_Write_H,
        output wire PF_Select_N_bit16, // >
        output wire PF_Write_C, // <
        output wire PF_Write_PV,
        output wire PF_Write_S,
        output wire PF_Select_Z_bit24,
        output wire PF_Select_S_bit7,
        output wire PF_Select_PV_bit27,
        output wire PF_Select_H_bit16, // >
        output wire PF_Select_C_bit38,
        output wire PF_Select_C_bit37,
        output wire PF_Select_H_bit17,
        output wire PA_RLC,
        output wire PA_RL,
        output wire PA_SLA,
        output wire PA_RRC,
        output wire PA_RR,
        output wire PA_SRA,
        output wire PA_SRL,
        output wire PA_NOP,
        output wire PA_OR,
        output wire PA_NLAND,
        output wire PF_Select_Z_bit40,
        output wire PF_Select_Z_bit41,
        output wire PF_Select_Z_bit42,
        output wire PF_Select_Z_bit43,
        output wire PF_Select_Z_bit44,
        output wire PF_Select_Z_bit45,
        output wire PF_Select_Z_bit46,
        output wire PF_Select_Z_bit47,
        output wire PA_Select_0x1_low,
        output wire PA_Select_0x2_low,
        output wire PA_Select_0x4_low,
        output wire PA_Select_0x8_low,
        output wire PA_Select_0x10_low,
        output wire PA_Select_0x20_low,
        output wire PA_Select_0x40_low,
        output wire PA_Select_0x80_low
    );

    // wire [7:0] notSource = ~Source;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _RRRBIT;
    wire _RESSET;

    wire _RRR;
    wire _BIT;
    wire _RES;
    wire _SET;

    DECODER_2bit_decoder d_ddxxxxxx( // 8
        .notEnable(_not_enable),
        .In(Source[7:6]),
        .notIn(notSource[7:6]),
        .out00(_RRR),
        .out01(_BIT),
        .out10(_RES),
        .out11(_SET),
        .out0x(_RRRBIT),
        .out1x(_RESSET)
    );

    assign PF_Write_Z = _RRRBIT;
    assign PF_Write_N = _RRRBIT;
    assign PF_Write_H = _RRRBIT;
    assign PF_Select_N_bit16 = _RRRBIT;

    //
    // 循環系命令
    //

    assign PF_Write_C = _RRR;
    assign PF_Write_PV = _RRR;
    assign PF_Write_S = _RRR;
    assign PF_Select_Z_bit24 = _RRR;
    assign PF_Select_S_bit7 = _RRR;
    assign PF_Select_PV_bit27 = _RRR;
    assign PF_Select_H_bit16 = _RRR;

    wire _notRRR = _RRR ~| _RRR;

    wire _Left;
    wire _Right;

    DECODER_1bit_decoder d_00xxdxxx(
        .notEnable(_notRRR),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_Left),
        .out1(_Right)
    );

    assign PF_Select_C_bit38 = _Left;
    assign PF_Select_C_bit37 = _Right;

    wire _notLeft = _Left ~| _Left;
    wire _notRight = _Right ~| _Right;

    DECODER_2bit_decoder d_00dd0xxx( // 5
        .notEnable(_notLeft),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(PA_RLC),
        .out01(PA_RL),
        .out1x(PA_SLA)
    );

    DECODER_2bit_decoder d_00dd1xxx( // 8
        .notEnable(_notRight),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(PA_RRC),
        .out01(PA_RR),
        .out10(PA_SRA),
        .out11(PA_SRL)
    );

    //
    // _BIT
    //

    assign PA_NOP = _BIT;
    assign PA_OR = _SET;
    assign PA_NLAND = _RES;

    assign PF_Select_H_bit17 = _BIT;

    wire _notBIT = _BIT ~| _BIT;

    wire _bitL;
    wire _bitH;

    DECODER_1bit_decoder d_01dxxxxx(
        .notEnable(_notBIT),
        .In(Source[5]),
        .notIn(notSource[5]),
        .out0(_bitL),
        .out1(_bitH)
    );

    wire _notbitL = _bitL ~| _bitL;
    wire _notbitH = _bitH ~| _bitH;

    DECODER_2bit_decoder d_010ddxxx( // 8
        .notEnable(_notbitL),
        .In(Source[4:3]),
        .notIn(notSource[4:3]),
        .out00(PF_Select_Z_bit40),
        .out01(PF_Select_Z_bit41),
        .out10(PF_Select_Z_bit42),
        .out11(PF_Select_Z_bit43)
    );

    DECODER_2bit_decoder d_011ddxxx( // 8
        .notEnable(_notbitH),
        .In(Source[4:3]),
        .notIn(notSource[4:3]),
        .out00(PF_Select_Z_bit44),
        .out01(PF_Select_Z_bit45),
        .out10(PF_Select_Z_bit46),
        .out11(PF_Select_Z_bit47)
    );

    wire _notRESSET = _RESSET ~| _RESSET;

    wire _rstL;
    wire _rstH;

    DECODER_1bit_decoder d_1xdxxxxx(
        .notEnable(_notRESSET),
        .In(Source[5]),
        .notIn(notSource[5]),
        .out0(_rstL),
        .out1(_rstH)
    );

    wire _notrstL = _rstL ~| _rstL;
    wire _notrstH = _rstH ~| _rstH;

    DECODER_2bit_decoder d_1x0ddxxx( // 8
        .notEnable(_notrstL),
        .In(Source[4:3]),
        .notIn(notSource[4:3]),
        .out00(PA_Select_0x1_low),
        .out01(PA_Select_0x2_low),
        .out10(PA_Select_0x4_low),
        .out11(PA_Select_0x8_low)
    );

    DECODER_2bit_decoder d_1x1ddxxx( // 8
        .notEnable(_notrstH),
        .In(Source[4:3]),
        .notIn(notSource[4:3]),
        .out00(PA_Select_0x10_low),
        .out01(PA_Select_0x20_low),
        .out10(PA_Select_0x40_low),
        .out11(PA_Select_0x80_low)
    );

endmodule