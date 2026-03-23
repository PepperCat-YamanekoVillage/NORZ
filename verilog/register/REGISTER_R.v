// 8(132)
module REGISTER_R(
        // input wire clk,
        input wire Clk,
        input wire notClk,
        input wire [7:0] notALUResult,
        input wire PR_Write_R,
        input wire PR_Inc_R,
        output wire [7:0] R,
        output wire [7:0] notR
    );

    // wire Clk = clk;
    // wire notClk = ~clk;

    wire _notPR_Write_R = PR_Write_R ~| PR_Write_R;

    //
    // inc
    //

    wire [6:0] _Inc;

    REGISTER_7bit_inc Inc(
        .In(R[6:0]),
        .notIn(notR[6:0]),
        .CY(PR_Inc_R),
        .Out(_Inc)
    );

    wire _notInc0 = _Inc[0] ~| _Inc[0];
    wire _notInc1 = _Inc[1] ~| _Inc[1];
    wire _notInc2 = _Inc[2] ~| _Inc[2];
    wire _notInc3 = _Inc[3] ~| _Inc[3];
    wire _notInc4 = _Inc[4] ~| _Inc[4];
    wire _notInc5 = _Inc[5] ~| _Inc[5];
    wire _notInc6 = _Inc[6] ~| _Inc[6];
    wire _notInc7 = notR[7];
    wire _new_notR0;
    wire _new_notR1;
    wire _new_notR2;
    wire _new_notR3;
    wire _new_notR4;
    wire _new_notR5;
    wire _new_notR6;
    wire _new_notR7;

    REGISTER_mux m0(
        .S(PR_Write_R),
        .notS(_notPR_Write_R),
        .N(_notInc0),
        .P(notALUResult[0]),
        .Out(_new_notR0)
    );

    REGISTER_mux m1(
        .S(PR_Write_R),
        .notS(_notPR_Write_R),
        .N(_notInc1),
        .P(notALUResult[1]),
        .Out(_new_notR1)
    );

    REGISTER_mux m2(
        .S(PR_Write_R),
        .notS(_notPR_Write_R),
        .N(_notInc2),
        .P(notALUResult[2]),
        .Out(_new_notR2)
    );

    REGISTER_mux m3(
        .S(PR_Write_R),
        .notS(_notPR_Write_R),
        .N(_notInc3),
        .P(notALUResult[3]),
        .Out(_new_notR3)
    );

    REGISTER_mux m4(
        .S(PR_Write_R),
        .notS(_notPR_Write_R),
        .N(_notInc4),
        .P(notALUResult[4]),
        .Out(_new_notR4)
    );

    REGISTER_mux m5(
        .S(PR_Write_R),
        .notS(_notPR_Write_R),
        .N(_notInc5),
        .P(notALUResult[5]),
        .Out(_new_notR5)
    );

    REGISTER_mux m6(
        .S(PR_Write_R),
        .notS(_notPR_Write_R),
        .N(_notInc6),
        .P(notALUResult[6]),
        .Out(_new_notR6)
    );

    REGISTER_mux m7(
        .S(PR_Write_R),
        .notS(_notPR_Write_R),
        .N(_notInc7),
        .P(notALUResult[7]),
        .Out(_new_notR7)
    );

    REGISTER_dff R0(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notR0),
        .Q(R[0]),
        .notQ(notR[0])
    );

    REGISTER_dff R1(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notR1),
        .Q(R[1]),
        .notQ(notR[1])
    );

    REGISTER_dff R2(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notR2),
        .Q(R[2]),
        .notQ(notR[2])
    );

    REGISTER_dff R3(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notR3),
        .Q(R[3]),
        .notQ(notR[3])
    );

    REGISTER_dff R4(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notR4),
        .Q(R[4]),
        .notQ(notR[4])
    );

    REGISTER_dff R5(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notR5),
        .Q(R[5]),
        .notQ(notR[5])
    );

    REGISTER_dff R6(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notR6),
        .Q(R[6]),
        .notQ(notR[6])
    );

    REGISTER_dff R7(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notR7),
        .Q(R[7]),
        .notQ(notR[7])
    );

endmodule