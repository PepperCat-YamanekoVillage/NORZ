// (60)
module REGISTER_16bit_dec(
        input wire [15:0] In,
        input wire [15:0] notIn,
        output wire [15:0] notOut
    );

    // wire [15:0] notIn = ~In;

    //
    // ha0
    //

    assign notOut[0] = In[0];
    wire _notCY0 = notIn[0];
    wire _notCY1;
    wire _notCY2;
    wire _notCY3;
    wire _notCY4;
    wire _notCY5;
    wire _notCY6;
    wire _notCY7;
    wire _notCY8;
    wire _notCY9;
    wire _notCY10;
    wire _notCY11;
    wire _notCY12;
    wire _notCY13;
    wire _notCY14;

    REGISTER_half_adder_dec ha1(
        .In(In[1]),
        .notIn(notIn[1]),
        .notCin(_notCY0),
        .notS(notOut[1]),
        .notCout(_notCY1)
    );

    REGISTER_half_adder_dec ha2(
        .In(In[2]),
        .notIn(notIn[2]),
        .notCin(_notCY1),
        .notS(notOut[2]),
        .notCout(_notCY2)
    );

    REGISTER_half_adder_dec ha3(
        .In(In[3]),
        .notIn(notIn[3]),
        .notCin(_notCY2),
        .notS(notOut[3]),
        .notCout(_notCY3)
    );

    REGISTER_half_adder_dec ha4(
        .In(In[4]),
        .notIn(notIn[4]),
        .notCin(_notCY3),
        .notS(notOut[4]),
        .notCout(_notCY4)
    );

    REGISTER_half_adder_dec ha5(
        .In(In[5]),
        .notIn(notIn[5]),
        .notCin(_notCY4),
        .notS(notOut[5]),
        .notCout(_notCY5)
    );

    REGISTER_half_adder_dec ha6(
        .In(In[6]),
        .notIn(notIn[6]),
        .notCin(_notCY5),
        .notS(notOut[6]),
        .notCout(_notCY6)
    );

    REGISTER_half_adder_dec ha7(
        .In(In[7]),
        .notIn(notIn[7]),
        .notCin(_notCY6),
        .notS(notOut[7]),
        .notCout(_notCY7)
    );

    REGISTER_half_adder_dec ha8(
        .In(In[8]),
        .notIn(notIn[8]),
        .notCin(_notCY7),
        .notS(notOut[8]),
        .notCout(_notCY8)
    );

    REGISTER_half_adder_dec ha9(
        .In(In[9]),
        .notIn(notIn[9]),
        .notCin(_notCY8),
        .notS(notOut[9]),
        .notCout(_notCY9)
    );

    REGISTER_half_adder_dec ha10(
        .In(In[10]),
        .notIn(notIn[10]),
        .notCin(_notCY9),
        .notS(notOut[10]),
        .notCout(_notCY10)
    );

    REGISTER_half_adder_dec ha11(
        .In(In[11]),
        .notIn(notIn[11]),
        .notCin(_notCY10),
        .notS(notOut[11]),
        .notCout(_notCY11)
    );

    REGISTER_half_adder_dec ha12(
        .In(In[12]),
        .notIn(notIn[12]),
        .notCin(_notCY11),
        .notS(notOut[12]),
        .notCout(_notCY12)
    );

    REGISTER_half_adder_dec ha13(
        .In(In[13]),
        .notIn(notIn[13]),
        .notCin(_notCY12),
        .notS(notOut[13]),
        .notCout(_notCY13)
    );

    REGISTER_half_adder_dec ha14(
        .In(In[14]),
        .notIn(notIn[14]),
        .notCin(_notCY13),
        .notS(notOut[14]),
        .notCout(_notCY14)
    );

    REGISTER_half_adder_dec ha15(
        .In(In[15]),
        .notIn(notIn[15]),
        .notCin(_notCY14),
        .notS(notOut[15])
    );

endmodule