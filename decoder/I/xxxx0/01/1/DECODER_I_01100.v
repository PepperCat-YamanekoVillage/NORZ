// LD dd,nn
// 5(23)
module DECODER_I_01100(
        input wire enable,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire P2_Set_CMR,
        output wire P2_Set_ILDddnn_BC_1,
        output wire P2_Set_ILDddnn_DE_1,
        output wire P2_Set_ILDddnn_HL_1,
        output wire P2_Set_ILDddnn_SP_1,
        output wire PR_Write_C,
        output wire PR_Write_E,
        output wire PR_Write_L,
        output wire PR_Write_SP_low,
        output wire PR_Reset_XPT,
        output wire P2_Set_CM1, // <
        output wire P2_Reset_ITABLE,
        output wire PR_InvertIn,
        output wire Pa_Ophd, // >
        output wire PR_Write_B,
        output wire PR_Write_D,
        output wire PR_Write_H,
        output wire PR_Write_SP_high,
    );

    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _011000xx;
    wire _011001xx;

    DECODER_1bit_decoder d_01100dxx(
        .notEnable(_not_enable),
        .In(ITABLE[2]),
        .notIn(notITABLE[2]),
        .out0(_011000xx),
        .out1(_011001xx)
    );

    wire _not011000xx = _011000xx ~| _011000xx;
    wire _not011001xx = _011001xx ~| _011001xx;

    wire _01100000;
    wire _01100001;
    wire _01100010;
    wire _01100011;

    DECODER_2bit_decoder d_011000dd( // 8
        .notEnable(_not011000xx),
        .In(ITABLE[1:0]),
        .notIn(notITABLE[1:0]),
        .out00(_01100000),
        .out01(_01100001),
        .out10(_01100010),
        .out11(_01100011)
    );

    wire _01100100;
    wire _01100101;
    wire _01100110;
    wire _01100111;

    DECODER_2bit_decoder d_011001dd( // 8
        .notEnable(_not011001xx),
        .In(ITABLE[1:0]),
        .notIn(notITABLE[1:0]),
        .out00(_01100100),
        .out01(_01100101),
        .out10(_01100110),
        .out11(_01100111)
    );

    // _0 or _1

    assign PR_Reset_XPT = (_011000xx | _011001xx); // 2

    //
    // _0
    //

    assign P2_Set_CMR = _011000xx;

    assign P2_Set_ILDddnn_BC_1 = _01100000;
    assign P2_Set_ILDddnn_DE_1 = _01100001;
    assign P2_Set_ILDddnn_HL_1 = _01100010;
    assign P2_Set_ILDddnn_SP_1 = _01100011;

    assign PR_Write_C = _01100000;
    assign PR_Write_E = _01100001;
    assign PR_Write_L = _01100010;
    assign PR_Write_SP_low = _01100011;

    //
    // _1
    //

    assign P2_Set_CM1 = _011001xx;
    assign P2_Reset_ITABLE = _011001xx;
    assign PR_InvertIn = _011001xx;
    assign Pa_Ophd = _011001xx;

    assign PR_Write_B = _01100100;
    assign PR_Write_D = _01100101;
    assign PR_Write_H = _01100110;
    assign PR_Write_SP_high = _01100111;

endmodule