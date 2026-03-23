// LD (nn),dd / LD dd,(nn)
// 5(23)
module DECODER_op_XOTR_01xxx011(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CMR,
        output wire P2_Reset_XOTR, // >
        output wire P2_Set_ILDlnnldd_BC_0,
        output wire P2_Set_ILDlnnldd_DE_0,
        output wire P2_Set_ILDlnnldd_HL_0,
        output wire P2_Set_ILDlnnldd_SP_0,
        output wire P2_Set_ILDddlnnl_BC_0,
        output wire P2_Set_ILDddlnnl_DE_0,
        output wire P2_Set_ILDddlnnl_HL_0,
        output wire P2_Set_ILDddlnnl_SP_0
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    wire _decodedXPT3 = _not_enable ~| notXPT[0];

    assign PR_Reset_XPT = _decodedXPT3;
    assign P2_Set_CMR = _decodedXPT3;
    assign P2_Reset_XOTR = _decodedXPT3;

    //
    // decoder
    //

    wire _notdecodedXPT3 = _decodedXPT3 ~| _decodedXPT3;

    wire _01xx0011;
    wire _01xx1011;

    DECODER_1bit_decoder d_01xxd011(
        .notEnable(_notdecodedXPT3),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_01xx0011),
        .out1(_01xx1011)
    ); 

    wire _not01xx0011 = _01xx0011 ~| _01xx0011;

    DECODER_2bit_decoder d_01dd0011( // 8
        .notEnable(_not01xx0011),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(P2_Set_ILDlnnldd_BC_0),
        .out01(P2_Set_ILDlnnldd_DE_0),
        .out10(P2_Set_ILDlnnldd_HL_0),
        .out11(P2_Set_ILDlnnldd_SP_0)
    );

    wire _not01xx1011 = _01xx1011 ~| _01xx1011;

    DECODER_2bit_decoder d_01dd1011( // 8
        .notEnable(_not01xx1011),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(P2_Set_ILDddlnnl_BC_0),
        .out01(P2_Set_ILDddlnnl_DE_0),
        .out10(P2_Set_ILDddlnnl_HL_0),
        .out11(P2_Set_ILDddlnnl_SP_0)
    );

endmodule