// バラして各fulladderにつけることになるかも
// 37
module ALU_flag_is8bitEqual(
        input wire [7:0] High,
        input wire [7:0] notHigh,
        input wire [7:0] Low,
        input wire [7:0] notLow,
        output wire is8bitEqual
    );

    // xor 
    wire _0xor_n = notHigh[0] ~| notLow[0];
    wire _0xor_p = High[0] ~| Low[0];
    wire _0xor = _0xor_n ~| _0xor_p;

    wire _1xor_n = notHigh[1] ~| notLow[1];
    wire _1xor_p = High[1] ~| Low[1];
    wire _1xor = _1xor_n ~| _1xor_p;

    wire _2xor_n = notHigh[2] ~| notLow[2];
    wire _2xor_p = High[2] ~| Low[2];
    wire _2xor = _2xor_n ~| _2xor_p;

    wire _3xor_n = notHigh[3] ~| notLow[3];
    wire _3xor_p = High[3] ~| Low[3];
    wire _3xor = _3xor_n ~| _3xor_p;

    wire _4xor_n = notHigh[4] ~| notLow[4];
    wire _4xor_p = High[4] ~| Low[4];
    wire _4xor = _4xor_n ~| _4xor_p;

    wire _5xor_n = notHigh[5] ~| notLow[5];
    wire _5xor_p = High[5] ~| Low[5];
    wire _5xor = _5xor_n ~| _5xor_p;

    wire _6xor_n = notHigh[6] ~| notLow[6];
    wire _6xor_p = High[6] ~| Low[6];
    wire _6xor = _6xor_n ~| _6xor_p;

    wire _7xor_n = notHigh[7] ~| notLow[7];
    wire _7xor_p = High[7] ~| Low[7];
    wire _7xor = _7xor_n ~| _7xor_p;

    wire _01nor = _0xor ~| _1xor;
    wire _01or = _01nor ~| _01nor;
    wire _23nor = _2xor ~| _3xor;
    wire _23or = _23nor ~| _23nor;
    wire _45nor = _4xor ~| _5xor;
    wire _45or = _45nor ~| _45nor;
    wire _67nor = _6xor ~| _7xor;
    wire _67or = _67nor ~| _67nor;

    wire _0123nor = _01or ~| _23or;
    wire _0123or = _0123nor ~| _0123nor;
    wire _4567nor = _45or ~| _67or;
    wire _4567or = _4567nor ~| _4567nor;

    assign is8bitEqual = _0123or ~| _4567or;

endmodule