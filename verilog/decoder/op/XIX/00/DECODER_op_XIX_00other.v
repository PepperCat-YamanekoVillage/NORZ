// LD (IX/IY+d),n / LD IX/IY,nn / LD IX/IY,(nn) / LD (nn),IX/IY / INC/DEC (IX/IY+d)
// 27(38)
module DECODER_op_XIX_00other(
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
        output wire P2_Set_ILDIXlnnl_0,
        output wire P2_Set_ILDIYlnnl_0,
        output wire P2_Set_ILDIXnn_0,
        output wire P2_Set_ILDIYnn_0,
        output wire P2_Set_ILDlnnlIX_0,
        output wire P2_Set_ILDlnnlIY_0,
        output wire P2_Set_IINClIXtdl,
        output wire P2_Set_IINClIYtdl,
        output wire P2_Set_IDEClIXtdl,
        output wire P2_Set_IDEClIYtdl,
        output wire P2_Set_ILDlIXtdln_0,
        output wire P2_Set_ILDlIYtdln_0
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

    wire _nott3 = _decodedXPT[3] ~| _decodedXPT[3];

    wire _not_is_Y = is_Y ~| is_Y;

    assign P2_Reset_XIX = _nott3 ~| is_Y;

    assign P2_Reset_XIY = _nott3 ~| _not_is_Y;

    //
    // decoder
    //

    wire _001x0xxx;
    wire _00101010;

    DECODER_1bit_decoder d_001xdxxx(
        .notEnable(_nott3),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_001x0xxx),
        .out1(_00101010)
    );

    wire _not001x0xxx = _001x0xxx ~| _001x0xxx;

    wire _00100xxx;
    wire _00110xxx;

    DECODER_1bit_decoder d_001d0xxx(
        .notEnable(_not001x0xxx),
        .In(Source[4]),
        .notIn(notSource[4]),
        .out0(_00100xxx),
        .out1(_00110xxx)
    );

    wire _not00100xxx = _00100xxx ~| _00100xxx;

    wire _00100001;
    wire _00100010;

    DECODER_1bit_decoder d_001000xd(
        .notEnable(_not00100xxx),
        .In(Source[0]),
        .notIn(notSource[0]),
        .out0(_00100010),
        .out1(_00100001)
    );

    wire _not00110xxx = _00110xxx ~| _00110xxx;

    wire _00110100;
    wire _00110101;
    wire _00110110;

    DECODER_2bit_decoder d_001101dd( // 5
        .notEnable(_not00110xxx),
        .In(Source[1:0]),
        .notIn(notSource[1:0]),
        .out00(_00110100),
        .out01(_00110101),
        .out1x(_00110110)
    );


    wire _not00101010 = _00101010 ~| _00101010;

    assign P2_Set_ILDIXlnnl_0 = _not00101010 ~| is_Y;
    assign P2_Set_ILDIYlnnl_0 = _not00101010 ~| _not_is_Y;

    wire _not00100001 = _00100001 ~| _00100001;

    assign P2_Set_ILDIXnn_0 = _not00100001 ~| is_Y;
    assign P2_Set_ILDIYnn_0 = _not00100001 ~| _not_is_Y;

    wire _not00100010 = _00100010 ~| _00100010;

    assign P2_Set_ILDlnnlIX_0 = _not00100010 ~| is_Y;
    assign P2_Set_ILDlnnlIY_0 = _not00100010 ~| _not_is_Y;

    wire _not00110100 = _00110100 ~| _00110100;

    assign P2_Set_IINClIXtdl = _not00110100 ~| is_Y;
    assign P2_Set_IINClIYtdl = _not00110100 ~| _not_is_Y;

    wire _not00110101 = _00110101 ~| _00110101;

    assign P2_Set_IDEClIXtdl = _not00110101 ~| is_Y;
    assign P2_Set_IDEClIYtdl = _not00110101 ~| _not_is_Y;

    wire _not00110110 = _00110110 ~| _00110110;

    assign P2_Set_ILDlIXtdln_0 = _not00110110 ~| is_Y;
    assign P2_Set_ILDlIYtdln_0 = _not00110110 ~| _not_is_Y;

endmodule