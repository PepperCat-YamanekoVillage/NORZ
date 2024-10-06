// 9(24)
module REGISTER_F_S(
        // input wire clk,
        input wire Clk,
        input wire notClk,
        input wire notALUResult7,
        input wire notALUResult15,
        input wire notShadowF_S,
        input wire notCY8,
        input wire PF_Write_S,
        input wire notPF_Select_S_bit7,
        input wire notPF_Select_S_bit15,
        input wire notPF_Select_S_bit23, //CY8
        input wire PR_Ex,
        input wire notPR_Ex,
        input wire PR_Write,
        input wire notPR_Write,
        output wire F_S,
        output wire notF_S
    );

    // wire Clk = clk;
    // wire notClk = ~clk;
    // wire notPR_Ex = ~PR_Ex;
    // wire notPR_Write = ~PR_Write;
    // wire _notPF_Select_S_bit7 = ~(PF_Write_S & (~notPF_Select_S_bit7));
    // wire _notPF_Select_S_bit15 = ~(PF_Write_S & (~notPF_Select_S_bit15));
    // wire _notPF_Select_S_bit23 = ~(PF_Write_S & (~notPF_Select_S_bit23));
    wire _notPF_Select_S_bit7 = notPF_Select_S_bit7;
    wire _notPF_Select_S_bit15 = notPF_Select_S_bit15;
    wire _notPF_Select_S_bit23 = notPF_Select_S_bit23;

    // and

    wire _new_S = notF_S ~| PF_Write_S;
    wire _new_ALU7 = notALUResult7 ~| _notPF_Select_S_bit7;
    wire _new_ALU15 = notALUResult15 ~| _notPF_Select_S_bit15;
    wire _new_CY8 = notCY8 ~| _notPF_Select_S_bit23;

    // or

    wire _new_not0 = _new_S ~| _new_ALU7;
    wire _new_0 = _new_not0 ~| _new_not0;
    wire _new_not1 = _new_ALU15 ~| _new_CY8;
    wire _new_1 = _new_not1 ~| _new_not1;
    wire _new_not2 = _new_0 ~| _new_1;

    wire _new_not;

    REGISTER_mux m(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(_new_not2),
        .P(notShadowF_S),
        .Out(_new_not)
    );

    wire _new_not_re;

    REGISTER_mux mre(
        .S(PR_Write),
        .notS(notPR_Write),
        .N(_new_not),
        .P(notALUResult7),
        .Out(_new_not_re)
    );

    REGISTER_dff dff(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_not_re),
        .Q(F_S),
        .notQ(notF_S)
    );

endmodule