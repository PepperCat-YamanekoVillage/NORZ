// 23(38)
module REGISTER_F_H(
        // input wire clk,
        input wire Clk,
        input wire notClk,
        input wire notShadowF_H,
        input wire notALUResult4,
        input wire notCY4,
        input wire CY12,
        input wire DAA_Flag_H,
        input wire notFlag_C,
        input wire PF_Write_H,
        input wire PF_Select_H_bit17, // 1
        input wire notPF_Select_H_bit21, // CY4
        input wire notPF_Select_H_bit22, // notCY4
        input wire notPF_Select_H_bit28, // DAA_Flag_H
        input wire notPF_Select_H_bit30, // Flag_C
        input wire notPF_Select_H_bit31, // CY12
        input wire notPF_Select_H_bit35, // notCY12
        input wire PR_Ex,
        input wire notPR_Ex,
        input wire PR_Write,
        input wire notPR_Write,
        output wire F_H,
        output wire notF_H
    );

    // wire Clk = clk;
    // wire notClk = ~clk;
    // wire notPR_Ex = ~PR_Ex;
    // wire notPR_Write = ~PR_Write;
    // wire _PF_Select_H_bit17 = PF_Write_H & PF_Select_H_bit17;
    // wire _notPF_Select_H_bit21 = ~(PF_Write_H & (~notPF_Select_H_bit21));
    // wire _notPF_Select_H_bit22 = ~(PF_Write_H & (~notPF_Select_H_bit22));
    // wire _notPF_Select_H_bit28 = ~(PF_Write_H & (~notPF_Select_H_bit28));
    // wire _notPF_Select_H_bit30 = ~(PF_Write_H & (~notPF_Select_H_bit30));
    // wire _notPF_Select_H_bit31 = ~(PF_Write_H & (~notPF_Select_H_bit31));
    // wire _notPF_Select_H_bit35 = ~(PF_Write_H & (~notPF_Select_H_bit35));

    wire _PF_Select_H_bit17 = PF_Select_H_bit17;
    wire _notPF_Select_H_bit21 = notPF_Select_H_bit21;
    wire _notPF_Select_H_bit22 = notPF_Select_H_bit22;
    wire _notPF_Select_H_bit28 = notPF_Select_H_bit28;
    wire _notPF_Select_H_bit30 = notPF_Select_H_bit30;
    wire _notPF_Select_H_bit31 = notPF_Select_H_bit31;
    wire _notPF_Select_H_bit35 = notPF_Select_H_bit35;

    wire _CY4 = notCY4 ~| notCY4;
    wire _notCY12 = CY12 ~| CY12;
    wire _notDAA_Flag_H = DAA_Flag_H ~| DAA_Flag_H;

    // and

    wire _new_H = notF_H ~| PF_Write_H;
    wire _new_CY4 = notCY4 ~| _notPF_Select_H_bit21;
    wire _new_notCY4 = _CY4 ~| _notPF_Select_H_bit22;
    wire _new_DAA_Flag_H = _notDAA_Flag_H ~| _notPF_Select_H_bit28;
    wire _new_Flag_C = notFlag_C ~| _notPF_Select_H_bit30;
    wire _new_CY12 = _notCY12 ~| _notPF_Select_H_bit31;
    wire _new_notCY12 = CY12 ~| _notPF_Select_H_bit35;

    // or

    wire _new_not0 = _PF_Select_H_bit17 ~| _new_H;
    wire _new_0 = _new_not0 ~| _new_not0;
    wire _new_not1 = _new_CY4 ~| _new_notCY4;
    wire _new_1 = _new_not1 ~| _new_not1;
    wire _new_not2 = _new_DAA_Flag_H ~| _new_Flag_C;
    wire _new_2 = _new_not2 ~| _new_not2;
    wire _new_not3 = _new_CY12 ~| _new_notCY12;
    wire _new_3 = _new_not3 ~| _new_not3;

    wire _new_not4 = _new_0 ~| _new_1;
    wire _new_4 = _new_not4 ~| _new_not4;
    wire _new_not5 = _new_2 ~| _new_3;
    wire _new_5 = _new_not5 ~| _new_not5;

    wire _new_not6 = _new_4 ~| _new_5;

    wire _new_not;

    REGISTER_mux m(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(_new_not6),
        .P(notShadowF_H),
        .Out(_new_not)
    );

    wire _new_not_re;

    REGISTER_mux mre(
        .S(PR_Write),
        .notS(notPR_Write),
        .N(_new_not),
        .P(notALUResult4),
        .Out(_new_not_re)
    );

    REGISTER_dff dff(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_not_re),
        .Q(F_H),
        .notQ(notF_H)
    );

endmodule