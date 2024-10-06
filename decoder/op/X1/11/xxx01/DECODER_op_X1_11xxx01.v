// 29(134)
module DECODER_op_X1_11xxx01(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [3:0] _decodedXPT,
        output wire PR_Reset_XPT,
        output wire PA_Select_HL_low, // <
        output wire PA_NOP,
        output wire PR_Write_Dt,
        output wire PR_Write_Dtex, // >
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_Write_L,
        output wire PR_Write_H, // <
        output wire PR_InvertIn, // >
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PI_SelectDt_Dt,
        output wire PI_SelectDt_Dtex,
        output wire PI_SelectAdt1,
        output wire PI_SelectAd_SP,
        output wire P2_Set_CM1,
        output wire Pa_Ophd,
        output wire P2_Set_XBIT,
        output wire PR_Ex_DE_HL,
        output wire P2_Reset_IFF1, // <
        output wire P2_Reset_IFF2, // >
        output wire P2_Set_IFF1, // <
        output wire P2_Set_IFF2, // >
        output wire P2_Set_CMR,
        output wire P2_Set_IJPccnn_0_0,
        output wire P2_Set_IJPccnn_1_0,
        output wire P2_Set_IJPccnn_2_0,
        output wire P2_Set_IJPccnn_3_0,
        output wire P2_Set_IJPccnn_4_0,
        output wire P2_Set_IJPccnn_5_0,
        output wire P2_Set_IJPccnn_6_0,
        output wire P2_Set_IJPccnn_7_0,
        output wire P2_Set_IJPnn_0,
        output wire P2_Set_IOUTlnlA,
        output wire P2_Set_IINAlnl
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _11100011 = ~(_not_enable | notSource[5] | Source[4] | Source[3] | notSource[0]); // 7

    //
    // XPT
    //

    assign _decodedXPT[3] = ~(_not_enable | _11100011 | notXPT[0]); // 3

    //
    // decoder
    //

    wire _nott3 = _decodedXPT[3] ~| _decodedXPT[3];

    wire _not11xxx011 = (_nott3 | notSource[0]); // 2

    wire _11001011 = ~(_not11xxx011 | Source[5] | Source[4] | notSource[3]); // 5
    wire _111ee011 = _not11xxx011 ~| notSource[5];
    wire _11eee01e = ~(_nott3 | _11001011 | _111ee011); // 3

    wire _PR_Reset_XPT_1001; // <
    wire _P2_Set_CM1_1001;
    wire _Pa_Ophd_1001; // >

    DECODER_op_X1_11100011 d11100011(
        .enable(_11100011),
        .XPT(XPT),
        .notXPT(notXPT),
        .PA_Select_HL_low(PA_Select_HL_low), // <
        .PA_NOP(PA_NOP),
        .PR_Write_Dt(PR_Write_Dt),
        .PR_Write_Dtex(PR_Write_Dtex), // >
        .PC_R0(PC_R0),
        .PC_R1(PC_R1),
        .PC_R2(PC_R2),
        .PR_Write_L(PR_Write_L),
        .PR_Write_H(PR_Write_H), // <
        .PR_InvertIn(PR_InvertIn), // >
        .PC_W0(PC_W0),
        .PC_W1(PC_W1),
        .PC_W2(PC_W2),
        .PI_SelectDt_Dt(PI_SelectDt_Dt),
        .PI_SelectDt_Dtex(PI_SelectDt_Dtex),
        .PI_SelectAdt1(PI_SelectAdt1),
        .PI_SelectAd_SP(PI_SelectAd_SP),
        .PR_Reset_XPT(_PR_Reset_XPT_1001), // <
        .P2_Set_CM1(_P2_Set_CM1_1001),
        .Pa_Ophd(_Pa_Ophd_1001) // >
    );

    wire _P2_Set_CM1_0011;

    DECODER_op_X1_11001011 d11001011(
        .enable(_11001011),
        .P2_Set_CM1(_P2_Set_CM1_0011), //<
        .P2_Set_XBIT(P2_Set_XBIT) // >
    );
    
    wire _P2_Set_CM1_1ee1; // <
    wire _Pa_Ophd_1ee1; // >

    DECODER_op_X1_111ee011 d111ee011(
        .enable(_111ee011),
        .Source(Source),
        .notSource(notSource),
        .P2_Set_CM1(_P2_Set_CM1_1ee1), // <
        .Pa_Ophd(_Pa_Ophd_1ee1), // >
        .PR_Ex_DE_HL(PR_Ex_DE_HL),
        .P2_Reset_IFF1(P2_Reset_IFF1), // <
        .P2_Reset_IFF2(P2_Reset_IFF2), // >
        .P2_Set_IFF1(P2_Set_IFF1), // <
        .P2_Set_IFF2(P2_Set_IFF2) // >
    );

    DECODER_op_X1_11eee01e d11eee01e(
        .enable(_11eee01e),
        .Source(Source),
        .notSource(notSource),
        .P2_Set_CMR(P2_Set_CMR),
        .P2_Set_IJPccnn_0_0(P2_Set_IJPccnn_0_0),
        .P2_Set_IJPccnn_1_0(P2_Set_IJPccnn_1_0),
        .P2_Set_IJPccnn_2_0(P2_Set_IJPccnn_2_0),
        .P2_Set_IJPccnn_3_0(P2_Set_IJPccnn_3_0),
        .P2_Set_IJPccnn_4_0(P2_Set_IJPccnn_4_0),
        .P2_Set_IJPccnn_5_0(P2_Set_IJPccnn_5_0),
        .P2_Set_IJPccnn_6_0(P2_Set_IJPccnn_6_0),
        .P2_Set_IJPccnn_7_0(P2_Set_IJPccnn_7_0),
        .P2_Set_IJPnn_0(P2_Set_IJPnn_0),
        .P2_Set_IOUTlnlA(P2_Set_IOUTlnlA),
        .P2_Set_IINAlnl(P2_Set_IINAlnl)
    );

    assign PR_Reset_XPT = (_decodedXPT[3] | _PR_Reset_XPT_1001); // 2

    assign Pa_Ophd = (_Pa_Ophd_1001 | _Pa_Ophd_1ee1); // 2
    assign P2_Set_CM1 = (Pa_Ophd | _P2_Set_CM1_0011); // 2

endmodule