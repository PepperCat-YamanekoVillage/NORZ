// 25
module DECODER_source_selecter(
        input wire [7:0] OP,
        input wire [7:0] Dtcs,
        input wire PD_Source_Dtcs,
        output wire [7:0] opsource
    );

    wire _notPD_Source_Dtcs = PD_Source_Dtcs ~| PD_Source_Dtcs;

    // and

    wire _op0 = OP[0] ~| PD_Source_Dtcs;
    wire _op1 = OP[1] ~| PD_Source_Dtcs;
    wire _op2 = OP[2] ~| PD_Source_Dtcs;
    wire _op3 = OP[3] ~| PD_Source_Dtcs;
    wire _op4 = OP[4] ~| PD_Source_Dtcs;
    wire _op5 = OP[5] ~| PD_Source_Dtcs;
    wire _op6 = OP[6] ~| PD_Source_Dtcs;
    wire _op7 = OP[7] ~| PD_Source_Dtcs;

    wire _dtcs0 = Dtcs[0] ~| _notPD_Source_Dtcs;
    wire _dtcs1 = Dtcs[1] ~| _notPD_Source_Dtcs;
    wire _dtcs2 = Dtcs[2] ~| _notPD_Source_Dtcs;
    wire _dtcs3 = Dtcs[3] ~| _notPD_Source_Dtcs;
    wire _dtcs4 = Dtcs[4] ~| _notPD_Source_Dtcs;
    wire _dtcs5 = Dtcs[5] ~| _notPD_Source_Dtcs;
    wire _dtcs6 = Dtcs[6] ~| _notPD_Source_Dtcs;
    wire _dtcs7 = Dtcs[7] ~| _notPD_Source_Dtcs;

    // nor

    assign opsource[0] = _op0 ~| _dtcs0;
    assign opsource[1] = _op1 ~| _dtcs1;
    assign opsource[2] = _op2 ~| _dtcs2;
    assign opsource[3] = _op3 ~| _dtcs3;
    assign opsource[4] = _op4 ~| _dtcs4;
    assign opsource[5] = _op5 ~| _dtcs5;
    assign opsource[6] = _op6 ~| _dtcs6;
    assign opsource[7] = _op7 ~| _dtcs7;

endmodule