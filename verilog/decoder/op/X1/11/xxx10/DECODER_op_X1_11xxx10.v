// 16(95)
module DECODER_op_X1_11xxx10(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [3:0] _decodedXPT,
        output wire PR_Reset_XPT,
        output wire PR_Dec_SP,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PI_SelectDt_B,
        output wire PI_SelectDt_C,
        output wire PI_SelectDt_D,
        output wire PI_SelectDt_E,
        output wire PI_SelectDt_H,
        output wire PI_SelectDt_L,
        output wire PI_SelectDt_A,
        output wire PI_SelectDt_F,
        output wire PI_SelectAd_SP,
        output wire P2_Set_CM1,
        output wire Pa_Ophd,
        output wire P2_Set_CMR,
        output wire P2_Set_ICALLccnn_0_0,
        output wire P2_Set_ICALLccnn_1_0,
        output wire P2_Set_ICALLccnn_2_0,
        output wire P2_Set_ICALLccnn_3_0,
        output wire P2_Set_ICALLccnn_4_0,
        output wire P2_Set_ICALLccnn_5_0,
        output wire P2_Set_ICALLccnn_6_0,
        output wire P2_Set_ICALLccnn_7_0,
        output wire P2_Set_ICALLnn_0,
        output wire P2_Set_XIX,
        output wire P2_Set_XOTR,
        output wire P2_Set_XIY
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _11xx0101 = ~(_not_enable | Source[3] | notSource[0]); // 3

    //
    // XPT
    //

    assign _decodedXPT[3] = ~(_not_enable | _11xx0101 | notXPT[0]); // 3

    //
    // decoder
    //

    wire _nott3 = _decodedXPT[3] ~| _decodedXPT[3];

    wire _11xxx100 = _nott3 ~| Source[0];
    wire _11xx1101 = _nott3 ~| notSource[0];

    wire _PR_Reset_XPT_01;
    wire _P2_Set_CM1_01;

    DECODER_op_X1_11xx0101 d11xx0101(
        .enable(_11xx0101),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Dec_SP(PR_Dec_SP),
        .PC_W0(PC_W0),
        .PC_W1(PC_W1),
        .PC_W2(PC_W2),
        .PI_SelectDt_B(PI_SelectDt_B),
        .PI_SelectDt_C(PI_SelectDt_C),
        .PI_SelectDt_D(PI_SelectDt_D),
        .PI_SelectDt_E(PI_SelectDt_E),
        .PI_SelectDt_H(PI_SelectDt_H),
        .PI_SelectDt_L(PI_SelectDt_L),
        .PI_SelectDt_A(PI_SelectDt_A),
        .PI_SelectDt_F(PI_SelectDt_F),
        .PI_SelectAd_SP(PI_SelectAd_SP),
        .PR_Reset_XPT(_PR_Reset_XPT_01), // <
        .P2_Set_CM1(_P2_Set_CM1_01),
        .Pa_Ophd(Pa_Ophd) // >
    );

    wire _P2_Set_CMR_x0;

    DECODER_op_X1_11xxx100 d11xxx100(
        .enable(_11xxx100),
        .Source(Source),
        .notSource(notSource),
        .P2_Set_CMR(_P2_Set_CMR_x0),
        .P2_Set_ICALLccnn_0_0(P2_Set_ICALLccnn_0_0),
        .P2_Set_ICALLccnn_1_0(P2_Set_ICALLccnn_1_0),
        .P2_Set_ICALLccnn_2_0(P2_Set_ICALLccnn_2_0),
        .P2_Set_ICALLccnn_3_0(P2_Set_ICALLccnn_3_0),
        .P2_Set_ICALLccnn_4_0(P2_Set_ICALLccnn_4_0),
        .P2_Set_ICALLccnn_5_0(P2_Set_ICALLccnn_5_0),
        .P2_Set_ICALLccnn_6_0(P2_Set_ICALLccnn_6_0),
        .P2_Set_ICALLccnn_7_0(P2_Set_ICALLccnn_7_0)
    );

    wire _P2_Set_CMR_11;
    wire _P2_Set_CM1_11;

    DECODER_op_X1_11xx1101 d11xx1101(
        .enable(_11xx1101),
        .Source(Source),
        .notSource(notSource),
        .P2_Set_ICALLnn_0(P2_Set_ICALLnn_0),
        .P2_Set_XIX(P2_Set_XIX),
        .P2_Set_XOTR(P2_Set_XOTR),
        .P2_Set_XIY(P2_Set_XIY),
        .P2_Set_CMR(_P2_Set_CMR_11),
        .P2_Set_CM1(_P2_Set_CM1_11)
    );

    assign PR_Reset_XPT = (_decodedXPT[3] | _PR_Reset_XPT_01); // 2

    assign P2_Set_CM1 = (_P2_Set_CM1_01 | _P2_Set_CM1_11); // 2
    assign P2_Set_CMR = (_P2_Set_CMR_x0 | _P2_Set_CMR_11); // 2

endmodule