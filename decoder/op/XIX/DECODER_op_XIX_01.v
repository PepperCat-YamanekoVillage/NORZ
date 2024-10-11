// LD r,(IX/IY+d) / LD (IX/IY+d),r
// 18(84)
module DECODER_op_XIX_01(
        input wire enable,
        input wire is_Y,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [3:0] _decodedXPT,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CMR, // >
        output wire P2_Reset_XIX,
        output wire P2_Reset_XIY,
        output wire P2_Set_ILDrlIXtdl_B,
        output wire P2_Set_ILDrlIXtdl_C,
        output wire P2_Set_ILDrlIXtdl_D,
        output wire P2_Set_ILDrlIXtdl_E,
        output wire P2_Set_ILDrlIXtdl_H,
        output wire P2_Set_ILDrlIXtdl_L,
        output wire P2_Set_ILDrlIXtdl_A,
        output wire P2_Set_ILDlIXtdlr_B,
        output wire P2_Set_ILDlIXtdlr_C,
        output wire P2_Set_ILDlIXtdlr_D,
        output wire P2_Set_ILDlIXtdlr_E,
        output wire P2_Set_ILDlIXtdlr_H,
        output wire P2_Set_ILDlIXtdlr_L,
        output wire P2_Set_ILDlIXtdlr_A,
        output wire P2_Set_ILDrlIYtdl_B,
        output wire P2_Set_ILDrlIYtdl_C,
        output wire P2_Set_ILDrlIYtdl_D,
        output wire P2_Set_ILDrlIYtdl_E,
        output wire P2_Set_ILDrlIYtdl_H,
        output wire P2_Set_ILDrlIYtdl_L,
        output wire P2_Set_ILDrlIYtdl_A,
        output wire P2_Set_ILDlIYtdlr_B,
        output wire P2_Set_ILDlIYtdlr_C,
        output wire P2_Set_ILDlIYtdlr_D,
        output wire P2_Set_ILDlIYtdlr_E,
        output wire P2_Set_ILDlIYtdlr_H,
        output wire P2_Set_ILDlIYtdlr_L,
        output wire P2_Set_ILDlIYtdlr_A
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    assign _decodedXPT[3] = _not_enable ~| notXPT[0];

    assign PR_Reset_XPT = _decodedXPT[3];
    assign P2_Set_CMR = _decodedXPT[3];

    //
    // decoder
    //

    wire _nott3 = _decodedXPT[3] ~| _decodedXPT[3];

    wire _not_is_Y = is_Y ~| is_Y;

    assign P2_Reset_XIX = _nott3 ~| is_Y;
    assign P2_Reset_XIY = _nott3 ~| _not_is_Y;

    wire _nott3_X = P2_Reset_XIX ~| P2_Reset_XIX;
    wire _nott3_Y = P2_Reset_XIY ~| P2_Reset_XIY;

    // X

    wire _01xx0xxx_X;
    wire _01xx1xxx_X;

    DECODER_1bit_decoder d_01xxdxxx_t3_X(
        .notEnable(_nott3_X),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_01xx0xxx_X),
        .out1(_01xx1xxx_X)
    );

    wire _not01xx0xxx_X = _01xx0xxx_X ~| _01xx0xxx_X;
    wire _not01xx1xxx_X = _01xx1xxx_X ~| _01xx1xxx_X;

    wire _LDlIXtdlr;

    DECODER_2bit_decoder d_01dd0xxx_t3_X( // 8
        .notEnable(_not01xx0xxx_X),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(P2_Set_ILDrlIXtdl_B),
        .out01(P2_Set_ILDrlIXtdl_D),
        .out10(P2_Set_ILDrlIXtdl_H),
        .out11(_LDlIXtdlr)
    );

    DECODER_2bit_decoder d_01dd1xxx_t3_X( // 8
        .notEnable(_not01xx1xxx_X),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(P2_Set_ILDrlIXtdl_C),
        .out01(P2_Set_ILDrlIXtdl_E),
        .out10(P2_Set_ILDrlIXtdl_L),
        .out11(P2_Set_ILDrlIXtdl_A)
    );

    wire _not_LDlIXtdlr = _LDlIXtdlr ~| _LDlIXtdlr;

    wire _011100xx_X;
    wire _011101xx_X;

    DECODER_1bit_decoder d_0111dxx_t3_X(
        .notEnable(_not_LDlIXtdlr),
        .In(Source[2]),
        .notIn(notSource[2]),
        .out0(_011100xx_X),
        .out1(_011101xx_X)
    );

    wire _not011100xx_X = _011100xx_X ~| _011100xx_X;
    wire _not011101xx_X = _011101xx_X ~| _011101xx_X;

    DECODER_2bit_decoder d_01110dd_t3_X( // 8
        .notEnable(_not011100xx_X),
        .In(Source[1:0]),
        .notIn(notSource[1:0]),
        .out00(P2_Set_ILDlIXtdlr_B),
        .out01(P2_Set_ILDlIXtdlr_C),
        .out10(P2_Set_ILDlIXtdlr_D),
        .out11(P2_Set_ILDlIXtdlr_E)
    );

    DECODER_2bit_decoder d_01111dd_t3_X( // 5
        .notEnable(_not011101xx_X),
        .In(Source[1:0]),
        .notIn(notSource[1:0]),
        .out00(P2_Set_ILDlIXtdlr_H),
        .out01(P2_Set_ILDlIXtdlr_L),
        .out1x(P2_Set_ILDlIXtdlr_A)
    );

    // Y

    wire _01xx0xxx_Y;
    wire _01xx1xxx_Y;

    DECODER_1bit_decoder d_01xxdxxx_t3_Y(
        .notEnable(_nott3_Y),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_01xx0xxx_Y),
        .out1(_01xx1xxx_Y)
    );

    wire _not01xx0xxx_Y = _01xx0xxx_Y ~| _01xx0xxx_Y;
    wire _not01xx1xxx_Y = _01xx1xxx_Y ~| _01xx1xxx_Y;

    wire _LDlIYtdlr;

    DECODER_2bit_decoder d_01dd0xxx_t3_Y( // 8
        .notEnable(_not01xx0xxx_Y),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(P2_Set_ILDrlIYtdl_B),
        .out01(P2_Set_ILDrlIYtdl_D),
        .out10(P2_Set_ILDrlIYtdl_H),
        .out11(_LDlIYtdlr)
    );

    DECODER_2bit_decoder d_01dd1xxx_t3_Y( // 8
        .notEnable(_not01xx1xxx_Y),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(P2_Set_ILDrlIYtdl_C),
        .out01(P2_Set_ILDrlIYtdl_E),
        .out10(P2_Set_ILDrlIYtdl_L),
        .out11(P2_Set_ILDrlIYtdl_A)
    );

    wire _not_LDlIYtdlr = _LDlIYtdlr ~| _LDlIYtdlr;

    wire _011100xx_Y;
    wire _011101xx_Y;

    DECODER_1bit_decoder d_0111dxx_t3_Y(
        .notEnable(_not_LDlIYtdlr),
        .In(Source[2]),
        .notIn(notSource[2]),
        .out0(_011100xx_Y),
        .out1(_011101xx_Y)
    );

    wire _not011100xx_Y = _011100xx_Y ~| _011100xx_Y;
    wire _not011101xx_Y = _011101xx_Y ~| _011101xx_Y;

    DECODER_2bit_decoder d_01110dd_t3_Y( // 5
        .notEnable(_not011100xx_Y),
        .In(Source[1:0]),
        .notIn(notSource[1:0]),
        .out00(P2_Set_ILDlIYtdlr_B),
        .out01(P2_Set_ILDlIYtdlr_C),
        .out10(P2_Set_ILDlIYtdlr_D),
        .out11(P2_Set_ILDlIYtdlr_E)
    );

    DECODER_2bit_decoder d_01111dd_t3_Y( // 5
        .notEnable(_not011101xx_Y),
        .In(Source[1:0]),
        .notIn(notSource[1:0]),
        .out00(P2_Set_ILDlIYtdlr_H),
        .out01(P2_Set_ILDlIYtdlr_L),
        .out1x(P2_Set_ILDlIYtdlr_A)
    );

endmodule