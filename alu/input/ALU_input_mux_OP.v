// ケーブル削減のため、レジスタ基板に搭載することになると思う
// 46
module ALU_input_mux_OP(
        input wire [7:0] notOP,
        input wire [7:0] notOPold,
        input wire PA_Select_OP_low,
        input wire PA_Select_IOP_low,
        input wire notPA_Select_OPOPold_low,
        input wire PA_Select_0xffOP_low,
        input wire PA_Select_OPold_low,
        input wire PA_Select_OPxx_low,
        output wire [15:0] Low
    );

    wire _notPA_Select_OP_low_low0 = PA_Select_OP_low ~| PA_Select_IOP_low;
    wire _PA_Select_OP_low_low0 = _notPA_Select_OP_low_low0 ~| _notPA_Select_OP_low_low0;
    wire _notPA_Select_OP_low_low = PA_Select_0xffOP_low ~| _PA_Select_OP_low_low0;
    wire _PA_Select_OPOPold_low = notPA_Select_OPOPold_low ~| notPA_Select_OPOPold_low;
    wire _not_opold_low = _PA_Select_OPOPold_low ~| PA_Select_OPold_low;
    wire _notPA_Select_OPxx_low = PA_Select_OPxx_low ~| _PA_Select_OPOPold_low;

    assign Low[8] = notOP[0] ~| _notPA_Select_OPxx_low;
    assign Low[9] = notOP[1] ~| _notPA_Select_OPxx_low;
    assign Low[10] = notOP[2] ~| _notPA_Select_OPxx_low;
    assign Low[11] = notOP[3] ~| _notPA_Select_OPxx_low;
    assign Low[12] = notOP[4] ~| _notPA_Select_OPxx_low;
    assign Low[13] = notOP[5] ~| _notPA_Select_OPxx_low;
    assign Low[14] = notOP[6] ~| _notPA_Select_OPxx_low;
    assign Low[15] = notOP[7] ~| _notPA_Select_OPxx_low;

    wire _low_OP0 = notOP[0] ~| _notPA_Select_OP_low_low;
    wire _low_OP1 = notOP[1] ~| _notPA_Select_OP_low_low;
    wire _low_OP2 = notOP[2] ~| _notPA_Select_OP_low_low;
    wire _low_OP3 = notOP[3] ~| _notPA_Select_OP_low_low;
    wire _low_OP4 = notOP[4] ~| _notPA_Select_OP_low_low;
    wire _low_OP5 = notOP[5] ~| _notPA_Select_OP_low_low;
    wire _low_OP6 = notOP[6] ~| _notPA_Select_OP_low_low;
    wire _low_OP7 = notOP[7] ~| _notPA_Select_OP_low_low;
    wire _low_OPold0 = notOPold[0] ~| _not_opold_low;
    wire _low_OPold1 = notOPold[1] ~| _not_opold_low;
    wire _low_OPold2 = notOPold[2] ~| _not_opold_low;
    wire _low_OPold3 = notOPold[3] ~| _not_opold_low;
    wire _low_OPold4 = notOPold[4] ~| _not_opold_low;
    wire _low_OPold5 = notOPold[5] ~| _not_opold_low;
    wire _low_OPold6 = notOPold[6] ~| _not_opold_low;
    wire _low_OPold7 = notOPold[7] ~| _not_opold_low;

    wire _notLow0 = _low_OP0 ~| _low_OPold0;
    wire _notLow1 = _low_OP1 ~| _low_OPold1;
    wire _notLow2 = _low_OP2 ~| _low_OPold2;
    wire _notLow3 = _low_OP3 ~| _low_OPold3;
    wire _notLow4 = _low_OP4 ~| _low_OPold4;
    wire _notLow5 = _low_OP5 ~| _low_OPold5;
    wire _notLow6 = _low_OP6 ~| _low_OPold6;
    wire _notLow7 = _low_OP7 ~| _low_OPold7;

    assign Low[0] = _notLow0 ~| _notLow0;
    assign Low[1] = _notLow1 ~| _notLow1;
    assign Low[2] = _notLow2 ~| _notLow2;
    assign Low[3] = _notLow3 ~| _notLow3;
    assign Low[4] = _notLow4 ~| _notLow4;
    assign Low[5] = _notLow5 ~| _notLow5;
    assign Low[6] = _notLow6 ~| _notLow6;
    assign Low[7] = _notLow7 ~| _notLow7;

endmodule