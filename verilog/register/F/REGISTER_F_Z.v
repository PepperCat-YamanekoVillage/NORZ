// 45(60)
module REGISTER_F_Z(
        // input wire clk,
        input wire Clk,
        input wire notClk,
        input wire [7:0] notALUResult,
        input wire notShadowF_Z,
        input wire notIs8bitEqual,
        input wire notCY4,
        input wire notIsResultLow0,
        input wire isResult0,
        input wire PF_Write_Z,
        input wire notPF_Select_Z_bit19, // is8bitEqual
        input wire notPF_Select_Z_bit21, // CY4
        input wire notPF_Select_Z_bit24, // isResultLow0
        input wire notPF_Select_Z_bit34, // isResult0
        input wire notPF_Select_Z_bit40, // notALU0
        input wire notPF_Select_Z_bit41, // notALU1
        input wire notPF_Select_Z_bit42, // notALU2
        input wire notPF_Select_Z_bit43, // notALU3
        input wire notPF_Select_Z_bit44, // notALU4
        input wire notPF_Select_Z_bit45, // notALU5
        input wire notPF_Select_Z_bit46, // notALU6
        input wire notPF_Select_Z_bit47, // notALU7
        input wire PR_Ex,
        input wire notPR_Ex,
        input wire PR_Write,
        input wire notPR_Write,
        output wire F_Z,
        output wire notF_Z
    );

    // wire Clk = clk;
    // wire notClk = ~clk;
    // wire notPR_Ex = ~PR_Ex;
    // wire notPR_Write = ~PR_Write;
    // wire _notPF_Select_Z_bit19 = ~(PF_Write_Z & (~notPF_Select_Z_bit19));
    // wire _notPF_Select_Z_bit21 = ~(PF_Write_Z & (~notPF_Select_Z_bit21));
    // wire _notPF_Select_Z_bit24 = ~(PF_Write_Z & (~notPF_Select_Z_bit24));
    // wire _notPF_Select_Z_bit34 = ~(PF_Write_Z & (~notPF_Select_Z_bit34));
    // wire _notPF_Select_Z_bit40 = ~(PF_Write_Z & (~notPF_Select_Z_bit40));
    // wire _notPF_Select_Z_bit41 = ~(PF_Write_Z & (~notPF_Select_Z_bit41));
    // wire _notPF_Select_Z_bit42 = ~(PF_Write_Z & (~notPF_Select_Z_bit42));
    // wire _notPF_Select_Z_bit43 = ~(PF_Write_Z & (~notPF_Select_Z_bit43));
    // wire _notPF_Select_Z_bit44 = ~(PF_Write_Z & (~notPF_Select_Z_bit44));
    // wire _notPF_Select_Z_bit45 = ~(PF_Write_Z & (~notPF_Select_Z_bit45));
    // wire _notPF_Select_Z_bit46 = ~(PF_Write_Z & (~notPF_Select_Z_bit46));
    // wire _notPF_Select_Z_bit47 = ~(PF_Write_Z & (~notPF_Select_Z_bit47));
    wire _notPF_Select_Z_bit19 = notPF_Select_Z_bit19;
    wire _notPF_Select_Z_bit21 = notPF_Select_Z_bit21;
    wire _notPF_Select_Z_bit24 = notPF_Select_Z_bit24;
    wire _notPF_Select_Z_bit34 = notPF_Select_Z_bit34;
    wire _notPF_Select_Z_bit40 = notPF_Select_Z_bit40;
    wire _notPF_Select_Z_bit41 = notPF_Select_Z_bit41;
    wire _notPF_Select_Z_bit42 = notPF_Select_Z_bit42;
    wire _notPF_Select_Z_bit43 = notPF_Select_Z_bit43;
    wire _notPF_Select_Z_bit44 = notPF_Select_Z_bit44;
    wire _notPF_Select_Z_bit45 = notPF_Select_Z_bit45;
    wire _notPF_Select_Z_bit46 = notPF_Select_Z_bit46;
    wire _notPF_Select_Z_bit47 = notPF_Select_Z_bit47;

    wire _notIsResult0 = isResult0 ~| isResult0;

    wire _ALUResult0 = notALUResult[0] ~| notALUResult[0];
    wire _ALUResult1 = notALUResult[1] ~| notALUResult[1];
    wire _ALUResult2 = notALUResult[2] ~| notALUResult[2];
    wire _ALUResult3 = notALUResult[3] ~| notALUResult[3];
    wire _ALUResult4 = notALUResult[4] ~| notALUResult[4];
    wire _ALUResult5 = notALUResult[5] ~| notALUResult[5];
    wire _ALUResult6 = notALUResult[6] ~| notALUResult[6];
    wire _ALUResult7 = notALUResult[7] ~| notALUResult[7];

    // and

    wire _new_Z = notF_Z ~| PF_Write_Z;
    wire _new_is8bitEqual = notIs8bitEqual ~| _notPF_Select_Z_bit19;
    wire _new_CY4 = notCY4 ~| _notPF_Select_Z_bit21;
    wire _new_isResultLow0 = notIsResultLow0 ~| _notPF_Select_Z_bit24;
    wire _new_isResult0 = _notIsResult0 ~| _notPF_Select_Z_bit34;
    wire _new_ALU0 = _ALUResult0 ~| _notPF_Select_Z_bit40;
    wire _new_ALU1 = _ALUResult1 ~| _notPF_Select_Z_bit41;
    wire _new_ALU2 = _ALUResult2 ~| _notPF_Select_Z_bit42;
    wire _new_ALU3 = _ALUResult3 ~| _notPF_Select_Z_bit43;
    wire _new_ALU4 = _ALUResult4 ~| _notPF_Select_Z_bit44;
    wire _new_ALU5 = _ALUResult5 ~| _notPF_Select_Z_bit45;
    wire _new_ALU6 = _ALUResult6 ~| _notPF_Select_Z_bit46;
    wire _new_ALU7 = _ALUResult7 ~| _notPF_Select_Z_bit47;

    // or

    wire _not_new0 = _new_Z ~| _new_is8bitEqual;
    wire _new0 = _not_new0 ~| _not_new0;
    wire _not_new1 = _new_CY4 ~| _new_isResultLow0;
    wire _new1 = _not_new1 ~| _not_new1;
    wire _not_new2 = _new_isResult0 ~| _new_ALU0;
    wire _new2 = _not_new2 ~| _not_new2;
    wire _not_new3 = _new_ALU1 ~| _new_ALU2;
    wire _new3 = _not_new3 ~| _not_new3;
    wire _not_new4 = _new_ALU3 ~| _new_ALU4;
    wire _new4 = _not_new4 ~| _not_new4;
    wire _not_new5 = _new_ALU5 ~| _new_ALU6;
    wire _new5 = _not_new5 ~| _not_new5;

    wire _not_new6 = _new_ALU7 ~| _new0;
    wire _new6 = _not_new6 ~| _not_new6;
    wire _not_new7 = _new1 ~| _new2;
    wire _new7 = _not_new7 ~| _not_new7;
    wire _not_new8 = _new3 ~| _new4;
    wire _new8 = _not_new8 ~| _not_new8;

    wire _not_new9 = _new5 ~| _new6;
    wire _new9 = _not_new9 ~| _not_new9;
    wire _not_new10 = _new7 ~| _new8;
    wire _new10 = _not_new10 ~| _not_new10;

    wire _not_new_11 = _new9 ~| _new10;

    wire _new_not;

    REGISTER_mux m(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(_not_new_11),
        .P(notShadowF_Z),
        .Out(_new_not)
    );

    wire _new_not_re;

    REGISTER_mux mre(
        .S(PR_Write),
        .notS(notPR_Write),
        .N(_new_not),
        .P(notALUResult[6]),
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