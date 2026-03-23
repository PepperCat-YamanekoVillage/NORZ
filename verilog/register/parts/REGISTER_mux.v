// 3
module REGISTER_mux(
        input wire S,
        input wire notS,
        input wire N,
        input wire P,
        output wire Out
    );

    wire _0 = N ~| S;
    wire _1 = P ~| notS;
    assign Out = _0 ~| _1;

endmodule