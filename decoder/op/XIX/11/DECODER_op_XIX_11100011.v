// EX (SP),IX/IY
// 42(79)
module DECODER_op_XIX_11100011(
        input wire enable,
        input wire is_Y,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        output wire [18:0] _decodedXPT,
        output wire PA_NOP, // <
        output wire PR_Write_Dt,
        output wire PR_Write_Dtex, // >
        output wire PI_SelectAd_SP,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_InvertIn,
        output wire PI_SelectDt_Dt,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PI_SelectDt_Dtex,
        output wire PI_SelectAdt1,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd, // >
        output wire PA_Select_IX_low,
        output wire PA_Select_IY_low,
        output wire PR_Write_IX_low,
        output wire PR_Write_IY_low,
        output wire PR_Write_IX_high,
        output wire PR_Write_IY_high,
        output wire P2_Reset_XIX,
        output wire P2_Reset_XIY
    );

    // wire [4:0] notXPT = ~XPT;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    wire _t0xxxx;
    wire _t1xxxx;

    DECODER_1bit_decoder t_dxxxx(
        .notEnable(_not_enable),
        .In(XPT[4]),
        .notIn(notXPT[4]),
        .out0(_t0xxxx),
        .out1(_t1xxxx),
    );

    wire _nott0xxxx = _t0xxxx ~| _t0xxxx;

    wire _t000xx;
    wire _t001xx;
    wire _t010xx;
    wire _t011xx;

    DECODER_2bit_decoder t_0ddxx( // 8
        .notEnable(_nott0xxxx),
        .In(XPT[3:2]),
        .notIn(notXPT[3:2]),
        .out00(_t000xx),
        .out01(_t001xx),
        .out10(_t010xx),
        .out11(_t011xx)
    );

    wire _nott000xx = _t000xx ~| _t000xx;
    wire _nott001xx = _t001xx ~| _t001xx;
    wire _nott010xx = _t010xx ~| _t010xx;
    wire _nott011xx = _t011xx ~| _t011xx;

    assign _decodedXPT[3] = _nott000xx ~| notXPT[0];

    DECODER_2bit_decoder t_001dd( // 8
        .notEnable(_nott001xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[4]),
        .out01(_decodedXPT[5]),
        .out10(_decodedXPT[6]),
        .out11(_decodedXPT[7])
    );

    wire _t8or9;

    DECODER_2bit_decoder t_010dd( // 7
        .notEnable(_nott010xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[8]),
        .out01(_decodedXPT[9]),
        .out11(_decodedXPT[11]),
        .out0x(_t8or9)
    );

    wire _t12or13;
    wire _t14or15;

    DECODER_2bit_decoder t_011dd( // 8
        .notEnable(_nott011xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[12]),
        .out01(_decodedXPT[13]),
        .out10(_decodedXPT[14]),
        .out11(_decodedXPT[15]),
        .out0x(_t12or13),
        .out1x(_t14or15)
    );

    wire _nott1xxxx = _t1xxxx ~| _t1xxxx;

    DECODER_2bit_decoder t_100dd( // 4
        .notEnable(_nott1xxxx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[16]),
        .out1x(_decodedXPT[18])
    );

    // 3

    assign PA_NOP = _decodedXPT[3];
    assign PR_Write_Dt = _decodedXPT[3];
    assign PR_Write_Dtex = _decodedXPT[3];

    wire _nott3 = _decodedXPT[3] ~| _decodedXPT[3];

    wire _not_is_Y = is_Y ~| is_Y;

    assign PA_Select_IX_low = _nott3 ~| is_Y;
    assign PA_Select_IY_low = _nott3 ~| _not_is_Y;

    // 4~18

    assign PI_SelectAd_SP = _not_enable ~| _t000xx;

    // 4or7

    assign PC_R0 = (_decodedXPT[4] | _decodedXPT[7]); // 2

    // 5or8

    assign PC_R1 = (_decodedXPT[5] | _decodedXPT[8]); // 2

    // 6or9

    assign PC_R2 = (_decodedXPT[6] | _decodedXPT[9]); // 2

    // 6

    wire _nott6 = _decodedXPT[6] ~| _decodedXPT[6];

    assign PR_Write_IX_low = _nott6 ~| is_Y;
    assign PR_Write_IY_low = _nott6 ~| _not_is_Y;

    // 9

    assign PR_InvertIn = _decodedXPT[9];

    wire _nott9 = _decodedXPT[9] ~| _decodedXPT[9];

    assign PR_Write_IX_high = _nott9 ~| is_Y;
    assign PR_Write_IY_high = _nott9 ~| _not_is_Y;

    // 11~13

    assign PI_SelectDt_Dt = (_decodedXPT[11] | _t12or13); // 2

    // 11or14

    assign PC_W0 = (_decodedXPT[11] | _decodedXPT[14]); // 2

    // 12or15

    assign PC_W1 = (_decodedXPT[12] | _decodedXPT[15]); // 2

    // 13or16

    assign PC_W2 = (_decodedXPT[13] | _decodedXPT[16]); // 2

    // 14~16

    wire _t14_16 = (_t14or15 | _decodedXPT[16]); // 2
    assign PI_SelectDt_Dtex = _t14_16;

    // 7~9 or 14~16

    assign PI_SelectAdt1 =(_decodedXPT[7] | _t8or9 | _t14_16); // 4
    
    // 18

    assign PR_Reset_XPT = _decodedXPT[18];
    assign P2_Set_CM1 = _decodedXPT[18];
    assign Pa_Ophd = _decodedXPT[18];

    wire _nott18 = _decodedXPT[18] ~| _decodedXPT[18];

    assign P2_Reset_XIX = _nott18 ~| is_Y;
    assign P2_Reset_XIY = _nott18 ~| _not_is_Y;

endmodule