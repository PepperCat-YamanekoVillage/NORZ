// 18(33)
module REGISTER_F_PV(
        // input wire clk,
        input wire Clk,
        input wire notClk,
        input wire notShadowF_PV,
        input wire notALUResult2,
        input wire IFF2,
        input wire is16bitEqual,
        input wire is8bitOverflow,
        input wire notIs8bitEvenParity,
        input wire is16bitOverflow,
        input wire PF_Write_PV,
        input wire notPF_Select_PV_bit18, // IFF2 & CINT
        input wire notPF_Select_PV_bit20, // notIs16bitEqual
        input wire notPF_Select_PV_bit25, // is8bitOverflow
        input wire notPF_Select_PV_bit27, // is8bitEvenParity
        input wire notPF_Select_PV_bit33, // is16bitOverflow
        input wire PR_Ex,
        input wire notPR_Ex,
        input wire PR_Write,
        input wire notPR_Write,
        output wire F_PV,
        output wire notF_PV
    );

    // wire Clk = clk;
    // wire notClk = ~clk;
    // wire notPR_Ex = ~PR_Ex;
    // wire notPR_Write = ~PR_Write;
    // wire _notPF_Select_PV_bit18 = ~(PF_Write_PV & (~notPF_Select_PV_bit18));
    // wire _notPF_Select_PV_bit20 = ~(PF_Write_PV & (~notPF_Select_PV_bit20));
    // wire _notPF_Select_PV_bit25 = ~(PF_Write_PV & (~notPF_Select_PV_bit25));
    // wire _notPF_Select_PV_bit27 = ~(PF_Write_PV & (~notPF_Select_PV_bit27));
    // wire _notPF_Select_PV_bit33 = ~(PF_Write_PV & (~notPF_Select_PV_bit33));

    wire _notPF_Select_PV_bit18 = notPF_Select_PV_bit18;
    wire _notPF_Select_PV_bit20 = notPF_Select_PV_bit20;
    wire _notPF_Select_PV_bit25 = notPF_Select_PV_bit25;
    wire _notPF_Select_PV_bit27 = notPF_Select_PV_bit27;
    wire _notPF_Select_PV_bit33 = notPF_Select_PV_bit33;

    wire _notIs8bitOverflow = is8bitOverflow ~| is8bitOverflow;
    wire _notIs16bitOverflow = is16bitOverflow ~| is16bitOverflow;

    wire _notIFF2 = IFF2 ~| IFF2;

    // and

    wire _new_PV = notF_PV ~| PF_Write_PV;
    wire _new_IFF2CINT = _notIFF2 ~| _notPF_Select_PV_bit18;
    wire _new_is16bitEqual = is16bitEqual ~| _notPF_Select_PV_bit20;
    wire _new_is8bitOverflow = _notIs8bitOverflow ~| _notPF_Select_PV_bit25;
    wire _new_is8bitEvenParity = notIs8bitEvenParity ~| _notPF_Select_PV_bit27;
    wire _new_is16bitOverflow = _notIs16bitOverflow ~| _notPF_Select_PV_bit33;

    // or

    wire _new_not0 = _new_PV ~| _new_IFF2CINT;
    wire _new_0 = _new_not0 ~| _new_not0;
    wire _new_not1 = _new_is16bitEqual ~| _new_is8bitOverflow;
    wire _new_1 = _new_not1 ~| _new_not1;
    wire _new_not2 = _new_is8bitEvenParity ~| _new_is16bitOverflow;
    wire _new_2 = _new_not2 ~| _new_not2;

    wire _new_not3 = _new_0 ~| _new_1;
    wire _new_3 = _new_not3 ~| _new_not3;

    wire _new_not4 = _new_2 ~| _new_3;

    wire _new_not;

    REGISTER_mux m(
        .S(PR_Ex),
        .notS(notPR_Ex),
        .N(_new_not4),
        .P(notShadowF_PV),
        .Out(_new_not)
    );

    wire _new_not_re;

    REGISTER_mux mre(
        .S(PR_Write),
        .notS(notPR_Write),
        .N(_new_not),
        .P(notALUResult2),
        .Out(_new_not_re)
    );

    REGISTER_dff dff(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_not_re),
        .Q(F_PV),
        .notQ(notF_PV)
    );

endmodule