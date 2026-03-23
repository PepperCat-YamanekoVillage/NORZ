// F_Yも同じ
// (18)
module REGISTER_F_X(
        // input wire clk,
        input wire Clk,
        input wire notClk,
        input wire notALUResult5,
        input wire notShadowF_X,
        input wire PF_Write_X,
        input wire notPF_Write_X,
        input wire PR_Ex,
        input wire notPR_Ex,
        input wire PR_Write,
        input wire notPR_Write,
        output wire F_Z,
        output wire notF_Z
    );

    // wire Clk = clk;
    // wire notClk = ~clk;
    // wire notPF_Write_X = ~PF_Write_X;
    // wire notPR_Ex = ~PR_Ex;
    // wire notPR_Write = ~PR_Write;

    wire _m0;

    REGISTER_mux m0(
        .S(PF_Write_X),
        .notS(notPF_Write_X),
        .N(notF_Z),
        .P(notALUResult5),
        .Out(_m0)
    );

    wire _new_not;

    REGISTER_mux m1(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(_m0),
        .P(notShadowF_X),
        .Out(_new_not)
    );

    wire _new_not_re;

    REGISTER_mux mre(
        .S(PR_Write),
        .notS(notPR_Write),
        .N(_new_not),
        .P(notALUResult5),
        .Out(_new_not_re)
    );

    REGISTER_dff dff(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_not_re),
        .Q(F_Z),
        .notQ(notF_Z)
    );

endmodule