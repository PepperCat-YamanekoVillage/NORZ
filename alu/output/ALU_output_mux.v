// バラしてfulladderにつけることになると思う 
// 28(260)
module ALU_output_mux(
        input wire [15:0] ADD,
        input wire [7:0] AND,
        input wire [7:0] notOR,
        input wire [7:0] notXOR,
        input wire [7:0] notRL,
        input wire [7:0] notRR,
        input wire [15:0] notRLD,
        input wire [15:0] notRRD,
        input wire notPAs_ADD,
        input wire notPAs_AND,
        input wire PA_OR,
        input wire PA_XOR,
        input wire notPAs_RL,
        input wire notPAs_RR,
        input wire PA_RLD,
        input wire PA_RRD,
        output wire [15:0] Result,
        output wire [15:0] notResult
    );

    wire _notPA_OR = PA_OR ~| PA_OR;
    wire _notPA_XOR = PA_XOR ~| PA_XOR;
    wire _notPA_RLD = PA_RLD ~| PA_RLD;
    wire _notPA_RRD = PA_RRD ~| PA_RRD;

    wire [15:0] _notADD;
    wire [7:0] _notAND;

    // not

    assign _notADD[0] = ADD[0] ~| ADD[0];
    assign _notADD[1] = ADD[1] ~| ADD[1];
    assign _notADD[2] = ADD[2] ~| ADD[2];
    assign _notADD[3] = ADD[3] ~| ADD[3];
    assign _notADD[4] = ADD[4] ~| ADD[4];
    assign _notADD[5] = ADD[5] ~| ADD[5];
    assign _notADD[6] = ADD[6] ~| ADD[6];
    assign _notADD[7] = ADD[7] ~| ADD[7];
    assign _notADD[8] = ADD[8] ~| ADD[8];
    assign _notADD[9] = ADD[9] ~| ADD[9];
    assign _notADD[10] = ADD[10] ~| ADD[10];
    assign _notADD[11] = ADD[11] ~| ADD[11];
    assign _notADD[12] = ADD[12] ~| ADD[12];
    assign _notADD[13] = ADD[13] ~| ADD[13];
    assign _notADD[14] = ADD[14] ~| ADD[14];
    assign _notADD[15] = ADD[15] ~| ADD[15];
    assign _notAND[0] = AND[0] ~| AND[0];
    assign _notAND[1] = AND[1] ~| AND[1];
    assign _notAND[2] = AND[2] ~| AND[2];
    assign _notAND[3] = AND[3] ~| AND[3];
    assign _notAND[4] = AND[4] ~| AND[4];
    assign _notAND[5] = AND[5] ~| AND[5];
    assign _notAND[6] = AND[6] ~| AND[6];
    assign _notAND[7] = AND[7] ~| AND[7];

    // and

    wire [7:0] _ADDH;
    wire [7:0] _ADDL;
    wire [7:0] _AND;
    wire [7:0] _OR;
    wire [7:0] _XOR;
    wire [7:0] _RL;
    wire [7:0] _RR;
    wire [7:0] _RLDH;
    wire [7:0] _RLDL;
    wire [7:0] _RRDH;
    wire [7:0] _RRDL;

    ALU_output_8bit_nor ADDH_(
        .In(_notADD[15:8]),
        .P(notPAs_ADD),
        .Out(_ADDH)
    );

    ALU_output_8bit_nor ADDL_(
        .In(_notADD[7:0]),
        .P(notPAs_ADD),
        .Out(_ADDL)
    );

    ALU_output_8bit_nor AND_(
        .In(_notAND),
        .P(notPAs_AND),
        .Out(_AND)
    );

    ALU_output_8bit_nor OR_(
        .In(notOR),
        .P(_notPA_OR),
        .Out(_OR)
    );

    ALU_output_8bit_nor XOR_(
        .In(notXOR),
        .P(_notPA_XOR),
        .Out(_XOR)
    );

    ALU_output_8bit_nor RL_(
        .In(notRL),
        .P(notPAs_RL),
        .Out(_RL)
    );

    ALU_output_8bit_nor RR_(
        .In(notRR),
        .P(notPAs_RR),
        .Out(_RR)
    );

    ALU_output_8bit_nor RLDH_(
        .In(notRLD[15:8]),
        .P(_notPA_RLD),
        .Out(_RLDH)
    );

    ALU_output_8bit_nor RLDL_(
        .In(notRLD[7:0]),
        .P(_notPA_RLD),
        .Out(_RLDL)
    );

    ALU_output_8bit_nor RRDH_(
        .In(notRRD[15:8]),
        .P(_notPA_RRD),
        .Out(_RRDH)
    );

    ALU_output_8bit_nor RRDL_(
        .In(notRRD[7:0]),
        .P(_notPA_RRD),
        .Out(_RRDL)
    );

    // or

    wire [7:0] _H0;

    ALU_output_8bit_or orH0(
        .A(_ADDH),
        .B(_RLDH),
        .Out(_H0)
    );

    ALU_output_8bit_or orH1(
        .A(_RRDH),
        .B(_H0),
        .Out(Result[15:8]),
        .notOut(notResult[15:8])
    );

    wire [7:0] _L0;
    wire [7:0] _L1;
    wire [7:0] _L2;
    wire [7:0] _L3;
    wire [7:0] _L4;
    wire [7:0] _L5;

    ALU_output_8bit_or orL0(
        .A(_ADDL),
        .B(_AND),
        .Out(_L0)
    );

    ALU_output_8bit_or orL1(
        .A(_OR),
        .B(_L0),
        .Out(_L1)
    );

    ALU_output_8bit_or orL2(
        .A(_XOR),
        .B(_L1),
        .Out(_L2)
    );

    ALU_output_8bit_or orL3(
        .A(_RL),
        .B(_L2),
        .Out(_L3)
    );

    ALU_output_8bit_or orL4(
        .A(_RR),
        .B(_L3),
        .Out(_L4)
    );

    ALU_output_8bit_or orL5(
        .A(_RLDL),
        .B(_L4),
        .Out(_L5)
    );

    ALU_output_8bit_or orL6(
        .A(_RRDL),
        .B(_L5),
        .Out(Result[7:0]),
        .notOut(notResult[7:0])
    );

endmodule