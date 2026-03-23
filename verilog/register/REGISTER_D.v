// E/H/Lも同じ
// 1(145)
module REGISTER_D(
        // input wire clk,
        input wire Clk,
        input wire notClk,
        input wire [7:0] notALUResult,
        input wire [7:0] notShadowD,
        input wire [7:0] notH,
        input wire PR_Write,
        input wire PR_Ex,
        input wire notPR_Ex,
        input wire PR_Exx,
        input wire notPR_Exx,
        output wire [7:0] D,
        output wire [7:0] notD
    );

    // wire Clk = clk;
    // wire notClk = ~clk;
    // wire notPR_Ex = ~PR_Ex;
    // wire notPR_Exx = ~PR_Exx;

    wire _notPR_Write = PR_Write ~| PR_Write;

    wire _m0_1;
    wire _m0_2;
    wire _m1_1;
    wire _m1_2;
    wire _m2_1;
    wire _m2_2;
    wire _m3_1;
    wire _m3_2;
    wire _m4_1;
    wire _m4_2;
    wire _m5_1;
    wire _m5_2;
    wire _m6_1;
    wire _m6_2;
    wire _m7_1;
    wire _m7_2;
    wire _new_notD0;
    wire _new_notD1;
    wire _new_notD2;
    wire _new_notD3;
    wire _new_notD4;
    wire _new_notD5;
    wire _new_notD6;
    wire _new_notD7;

    REGISTER_mux m0_1(
        .S(PR_Write),
        .notS(_notPR_Write),
        .N(notD[0]),
        .P(notALUResult[0]),
        .Out(_m0_1)
    );

    REGISTER_mux m0_2(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(_m0_1),
        .P(notH[0]),
        .Out(_m0_2)
    );

    REGISTER_mux m0_3(
        .S(PR_Exx),
        .notS(notPR_Exx),
        .N(_m0_2),
        .P(notShadowD[0]),
        .Out(_new_notD0)
    );

    REGISTER_mux m1_1(
        .S(PR_Write),
        .notS(_notPR_Write),
        .N(notD[1]),
        .P(notALUResult[1]),
        .Out(_m1_1)
    );

    REGISTER_mux m1_2(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(_m1_1),
        .P(notH[1]),
        .Out(_m1_2)
    );

    REGISTER_mux m1_3(
        .S(PR_Exx),
        .notS(notPR_Exx),
        .N(_m1_2),
        .P(notShadowD[1]),
        .Out(_new_notD1)
    );

    REGISTER_mux m2_1(
        .S(PR_Write),
        .notS(_notPR_Write),
        .N(notD[2]),
        .P(notALUResult[2]),
        .Out(_m2_1)
    );

    REGISTER_mux m2_2(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(_m2_1),
        .P(notH[2]),
        .Out(_m2_2)
    );

    REGISTER_mux m2_3(
        .S(PR_Exx),
        .notS(notPR_Exx),
        .N(_m2_2),
        .P(notShadowD[2]),
        .Out(_new_notD2)
    );

    REGISTER_mux m3_1(
        .S(PR_Write),
        .notS(_notPR_Write),
        .N(notD[3]),
        .P(notALUResult[3]),
        .Out(_m3_1)
    );

    REGISTER_mux m3_2(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(_m3_1),
        .P(notH[3]),
        .Out(_m3_2)
    );

    REGISTER_mux m3_3(
        .S(PR_Exx),
        .notS(notPR_Exx),
        .N(_m3_2),
        .P(notShadowD[3]),
        .Out(_new_notD3)
    );

    REGISTER_mux m4_1(
        .S(PR_Write),
        .notS(_notPR_Write),
        .N(notD[4]),
        .P(notALUResult[4]),
        .Out(_m4_1)
    );

    REGISTER_mux m4_2(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(_m4_1),
        .P(notH[4]),
        .Out(_m4_2)
    );

    REGISTER_mux m4_3(
        .S(PR_Exx),
        .notS(notPR_Exx),
        .N(_m4_2),
        .P(notShadowD[4]),
        .Out(_new_notD4)
    );

    REGISTER_mux m5_1(
        .S(PR_Write),
        .notS(_notPR_Write),
        .N(notD[5]),
        .P(notALUResult[5]),
        .Out(_m5_1)
    );

    REGISTER_mux m5_2(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(_m5_1),
        .P(notH[5]),
        .Out(_m5_2)
    );

    REGISTER_mux m5_3(
        .S(PR_Exx),
        .notS(notPR_Exx),
        .N(_m5_2),
        .P(notShadowD[5]),
        .Out(_new_notD5)
    );

    REGISTER_mux m6_1(
        .S(PR_Write),
        .notS(_notPR_Write),
        .N(notD[6]),
        .P(notALUResult[6]),
        .Out(_m6_1)
    );

    REGISTER_mux m6_2(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(_m6_1),
        .P(notH[6]),
        .Out(_m6_2)
    );

    REGISTER_mux m6_3(
        .S(PR_Exx),
        .notS(notPR_Exx),
        .N(_m6_2),
        .P(notShadowD[6]),
        .Out(_new_notD6)
    );

    REGISTER_mux m7_1(
        .S(PR_Write),
        .notS(_notPR_Write),
        .N(notD[7]),
        .P(notALUResult[7]),
        .Out(_m7_1)
    );

    REGISTER_mux m7_2(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(_m7_1),
        .P(notH[7]),
        .Out(_m7_2)
    );

    REGISTER_mux m7_3(
        .S(PR_Exx),
        .notS(notPR_Exx),
        .N(_m7_2),
        .P(notShadowD[7]),
        .Out(_new_notD7)
    );

    REGISTER_dff D0(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notD0),
        .Q(D[0]),
        .notQ(notD[0])
    );

    REGISTER_dff D1(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notD1),
        .Q(D[1]),
        .notQ(notD[1])
    );

    REGISTER_dff D2(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notD2),
        .Q(D[2]),
        .notQ(notD[2])
    );

    REGISTER_dff D3(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notD3),
        .Q(D[3]),
        .notQ(notD[3])
    );

    REGISTER_dff D4(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notD4),
        .Q(D[4]),
        .notQ(notD[4])
    );

    REGISTER_dff D5(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notD5),
        .Q(D[5]),
        .notQ(notD[5])
    );

    REGISTER_dff D6(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notD6),
        .Q(D[6]),
        .notQ(notD[6])
    );

    REGISTER_dff D7(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notD7),
        .Q(D[7]),
        .notQ(notD[7])
    );

endmodule