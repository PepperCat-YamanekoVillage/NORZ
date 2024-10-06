// 27(42)
module REGISTER_F_C(
        // input wire clk,
        input wire Clk,
        input wire notClk,
        input wire notShadowF_C,
        input wire notALUResult0,
        input wire notCY8,
        input wire CY16,
        input wire notFlag_S,
        input wire notALULow0,
        input wire notALULow7,
        input wire PF_Write_C,
        input wire PF_Select_C_bit17, // 1
        input wire notPF_Select_C_bit23, // CY8
        input wire notPF_Select_C_bit26, // notCY8
        input wire notPF_Select_C_bit29, // Flag_S
        input wire notPF_Select_C_bit32, // CY16
        input wire notPF_Select_C_bit36, // notCY16
        input wire notPF_Select_C_bit37, // inputLow0
        input wire notPF_Select_C_bit38, // inputLow7
        input wire PF_Select_C_bit0,
        input wire PR_Ex,
        input wire notPR_Ex,
        input wire PR_Write,
        output wire F_C,
        output wire notF_C
    );

    // wire Clk = clk;
    // wire notClk = ~clk;
    // wire notPR_Ex = ~PR_Ex;
    // wire _PF_Select_C_bit17 = PF_Write_C & PF_Select_C_bit17;
    // wire _notPF_Select_C_bit23 = ~(PF_Write_C & (~notPF_Select_C_bit23));
    // wire _notPF_Select_C_bit26 = ~(PF_Write_C & (~notPF_Select_C_bit26));
    // wire _notPF_Select_C_bit29 = ~(PF_Write_C & (~notPF_Select_C_bit29));
    // wire _notPF_Select_C_bit32 = ~(PF_Write_C & (~notPF_Select_C_bit32));
    // wire _notPF_Select_C_bit36 = ~(PF_Write_C & (~notPF_Select_C_bit36));
    // wire _notPF_Select_C_bit37 = ~(PF_Write_C & (~notPF_Select_C_bit37));
    // wire _notPF_Select_C_bit38 = ~(PF_Write_C & (~notPF_Select_C_bit38));
    // wire _PF_Select_C_bit0 = PF_Write_C & PF_Select_C_bit0;

    wire _PF_Select_C_bit17 = PF_Select_C_bit17;
    wire _notPF_Select_C_bit23 = notPF_Select_C_bit23;
    wire _notPF_Select_C_bit26 = notPF_Select_C_bit26;
    wire _notPF_Select_C_bit29 = notPF_Select_C_bit29;
    wire _notPF_Select_C_bit32 = notPF_Select_C_bit32;
    wire _notPF_Select_C_bit36 = notPF_Select_C_bit36;
    wire _notPF_Select_C_bit37 = notPF_Select_C_bit37;
    wire _notPF_Select_C_bit38 = notPF_Select_C_bit38;
    wire _PF_Select_C_bit0 = PF_Select_C_bit0;

    wire _CY8 = notCY8 ~| notCY8;
    wire _notCY16 = CY16 ~| CY16;

    // and

    wire _new_C = notF_C ~| PF_Write_C;
    wire _new_CY8 = notCY8 ~| _notPF_Select_C_bit23;
    wire _new_notCY8 = _CY8 ~| _notPF_Select_C_bit26;
    wire _new_Flag_S = notFlag_S ~| _notPF_Select_C_bit29;
    wire _new_CY16 = _notCY16 ~| _notPF_Select_C_bit32;
    wire _new_notCY16 = CY16 ~| _notPF_Select_C_bit36;
    wire _new_Low0 = notALULow0 ~| _notPF_Select_C_bit37;
    wire _new_Low7 = notALULow7 ~| _notPF_Select_C_bit38;

    // or

    wire _new_not0 = _new_C ~| _new_CY8;
    wire _new_0 = _new_not0 ~| _new_not0;
    wire _new_not1 = _new_notCY8 ~| _new_Flag_S;
    wire _new_1 = _new_not1 ~| _new_not1;
    wire _new_not2 = _new_CY16 ~| _new_notCY16;
    wire _new_2 = _new_not2 ~| _new_not2;
    wire _new_not3 = _new_Low0 ~| _new_Low7;
    wire _new_3 = _new_not3 ~| _new_not3;

    wire _new_not4 = _PF_Select_C_bit17 ~| _new_0;
    wire _new_4 = _new_not4 ~| _new_not4;
    wire _new_not5 = _new_1 ~| _new_2;
    wire _new_5 = _new_not5 ~| _new_not5;

    wire _new_not6 = _new_4 ~| _new_3;
    wire _new_6 = _new_not6 ~| _new_not6;

    wire _new_not7 = _new_5 ~| _new_6;

    wire _new_not;

    REGISTER_mux m(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(_new_not7),
        .P(notShadowF_C),
        .Out(_new_not)
    );

    wire _new_not_re;

    wire _not_writeALU0 = PR_Write ~| _PF_Select_C_bit0;
    wire _writeALU0 = _not_writeALU0 ~| _not_writeALU0;

    REGISTER_mux mre(
        .S(_writeALU0),
        .notS(_not_writeALU0),
        .N(_new_not),
        .P(notALUResult0),
        .Out(_new_not_re)
    );

    REGISTER_dff dff(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_not_re),
        .Q(F_C),
        .notQ(notF_C)
    );

endmodule