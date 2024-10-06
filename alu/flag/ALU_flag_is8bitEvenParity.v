// 27
module ALU_flag_is8bitEvenParity(
        input wire [7:0] Result,
        input wire [7:0] notResult,
        output wire notIs8bitEvenParity
    );

    wire _01xor_n = notResult[0] ~| notResult[1];
    wire _01xor_p = Result[0] ~| Result[1];
    wire _23xor_n = notResult[2] ~| notResult[3];
    wire _23xor_p = Result[2] ~| Result[3];
    wire _45xor_n = notResult[4] ~| notResult[5];
    wire _45xor_p = Result[4] ~| Result[5];
    wire _67xor_n = notResult[6] ~| notResult[7];
    wire _67xor_p = Result[6] ~| Result[7];

    wire _01xor = _01xor_n ~| _01xor_p;
    wire _23xor = _23xor_n ~| _23xor_p;
    wire _45xor = _45xor_n ~| _45xor_p;
    wire _67xor = _67xor_n ~| _67xor_p;

    wire _not01xor = _01xor ~| _01xor;
    wire _not23xor = _23xor ~| _23xor;
    wire _not45xor = _45xor ~| _45xor;
    wire _not67xor = _67xor ~| _67xor;

    wire _0123xor_n = _not01xor ~| _not23xor;
    wire _0123xor_p = _01xor ~| _23xor;
    wire _4567xor_n = _not45xor ~| _not67xor;
    wire _4567xor_p = _45xor ~| _67xor;

    wire _0123xor = _0123xor_n ~| _0123xor_p;
    wire _4567xor = _4567xor_n ~| _4567xor_p;

    wire _not0123xor = _0123xor ~| _0123xor;
    wire _not4567xor = _4567xor ~| _4567xor;

    wire _xor_n = _not0123xor ~| _not4567xor;
    wire _xor_p = _0123xor ~| _4567xor;

    assign notIs8bitEvenParity = _xor_n ~| _xor_p;

endmodule