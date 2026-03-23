// 13
module ALU_flag_is8bitZero(
        input wire [7:0] Result,
        output wire is8bitZero
    );

    wire _01nor = Result[0] ~| Result[1];
    wire _01or = _01nor ~| _01nor;
    wire _23nor = Result[2] ~| Result[3];
    wire _23or = _23nor ~| _23nor;
    wire _45nor = Result[4] ~| Result[5];
    wire _45or = _45nor ~| _45nor;
    wire _67nor = Result[6] ~| Result[7];
    wire _67or = _67nor ~| _67nor;

    wire _0123nor = _01or ~| _23or;
    wire _0123or = _0123nor ~| _0123nor;
    wire _4567nor = _45or ~| _67or;
    wire _4567or = _4567nor ~| _4567nor;

    assign is8bitZero = _0123or ~| _4567or;

endmodule