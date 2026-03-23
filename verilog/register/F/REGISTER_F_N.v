// 2(17)
module REGISTER_F_N(
        // input wire clk,
        input wire Clk,
        input wire notClk,
        input wire notShadowF_N,
        input wire notALUResult1,
        input wire PF_Write_N,
        input wire PF_Select_N_bit17, // 1
        input wire PR_Ex,
        input wire notPR_Ex,
        input wire PR_Write,
        input wire notPR_Write,
        output wire F_N,
        output wire notF_N
    );

    // wire Clk = clk;
    // wire notClk = ~clk;
    // wire notPR_Ex = ~PR_Ex;
    // wire notPR_Write = ~PR_Write;
    // wire _PF_Select_N_bit17 = PF_Write_N & PF_Select_N_bit17;

    wire _PF_Select_N_bit17 = PF_Select_N_bit17;

    // and

    wire _new_N = notF_N ~| PF_Write_N;

    // or

    wire _new_not0 = _new_N ~| _PF_Select_N_bit17;

    wire _new_not;

    REGISTER_mux m(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(_new_not0),
        .P(notShadowF_N),
        .Out(_new_not)
    );

    wire _new_not_re;

    REGISTER_mux mre(
        .S(PR_Write),
        .notS(notPR_Write),
        .N(_new_not),
        .P(notALUResult1),
        .Out(_new_not_re)
    );

    REGISTER_dff dff(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_not_re),
        .Q(F_N),
        .notQ(notF_N)
    );

endmodule