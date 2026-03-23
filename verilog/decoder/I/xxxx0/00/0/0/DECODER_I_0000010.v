// LD A,(nn)
// 6(15)
module DECODER_I_0000010(
        input wire enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire [5:0] _decodedXPT,
        output wire P2_Set_CMR,
        output wire P2_Set_ILDAlnnl_1,
        output wire PR_Reset_XPT,
        output wire PI_SelectAd_OPOPold,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire P2_Set_CM1, // <
        output wire P2_Reset_ITABLE,
        output wire PR_Write_A,
        output wire PR_InvertIn,
        output wire Pa_Ophd // >
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _0;
    wire _1;

    DECODER_1bit_decoder d_0000010d(
        .notEnable(_not_enable),
        .In(ITABLE[0]),
        .notIn(notITABLE[0]),
        .out0(_0),
        .out1(_1)
    );

    //
    // XPT
    //

    wire _not1 = _1 ~| _1;

    wire _t4or5;

    DECODER_2bit_decoder t_ddxx( // 7
        .notEnable(_not1),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out0x(_t4or5),
        .out00(_decodedXPT[4]),
        .out01(_decodedXPT[5]),
        .out11(_decodedXPT[3])
    );

    //
    // _0
    //

    assign P2_Set_CMR = _0;
    assign P2_Set_ILDAlnnl_1 = _0;

    // _0or_1_5

    assign PR_Reset_XPT = (_0 | _decodedXPT[5]); // 2

    //
    // _1
    //

    // 3~6

    assign PI_SelectAd_OPOPold = (_decodedXPT[3] | _t4or5); // 2

    // 3

    assign PC_R0 = _decodedXPT[3];

    // 4

    assign PC_R1 = _decodedXPT[4];

    // 5

    assign PC_R2 = _decodedXPT[5];

    assign P2_Set_CM1 = _decodedXPT[5];
    assign P2_Reset_ITABLE = _decodedXPT[5];
    assign PR_Write_A = _decodedXPT[5];
    assign PR_InvertIn = _decodedXPT[5];
    assign Pa_Ophd = _decodedXPT[5];

endmodule
