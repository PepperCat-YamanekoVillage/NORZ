// B/Cも同じ
// 1(121)
module REGISTER_A(
        input wire Clk,
        input wire notClk,
        input wire [7:0] notALUResult,
        input wire [7:0] notShadowA,
        input wire PR_Write,
        input wire PR_Ex,
        input wire notPR_Ex,
        output wire [7:0] A,
        output wire [7:0] notA
    );

    // wire notClk = ~Clk;
    // wire notPR_Ex = ~PR_Ex;

    wire _notPR_Write = PR_Write ~| PR_Write;

    wire _m0;
    wire _m1;
    wire _m2;
    wire _m3;
    wire _m4;
    wire _m5;
    wire _m6;
    wire _m7;
    wire _newNotA0;
    wire _newNotA1;
    wire _newNotA2;
    wire _newNotA3;
    wire _newNotA4;
    wire _newNotA5;
    wire _newNotA6;
    wire _newNotA7;

    REGISTER_mux m0_1(
        .S(PR_Write),
        .notS(_notPR_Write),
        .N(notA[0]),
        .P(notALUResult[0]),
        .Out(_m0)
    );

    REGISTER_mux m0_2(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(_m0),
        .P(notShadowA[0]),
        .Out(_newNotA0)
    );

    REGISTER_mux m1_1(
        .S(PR_Write),
        .notS(_notPR_Write),
        .N(notA[1]),
        .P(notALUResult[1]),
        .Out(_m1)
    );

    REGISTER_mux m1_2(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(_m1),
        .P(notShadowA[1]),
        .Out(_newNotA1)
    );

    REGISTER_mux m2_1(
        .S(PR_Write),
        .notS(_notPR_Write),
        .N(notA[2]),
        .P(notALUResult[2]),
        .Out(_m2)
    );

    REGISTER_mux m2_2(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(_m2),
        .P(notShadowA[2]),
        .Out(_newNotA2)
    );

    REGISTER_mux m3_1(
        .S(PR_Write),
        .notS(_notPR_Write),
        .N(notA[3]),
        .P(notALUResult[3]),
        .Out(_m3)
    );

    REGISTER_mux m3_2(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(_m3),
        .P(notShadowA[3]),
        .Out(_newNotA3)
    );

    REGISTER_mux m4_1(
        .S(PR_Write),
        .notS(_notPR_Write),
        .N(notA[4]),
        .P(notALUResult[4]),
        .Out(_m4)
    );

    REGISTER_mux m4_2(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(_m4),
        .P(notShadowA[4]),
        .Out(_newNotA4)
    );

    REGISTER_mux m5_1(
        .S(PR_Write),
        .notS(_notPR_Write),
        .N(notA[5]),
        .P(notALUResult[5]),
        .Out(_m5)
    );

    REGISTER_mux m5_2(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(_m5),
        .P(notShadowA[5]),
        .Out(_newNotA5)
    );

    REGISTER_mux m6_1(
        .S(PR_Write),
        .notS(_notPR_Write),
        .N(notA[6]),
        .P(notALUResult[6]),
        .Out(_m6)
    );

    REGISTER_mux m6_2(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(_m6),
        .P(notShadowA[6]),
        .Out(_newNotA6)
    );

    REGISTER_mux m7_1(
        .S(PR_Write),
        .notS(_notPR_Write),
        .N(notA[7]),
        .P(notALUResult[7]),
        .Out(_m7)
    );

    REGISTER_mux m7_2(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(_m7),
        .P(notShadowA[7]),
        .Out(_newNotA7)
    );

    REGISTER_dff A0(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_newNotA0),
        .Q(A[0]),
        .notQ(notA[0])
    );

    REGISTER_dff A1(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_newNotA1),
        .Q(A[1]),
        .notQ(notA[1])
    );

    REGISTER_dff A2(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_newNotA2),
        .Q(A[2]),
        .notQ(notA[2])
    );

    REGISTER_dff A3(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_newNotA3),
        .Q(A[3]),
        .notQ(notA[3])
    );

    REGISTER_dff A4(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_newNotA4),
        .Q(A[4]),
        .notQ(notA[4])
    );

    REGISTER_dff A5(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_newNotA5),
        .Q(A[5]),
        .notQ(notA[5])
    );

    REGISTER_dff A6(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_newNotA6),
        .Q(A[6]),
        .notQ(notA[6])
    );

    REGISTER_dff A7(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_newNotA7),
        .Q(A[7]),
        .notQ(notA[7])
    );

endmodule