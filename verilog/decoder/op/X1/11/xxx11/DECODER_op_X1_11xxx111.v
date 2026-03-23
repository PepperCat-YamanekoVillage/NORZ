// RST p
// 17(52)
module DECODER_op_X1_11xxx111(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [10:0] _decodedXPT,
        output wire PR_Dec_SP,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PI_SelectDt_PC_high,
        output wire PI_SelectDt_PC_low,
        output wire PI_SelectAd_SP,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd,
        output wire PA_NOP,
        output wire PR_Write_PC_high,
        output wire PR_Write_PC_low, // >
        output wire PA_Select_0x8_low,
        output wire PA_Select_0x10_low,
        output wire PA_Select_0x18_low,
        output wire PA_Select_0x20_low,
        output wire PA_Select_0x28_low,
        output wire PA_Select_0x30_low,
        output wire PA_Select_0x38_low
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    wire _t01xx;
    wire _t10xx;

    DECODER_2bit_decoder t_ddxx( // 5
        .notEnable(_not_enable),
        .In(XPT[3:2]),
        .notIn(notXPT[3:2]),
        .out01(_t01xx),
        .out1x(_t10xx)
    );

    wire _nott01xx = _t01xx ~| _t01xx;
    wire _nott10xx = _t10xx ~| _t10xx;

    DECODER_2bit_decoder t_01dd( // 8
        .notEnable(_nott01xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[4]),
        .out01(_decodedXPT[5]),
        .out10(_decodedXPT[6]),
        .out11(_decodedXPT[7])
    );

    DECODER_2bit_decoder t_10dd( // 5
        .notEnable(_nott10xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[8]),
        .out01(_decodedXPT[9]),
        .out1x(_decodedXPT[10])
    );

    // 4or7

    assign PR_Dec_SP = (_decodedXPT[4] | _decodedXPT[7]); // 2

    // 5or8

    assign PC_W0 = (_decodedXPT[5] | _decodedXPT[8]); // 2

    // 6or9

    assign PC_W1 = (_decodedXPT[6] | _decodedXPT[9]); // 2

    // 7or10

    assign PC_W2 = (_decodedXPT[7] | _decodedXPT[10]); // 2

    // 5~7

    wire _t5_7 = _nott01xx ~| _decodedXPT[4];
    assign PI_SelectDt_PC_high = _t5_7;

    // 8~10

    assign PI_SelectDt_PC_low = _t10xx;

    // 5~10

    assign PI_SelectAd_SP = (_t5_7 | _t10xx); // 2

    // 10

    assign PR_Reset_XPT = _decodedXPT[10];
    assign P2_Set_CM1 = _decodedXPT[10];
    assign Pa_Ophd = _decodedXPT[10];
    assign PA_NOP = _decodedXPT[10];
    assign PR_Write_PC_high = _decodedXPT[10];
    assign PR_Write_PC_low = _decodedXPT[10];

    //
    // decoder
    //

    wire _nott10 = _decodedXPT[10] ~| _decodedXPT[10];

    wire _110xx111_t10;
    wire _111xx111_t10;

    DECODER_1bit_decoder d_11dxx111_t10(
        .notEnable(_nott10),
        .In(Source[5]),
        .notIn(notSource[5]),
        .out0(_110xx111_t10),
        .out1(_111xx111_t10)
    );

    wire _not110xx111_t10 = _110xx111_t10 ~| _110xx111_t10;
    wire _not111xx111_t10 = _111xx111_t10 ~| _111xx111_t10;

    DECODER_2bit_decoder d_110dd111_t10( // 7
        .notEnable(_not110xx111_t10),
        .In(Source[4:3]),
        .notIn(notSource[4:3]),
        .out01(PA_Select_0x8_low),
        .out10(PA_Select_0x10_low),
        .out11(PA_Select_0x18_low)
    );

    DECODER_2bit_decoder d_111dd111_t10( // 8
        .notEnable(_not111xx111_t10),
        .In(Source[4:3]),
        .notIn(notSource[4:3]),
        .out00(PA_Select_0x20_low),
        .out01(PA_Select_0x28_low),
        .out10(PA_Select_0x30_low),
        .out11(PA_Select_0x38_low)
    );

endmodule