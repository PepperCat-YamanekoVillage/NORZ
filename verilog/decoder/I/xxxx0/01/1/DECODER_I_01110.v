// LD dd,(nn)
// 34(57)
module DECODER_I_01110(
        input wire enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire [8:0] _decodedXPT,
        output wire P2_Set_CMR,
        output wire P2_Set_ILDddlnnl_BC_1,
        output wire P2_Set_ILDddlnnl_DE_1,
        output wire P2_Set_ILDddlnnl_HL_1,
        output wire P2_Set_ILDddlnnl_SP_1,
        output wire PR_Reset_XPT,
        output wire PI_SelectAd_OPOPold,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_Write_C,
        output wire PR_Write_E,
        output wire PR_Write_L,
        output wire PR_Write_SP_low,
        output wire PI_SelectAdt1,
        output wire P2_Set_CM1, // <
        output wire P2_Reset_ITABLE,
        output wire PR_InvertIn,
        output wire Pa_Ophd, // >
        output wire PR_Write_B,
        output wire PR_Write_D,
        output wire PR_Write_H,
        output wire PR_Write_SP_high
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _011100xx;
    wire _011101xx;

    DECODER_1bit_decoder d_01110dxx(
        .notEnable(_not_enable),
        .In(ITABLE[2]),
        .notIn(notITABLE[2]),
        .out0(_011100xx),
        .out1(_011101xx)
    );

    wire _not011100xx = _011100xx ~| _011100xx;
    wire _not011101xx = _011101xx ~| _011101xx;

    wire _01110000;
    wire _01110001;
    wire _01110010;
    wire _01110011;

    DECODER_2bit_decoder d_011100dd( // 8
        .notEnable(_not011100xx),
        .In(ITABLE[1:0]),
        .notIn(notITABLE[1:0]),
        .out00(_01110000),
        .out01(_01110001),
        .out10(_01110010),
        .out11(_01110011)
    );

    wire _01110100;
    wire _01110101;
    wire _01110110;
    wire _01110111;

    DECODER_2bit_decoder d_011101dd( // 8
        .notEnable(_not011101xx),
        .In(ITABLE[1:0]),
        .notIn(notITABLE[1:0]),
        .out00(_01110100),
        .out01(_01110101),
        .out10(_01110110),
        .out11(_01110111)
    );

    //
    // XPT
    //

    wire _t00xx;
    wire _t01xx;

    DECODER_2bit_decoder t_ddxx( // 5
        .notEnable(_not011101xx),
        .In(XPT[3:2]),
        .notIn(notXPT[3:2]),
        .out00(_t00xx),
        .out01(_t01xx),
        .out1x(_decodedXPT[8])
    );

    wire _nott00xx = _t00xx ~| _t00xx; 
    wire _nott01xx = _t01xx ~| _t01xx; 

    assign _decodedXPT[3] = _nott00xx ~| notXPT[0];

    wire _t6or7;

    DECODER_2bit_decoder t_01dd( // 5
        .notEnable(_nott01xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out1x(_t6or7),
        .out00(_decodedXPT[4]),
        .out01(_decodedXPT[5]),
        .out10(_decodedXPT[6]),
        .out11(_decodedXPT[7])
    );

    //
    // _0
    //

    assign P2_Set_CMR = _011100xx;

    assign P2_Set_ILDddlnnl_BC_1 = _01110000;
    assign P2_Set_ILDddlnnl_DE_1 = _01110001;
    assign P2_Set_ILDddlnnl_HL_1 = _01110010;
    assign P2_Set_ILDddlnnl_SP_1 = _01110011;

    // _0or_1_8

    assign PR_Reset_XPT = (_011100xx | _decodedXPT[8]); // 2

    //
    // _1
    //

    // 3~8

    assign PI_SelectAd_OPOPold = (_decodedXPT[3] | _t01xx | _decodedXPT[8]); // 4

    assign PC_R0 = (_decodedXPT[3] | _decodedXPT[6]); // 2
    assign PC_R1 = (_decodedXPT[4] | _decodedXPT[7]); // 2
    assign PC_R2 = (_decodedXPT[5] | _decodedXPT[8]); // 2

    // 5

    wire _not01110100 = _01110100 ~| _01110100;
    wire _not01110101 = _01110101 ~| _01110101;
    wire _not01110110 = _01110110 ~| _01110110;
    wire _not01110111 = _01110111 ~| _01110111;

    wire _nott5 = _decodedXPT[5] ~|  _decodedXPT[5];

    assign PR_Write_C = _nott5 ~| _not01110100;
    assign PR_Write_E = _nott5 ~| _not01110101;
    assign PR_Write_L = _nott5 ~| _not01110110;
    assign PR_Write_SP_low = _nott5 ~| _not01110111;

    // 6~8

    assign PI_SelectAdt1 = (_t6or7 | _decodedXPT[8]); // 2

    // 8

    wire _nott8 = _decodedXPT[8] ~| _decodedXPT[8];

    assign P2_Set_CM1 = _decodedXPT[8];
    assign P2_Reset_ITABLE = _decodedXPT[8];
    assign PR_InvertIn = _decodedXPT[8];
    assign Pa_Ophd = _decodedXPT[8];

    assign PR_Write_B = _nott8 ~| _not01110100;
    assign PR_Write_D = _nott8 ~| _not01110101;
    assign PR_Write_H = _nott8 ~| _not01110110;
    assign PR_Write_SP_high = _nott8 ~| _not01110111;

endmodule