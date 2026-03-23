// (96)
module REGISTER_shadow(
        input wire Clk,
        input wire notClk,
        input wire [7:0] notA,
        input wire PR_Ex,
        input wire notPR_Ex,
        output wire [7:0] ShadowA,
        output wire [7:0] notShadowA
    );

    // wire notClk = ~Clk;
    // wire notPR_Ex = ~PR_Ex;

    wire _new_not0;
    wire _new_not1;
    wire _new_not2;
    wire _new_not3;
    wire _new_not4;
    wire _new_not5;
    wire _new_not6;
    wire _new_not7;

    REGISTER_mux m0(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(notShadowA[0]),
        .P(notA[0]),
        .Out(_new_not0)
    );

    REGISTER_mux m1(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(notShadowA[1]),
        .P(notA[1]),
        .Out(_new_not1)
    );

    REGISTER_mux m2(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(notShadowA[2]),
        .P(notA[2]),
        .Out(_new_not2)
    );

    REGISTER_mux m3(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(notShadowA[3]),
        .P(notA[3]),
        .Out(_new_not3)
    );

    REGISTER_mux m4(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(notShadowA[4]),
        .P(notA[4]),
        .Out(_new_not4)
    );

    REGISTER_mux m5(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(notShadowA[5]),
        .P(notA[5]),
        .Out(_new_not5)
    );

    REGISTER_mux m6(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(notShadowA[6]),
        .P(notA[6]),
        .Out(_new_not6)
    );

    REGISTER_mux m7(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(notShadowA[7]),
        .P(notA[7]),
        .Out(_new_not7)
    );

    REGISTER_dff s0(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_not0),
        .Q(ShadowA[0]),
        .notQ(notShadowA[0])
    );

    REGISTER_dff s1(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_not1),
        .Q(ShadowA[1]),
        .notQ(notShadowA[1])
    );

    REGISTER_dff s2(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_not2),
        .Q(ShadowA[2]),
        .notQ(notShadowA[2])
    );

    REGISTER_dff s3(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_not3),
        .Q(ShadowA[3]),
        .notQ(notShadowA[3])
    );

    REGISTER_dff s4(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_not4),
        .Q(ShadowA[4]),
        .notQ(notShadowA[4])
    );

    REGISTER_dff s5(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_not5),
        .Q(ShadowA[5]),
        .notQ(notShadowA[5])
    );

    REGISTER_dff s6(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_not6),
        .Q(ShadowA[6]),
        .notQ(notShadowA[6])
    );

    REGISTER_dff s7(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_not7),
        .Q(ShadowA[7]),
        .notQ(notShadowA[7])
    );

endmodule