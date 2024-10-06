// 64(247)
module DECODER_op_XIX_11(
        input wire enable,
        input wire is_Y,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire P2_Set_CM1, // <
        output wire Pa_Ophd, // >
        output wire PR_Reset_XPT,
        output wire P2_Set_CMR,
        output wire P2_Reset_XIX,
        output wire P2_Reset_XIY,
        output wire P2_Set_XIX4_0,
        output wire P2_Set_XIY4_0,
        output wire PI_SelectAd_SP,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_Inc_SP,
        output wire PR_InvertIn,
        output wire PR_Write_IX_low,
        output wire PR_Write_IY_low,
        output wire PA_Select_IX_high,
        output wire PA_Select_IY_high,
        output wire PA_NOP,
        output wire PR_Write_Dt,
        output wire PR_Write_Dtex,
        output wire PI_SelectDt_Dt,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PI_SelectDt_Dtex,
        output wire PI_SelectAdt1,
        output wire PA_Select_IX_low,
        output wire PA_Select_IY_low,
        output wire PR_Write_IX_high,
        output wire PR_Write_IY_high,
        output wire PR_Dec_SP,
        output wire PI_SelectDt_IX_high,
        output wire PI_SelectDt_IY_high,
        output wire PI_SelectDt_IX_low,
        output wire PI_SelectDt_IY_low,
        output wire PR_Write_PC_high,
        output wire PR_Write_PC_low,
        output wire PR_Write_SP
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _11001011;
    wire _1110xxxx;
    wire _11111001;

    DECODER_2bit_decoder d_11ddxxxx( // 5
        .notEnable(_not_enable),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out0x(_11001011),
        .out10(_1110xxxx),
        .out11(_11111001)
    );

    wire _not1110xxxx = _1110xxxx ~| _1110xxxx;

    wire _11100xxx;
    wire _11101001;

    DECODER_1bit_decoder d_1110dxxx(
        .notEnable(_not1110xxxx),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_11100xxx),
        .out1(_11101001),
    );

    wire _not11100xxx = _11100xxx ~| _11100xxx;

    wire _11100001;
    wire _11100011;
    wire _11100101;

    DECODER_2bit_decoder d_11100ddx( // 5
        .notEnable(_not11100xxx),
        .In(Source[2:1]),
        .notIn(notSource[2:1]),
        .out00(_11100001),
        .out01(_11100011),
        .out1x(_11100101)
    );

    wire _PR_Reset_XPT_XIX4;
    wire _P2_Reset_XIX_XIX4;
    wire _P2_Reset_XIY_XIX4;

    DECODER_op_XIX_11001011 d11001011(
        .enable(_11001011),
        .is_Y(is_Y),
        .XPT(XPT),
        .notXPT(notXPT),
        .PR_Reset_XPT(_PR_Reset_XPT_XIX4), // <
        .P2_Set_CMR(P2_Set_CMR), // >
        .P2_Reset_XIX(_P2_Reset_XIX_XIX4),
        .P2_Reset_XIY(_P2_Reset_XIY_XIX4),
        .P2_Set_XIX4_0(P2_Set_XIX4_0),
        .P2_Set_XIY4_0(P2_Set_XIY4_0)
    );

    wire _PI_SelectAd_SP_POP;
    wire _PC_R0_POP;
    wire _PC_R1_POP;
    wire _PC_R2_POP;
    wire _PR_Reset_XPT_POP; // <
    wire _P2_Set_CM1_POP;
    wire _Pa_Ophd_POP;
    wire _PR_InvertIn_POP; // >
    wire _PR_Write_IX_low_POP;
    wire _PR_Write_IY_low_POP;
    wire _P2_Reset_XIX_POP;
    wire _P2_Reset_XIY_POP;

    DECODER_op_XIX_11100001 d11100001(
        .enable(_11100001),
        .is_Y(is_Y),
        .XPT(XPT),
        .notXPT(notXPT),
        .PI_SelectAd_SP(_PI_SelectAd_SP_POP),
        .PC_R0(_PC_R0_POP),
        .PC_R1(_PC_R1_POP),
        .PC_R2(_PC_R2_POP),
        .PR_Inc_SP(PR_Inc_SP),
        .PR_Reset_XPT(_PR_Reset_XPT_POP), // <
        .P2_Set_CM1(_P2_Set_CM1_POP),
        .Pa_Ophd(_Pa_Ophd_POP),
        .PR_InvertIn(_PR_InvertIn_POP), // >
        .PR_Write_IX_low(_PR_Write_IX_low_POP),
        .PR_Write_IY_low(_PR_Write_IY_low_POP),
        .P2_Reset_XIX(_P2_Reset_XIX_POP), // <
        .PA_Select_IX_high(PA_Select_IX_high), // >
        .P2_Reset_XIY(_P2_Reset_XIY_POP), // <
        .PA_Select_IY_high(PA_Select_IY_high) // >
    );

    wire _PA_NOP_EX;
    wire _PI_SelectAd_SP_EX;
    wire _PC_R0_EX;
    wire _PC_R1_EX;
    wire _PC_R2_EX;
    wire _PR_InvertIn_EX;
    wire _PC_W0_EX;
    wire _PC_W1_EX;
    wire _PC_W2_EX;
    wire _PR_Reset_XPT_EX; // <
    wire _P2_Set_CM1_EX;
    wire _Pa_Ophd_EX; // >
    wire _PA_Select_IX_low_EX;
    wire _PA_Select_IY_low_EX;
    wire _PR_Write_IX_low_EX;
    wire _PR_Write_IY_low_EX;
    wire _P2_Reset_XIX_EX;
    wire _P2_Reset_XIY_EX;

    DECODER_op_XIX_11100011 d11100011(
        .enable(_11100011),
        .is_Y(is_Y),
        .XPT(XPT),
        .notXPT(notXPT),
        .PA_NOP(_PA_NOP_EX), // <
        .PR_Write_Dt(PR_Write_Dt),
        .PR_Write_Dtex(PR_Write_Dtex), // >
        .PI_SelectAd_SP(_PI_SelectAd_SP_EX),
        .PC_R0(_PC_R0_EX),
        .PC_R1(_PC_R1_EX),
        .PC_R2(_PC_R2_EX),
        .PR_InvertIn(_PR_InvertIn_EX),
        .PI_SelectDt_Dt(PI_SelectDt_Dt),
        .PC_W0(_PC_W0_EX),
        .PC_W1(_PC_W1_EX),
        .PC_W2(_PC_W2_EX),
        .PI_SelectDt_Dtex(PI_SelectDt_Dtex),
        .PI_SelectAdt1(PI_SelectAdt1),
        .PR_Reset_XPT(_PR_Reset_XPT_EX), // <
        .P2_Set_CM1(_P2_Set_CM1_EX),
        .Pa_Ophd(_Pa_Ophd_EX), // >
        .PA_Select_IX_low(_PA_Select_IX_low_EX),
        .PA_Select_IY_low(_PA_Select_IY_low_EX),
        .PR_Write_IX_low(_PR_Write_IX_low_EX),
        .PR_Write_IY_low(_PR_Write_IY_low_EX),
        .PR_Write_IX_high(PR_Write_IX_high),
        .PR_Write_IY_high(PR_Write_IY_high),
        .P2_Reset_XIX(_P2_Reset_XIX_EX),
        .P2_Reset_XIY(_P2_Reset_XIY_EX)
    );

    wire _PC_W0_PUSH;
    wire _PC_W1_PUSH;
    wire _PC_W2_PUSH;
    wire _PI_SelectAd_SP_PUSH;
    wire _PR_Reset_XPT_PUSH; // <
    wire _P2_Set_CM1_PUSH;
    wire _Pa_Ophd_PUSH; // >
    wire _P2_Reset_XIX_PUSH;
    wire _P2_Reset_XIY_PUSH;

    DECODER_op_XIX_11000101 d11000101(
        .enable(_11100101),
        .is_Y(is_Y),
        .XPT(XPT),
        .notXPT(notXPT),
        .PR_Dec_SP(PR_Dec_SP),
        .PC_W0(_PC_W0_PUSH),
        .PC_W1(_PC_W1_PUSH),
        .PC_W2(_PC_W2_PUSH),
        .PI_SelectDt_IX_high(PI_SelectDt_IX_high),
        .PI_SelectDt_IY_high(PI_SelectDt_IY_high),
        .PI_SelectDt_IX_low(PI_SelectDt_IX_low),
        .PI_SelectDt_IY_low(PI_SelectDt_IY_low),
        .PI_SelectAd_SP(_PI_SelectAd_SP_PUSH),
        .PR_Reset_XPT(_PR_Reset_XPT_PUSH), // <
        .P2_Set_CM1(_P2_Set_CM1_PUSH),
        .Pa_Ophd(_Pa_Ophd_PUSH), // >
        .P2_Reset_XIX(_P2_Reset_XIX_PUSH),
        .P2_Reset_XIY(_P2_Reset_XIY_PUSH)
    );

    wire _PR_Reset_XPT_JP; // <
    wire _P2_Set_CM1_JP;
    wire _Pa_Ophd_JP;
    wire _PA_NOP_JP; // >
    wire _P2_Reset_XIX_JP; // <
    wire _PA_Select_IX_low_JP; // >
    wire _P2_Reset_XIY_JP; // <
    wire _PA_Select_IY_low_JP; // >

    DECODER_op_XIX_11101001 d11101001(
        .enable(_11101001),
        .is_Y(is_Y),
        .XPT(XPT),
        .notXPT(notXPT),
        .PR_Reset_XPT(_PR_Reset_XPT_JP), // <
        .P2_Set_CM1(_P2_Set_CM1_JP),
        .Pa_Ophd(_Pa_Ophd_JP),
        .PA_NOP(_PA_NOP_JP),
        .PR_Write_PC_high(PR_Write_PC_high),
        .PR_Write_PC_low(PR_Write_PC_low), // >
        .P2_Reset_XIX(_P2_Reset_XIX_JP), // <
        .PA_Select_IX_low(_PA_Select_IX_low_JP), // >
        .P2_Reset_XIY(_P2_Reset_XIY_JP), // <
        .PA_Select_IY_low(_PA_Select_IY_low_JP) // >
    );

    wire _PR_Reset_XPT_LD; // <
    wire _P2_Set_CM1_LD;
    wire _Pa_Ophd_LD;
    wire _PA_NOP_LD; // >
    wire _P2_Reset_XIX_LD;
    wire _P2_Reset_XIY_LD;
    wire _PA_Select_IX_low_LD;
    wire _PA_Select_IY_low_LD;

    DECODER_op_XIX_11111001 d11111001(
        .enable(_11111001),
        .is_Y(is_Y),
        .XPT(XPT),
        .notXPT(notXPT),
        .PR_Reset_XPT(_PR_Reset_XPT_LD), // <
        .P2_Set_CM1(_P2_Set_CM1_LD),
        .Pa_Ophd(_Pa_Ophd_LD),
        .PA_NOP(_PA_NOP_LD),
        .PR_Write_SP(PR_Write_SP), // >
        .P2_Reset_XIX(_P2_Reset_XIX_LD),
        .P2_Reset_XIY(_P2_Reset_XIY_LD),
        .PA_Select_IX_low(_PA_Select_IX_low_LD),
        .PA_Select_IY_low(_PA_Select_IY_low_LD)
    );

    assign PA_Select_IX_low = (_PA_Select_IX_low_EX | _PA_Select_IX_low_JP | _PA_Select_IX_low_LD); // 4
    assign PA_Select_IY_low = (_PA_Select_IY_low_EX | _PA_Select_IY_low_JP | _PA_Select_IY_low_LD); // 4
    assign P2_Reset_XIX = (_P2_Reset_XIX_XIX4 | _P2_Reset_XIX_POP | _P2_Reset_XIX_EX | _P2_Reset_XIX_PUSH | _P2_Reset_XIX_JP | _P2_Reset_XIX_LD); // 10
    assign P2_Reset_XIY = (_P2_Reset_XIY_XIX4 | _P2_Reset_XIY_POP | _P2_Reset_XIY_EX | _P2_Reset_XIY_PUSH | _P2_Reset_XIY_JP | _P2_Reset_XIY_LD); // 10
    assign PR_Write_IX_low = (_PR_Write_IX_low_POP | _PR_Write_IX_low_EX); // 2
    assign PR_Write_IY_low = (_PR_Write_IY_low_POP | _PR_Write_IY_low_EX); // 2
    assign PC_R0 = (_PC_R0_POP | _PC_R0_EX); // 2
    assign PC_R1 = (_PC_R1_POP | _PC_R1_EX); // 2
    assign PC_R2 = (_PC_R2_POP | _PC_R2_EX); // 2
    assign PC_W0 = (_PC_W0_EX | _PC_W0_PUSH); // 2
    assign PC_W1 = (_PC_W1_EX | _PC_W1_PUSH); // 2
    assign PC_W2 = (_PC_W2_EX | _PC_W2_PUSH); // 2
    assign PI_SelectAd_SP = (_PI_SelectAd_SP_POP | _PI_SelectAd_SP_EX | _PI_SelectAd_SP_PUSH); // 4
    assign PR_InvertIn = (_PR_InvertIn_POP | _PR_InvertIn_EX); // 2

    wire _end_LDJP = (_PR_Reset_XPT_JP | _PR_Reset_XPT_LD); // 2
    assign PA_NOP = (_PA_NOP_EX | _end_LDJP); // 2
    assign P2_Set_CM1 = (_end_LDJP | _PR_Reset_XPT_POP | _PR_Reset_XPT_EX | _PR_Reset_XPT_PUSH ); // 6
    assign Pa_Ophd = P2_Set_CM1;
    assign PR_Reset_XPT = (P2_Set_CM1 | _PR_Reset_XPT_XIX4); // 2

endmodule