// 1(49)
module REGISTER_invert(
        input wire [15:0] notALUResult,
        input wire PR_InvertIn,
        output wire [15:0] invertedNotALUResult
    );

    wire _notPR_InvertIn = PR_InvertIn ~| PR_InvertIn;

    //
    // inc
    //

    REGISTER_mux m0(
        .S(PR_InvertIn),
        .notS(_notPR_InvertIn),
        .N(notALUResult[0]),
        .P(notALUResult[8]),
        .Out(invertedNotALUResult[0])
    );

    REGISTER_mux m1(
        .S(PR_InvertIn),
        .notS(_notPR_InvertIn),
        .N(notALUResult[1]),
        .P(notALUResult[9]),
        .Out(invertedNotALUResult[1])
    );

    REGISTER_mux m2(
        .S(PR_InvertIn),
        .notS(_notPR_InvertIn),
        .N(notALUResult[2]),
        .P(notALUResult[10]),
        .Out(invertedNotALUResult[2])
    );

    REGISTER_mux m3(
        .S(PR_InvertIn),
        .notS(_notPR_InvertIn),
        .N(notALUResult[3]),
        .P(notALUResult[11]),
        .Out(invertedNotALUResult[3])
    );

    REGISTER_mux m4(
        .S(PR_InvertIn),
        .notS(_notPR_InvertIn),
        .N(notALUResult[4]),
        .P(notALUResult[12]),
        .Out(invertedNotALUResult[4])
    );

    REGISTER_mux m5(
        .S(PR_InvertIn),
        .notS(_notPR_InvertIn),
        .N(notALUResult[5]),
        .P(notALUResult[13]),
        .Out(invertedNotALUResult[5])
    );

    REGISTER_mux m6(
        .S(PR_InvertIn),
        .notS(_notPR_InvertIn),
        .N(notALUResult[6]),
        .P(notALUResult[14]),
        .Out(invertedNotALUResult[6])
    );

    REGISTER_mux m7(
        .S(PR_InvertIn),
        .notS(_notPR_InvertIn),
        .N(notALUResult[7]),
        .P(notALUResult[15]),
        .Out(invertedNotALUResult[7])
    );

    REGISTER_mux m8(
        .S(PR_InvertIn),
        .notS(_notPR_InvertIn),
        .N(notALUResult[8]),
        .P(notALUResult[0]),
        .Out(invertedNotALUResult[8])
    );

    REGISTER_mux m9(
        .S(PR_InvertIn),
        .notS(_notPR_InvertIn),
        .N(notALUResult[9]),
        .P(notALUResult[1]),
        .Out(invertedNotALUResult[9])
    );

    REGISTER_mux m10(
        .S(PR_InvertIn),
        .notS(_notPR_InvertIn),
        .N(notALUResult[10]),
        .P(notALUResult[2]),
        .Out(invertedNotALUResult[10])
    );

    REGISTER_mux m11(
        .S(PR_InvertIn),
        .notS(_notPR_InvertIn),
        .N(notALUResult[11]),
        .P(notALUResult[3]),
        .Out(invertedNotALUResult[11])
    );

    REGISTER_mux m12(
        .S(PR_InvertIn),
        .notS(_notPR_InvertIn),
        .N(notALUResult[12]),
        .P(notALUResult[4]),
        .Out(invertedNotALUResult[12])
    );

    REGISTER_mux m13(
        .S(PR_InvertIn),
        .notS(_notPR_InvertIn),
        .N(notALUResult[13]),
        .P(notALUResult[5]),
        .Out(invertedNotALUResult[13])
    );

    REGISTER_mux m14(
        .S(PR_InvertIn),
        .notS(_notPR_InvertIn),
        .N(notALUResult[14]),
        .P(notALUResult[6]),
        .Out(invertedNotALUResult[14])
    );

    REGISTER_mux m15(
        .S(PR_InvertIn),
        .notS(_notPR_InvertIn),
        .N(notALUResult[15]),
        .P(notALUResult[7]),
        .Out(invertedNotALUResult[15])
    );

endmodule