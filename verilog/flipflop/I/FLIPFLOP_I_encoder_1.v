// ばらしてデコーダーの近くに置くことになるかも
// nor省略!!
// 156
module FLIPFLOP_I_encoder_1(
        input wire P2_Set_ILDrn_D,        // 0001 0010
        input wire P2_Set_ILDrn_E,        // 0001 0011
        input wire P2_Set_ILDrn_A,        // 0001 0111
        input wire P2_Set_ILDrlIXtdl_D,   // 0010 0010
        input wire P2_Set_ILDrlIXtdl_E,   // 0010 0011
        input wire P2_Set_ILDrlIXtdl_A,   // 0010 0111
        input wire P2_Set_ILDrlIYtdl_D,   // 0011 0010
        input wire P2_Set_ILDrlIYtdl_E,   // 0011 0011
        input wire P2_Set_ILDrlIYtdl_A,   // 0011 0111
        input wire P2_Set_ILDlIXtdlr_D,   // 0100 0010
        input wire P2_Set_ILDlIXtdlr_E,   // 0100 0011
        input wire P2_Set_ILDlIXtdlr_A,   // 0100 0111
        input wire P2_Set_ILDlIYtdlr_D,   // 0101 0010
        input wire P2_Set_ILDlIYtdlr_E,   // 0101 0011
        input wire P2_Set_ILDlIYtdlr_A,   // 0101 0111
        input wire P2_Set_ILDlIXtdln_0,   // 1111 1010
        input wire P2_Set_ILDlIXtdln_1,   // 1111 1011
        input wire P2_Set_ILDlIYtdln_0,   // 1111 1110
        input wire P2_Set_ILDlIYtdln_1,   // 1111 1111
        input wire P2_Set_ILDddnn_HL_0,   // 0110 0010
        input wire P2_Set_ILDddnn_SP_0,   // 0110 0011
        input wire P2_Set_ILDddnn_HL_1,   // 0110 0110
        input wire P2_Set_ILDddnn_SP_1,   // 0110 0111
        input wire P2_Set_ILDIXnn_0,      // 0000 1010
        input wire P2_Set_ILDIXnn_1,      // 0000 1011
        input wire P2_Set_ILDIYnn_0,      // 0000 1110
        input wire P2_Set_ILDIYnn_1,      // 0000 1111
        input wire P2_Set_ILDddlnnl_HL_0, // 0111 0010
        input wire P2_Set_ILDddlnnl_SP_0, // 0111 0011
        input wire P2_Set_ILDddlnnl_HL_1, // 0111 0110
        input wire P2_Set_ILDddlnnl_SP_1, // 0111 0111
        input wire P2_Set_ILDIXlnnl_0,    // 0001 1010
        input wire P2_Set_ILDIXlnnl_1,    // 0001 1011
        input wire P2_Set_ILDIYlnnl_0,    // 0001 1110
        input wire P2_Set_ILDIYlnnl_1,    // 0001 1111
        input wire P2_Set_ILDlnnlHL_0,    // 0000 0010
        input wire P2_Set_ILDlnnlHL_1,    // 0000 0011
        input wire P2_Set_ILDlnnldd_HL_0, // 1000 0010
        input wire P2_Set_ILDlnnldd_SP_0, // 1000 0011
        input wire P2_Set_ILDlnnldd_HL_1, // 1000 0110
        input wire P2_Set_ILDlnnldd_SP_1, // 1000 0111
        input wire P2_Set_ILDlnnlIX_0,    // 0010 1010
        input wire P2_Set_ILDlnnlIX_1,    // 0010 1011
        input wire P2_Set_ILDlnnlIY_0,    // 0010 1110
        input wire P2_Set_ILDlnnlIY_1,    // 0010 1111
        input wire P2_Set_IANDn,          // 1111 0010
        input wire P2_Set_IANDlIXtdl,     // 1100 1010
        input wire P2_Set_IANDlIYtdl,     // 1101 1010
        input wire P2_Set_IORn,           // 1111 0011
        input wire P2_Set_IORlIXtdl,      // 1100 1011
        input wire P2_Set_IORlIYtdl,      // 1101 1011
        input wire P2_Set_IXORn,          // 1111 0110
        input wire P2_Set_IXORlIXtdl,     // 1100 1110
        input wire P2_Set_IXORlIYtdl,     // 1101 1110
        input wire P2_Set_ICPn,           // 1111 0111
        input wire P2_Set_ICPlIXtdl,      // 1100 1111
        input wire P2_Set_ICPlIYtdl,      // 1101 1111
        input wire P2_Set_IJPnn_0,        // 0000 0110
        input wire P2_Set_IJPnn_1,        // 0000 0111
        input wire P2_Set_IJPccnn_2_0,    // 0100 1010
        input wire P2_Set_IJPccnn_3_0,    // 0100 1011
        input wire P2_Set_IJPccnn_6_0,    // 0100 1110
        input wire P2_Set_IJPccnn_7_0,    // 0100 1111
        input wire P2_Set_IJPccnn_2_1,    // 0101 1010
        input wire P2_Set_IJPccnn_3_1,    // 0101 1011
        input wire P2_Set_IJPccnn_6_1,    // 0101 1110
        input wire P2_Set_IJPccnn_7_1,    // 0101 1111
        input wire P2_Set_IJRCe,          // 0011 1010
        input wire P2_Set_IJRNCe,         // 0011 1011
        input wire P2_Set_IJRZe,          // 0011 1110
        input wire P2_Set_IJRNZe,         // 0011 1111
        input wire P2_Set_ICALLnn_2_0,    // 1000 1010
        input wire P2_Set_ICALLnn_3_0,    // 1000 1011
        input wire P2_Set_ICALLnn_6_0,    // 1000 1110
        input wire P2_Set_ICALLnn_7_0,    // 1000 1111
        input wire P2_Set_ICALLnn_2_1,    // 1001 1010
        input wire P2_Set_ICALLnn_3_1,    // 1001 1011
        input wire P2_Set_ICALLnn_6_1,    // 1001 1110
        input wire P2_Set_ICALLnn_7_1,    // 1001 1111
        output wire encoded1
    );

    // or

    assign encoded1 = (P2_Set_ILDrn_D | P2_Set_ILDrn_E | P2_Set_ILDrn_A | P2_Set_ILDrlIXtdl_D | P2_Set_ILDrlIXtdl_E | P2_Set_ILDrlIXtdl_A | P2_Set_ILDrlIYtdl_D | P2_Set_ILDrlIYtdl_E | P2_Set_ILDrlIYtdl_A | P2_Set_ILDlIXtdlr_D | P2_Set_ILDlIXtdlr_E | P2_Set_ILDlIXtdlr_A | P2_Set_ILDlIYtdlr_D | P2_Set_ILDlIYtdlr_E | P2_Set_ILDlIYtdlr_A | P2_Set_ILDlIXtdln_0 | P2_Set_ILDlIXtdln_1 | P2_Set_ILDlIYtdln_0 | P2_Set_ILDlIYtdln_1 | P2_Set_ILDddnn_HL_0 | P2_Set_ILDddnn_SP_0 | P2_Set_ILDddnn_HL_1 | P2_Set_ILDddnn_SP_1 | P2_Set_ILDIXnn_0 | P2_Set_ILDIXnn_1 | P2_Set_ILDIYnn_0 | P2_Set_ILDIYnn_1 | P2_Set_ILDddlnnl_HL_0 | P2_Set_ILDddlnnl_SP_0 | P2_Set_ILDddlnnl_HL_1 | P2_Set_ILDddlnnl_SP_1 | P2_Set_ILDIXlnnl_0 | P2_Set_ILDIXlnnl_1 | P2_Set_ILDIYlnnl_0 | P2_Set_ILDIYlnnl_1 | P2_Set_ILDlnnlHL_0 | P2_Set_ILDlnnlHL_1 | P2_Set_ILDlnnldd_HL_0 | P2_Set_ILDlnnldd_SP_0 | P2_Set_ILDlnnldd_HL_1 | P2_Set_ILDlnnldd_SP_1 | P2_Set_ILDlnnlIX_0 | P2_Set_ILDlnnlIX_1 | P2_Set_ILDlnnlIY_0 | P2_Set_ILDlnnlIY_1 | P2_Set_IANDn | P2_Set_IANDlIXtdl | P2_Set_IANDlIYtdl | P2_Set_IORn | P2_Set_IORlIXtdl | P2_Set_IORlIYtdl | P2_Set_IXORn | P2_Set_IXORlIXtdl | P2_Set_IXORlIYtdl | P2_Set_ICPn | P2_Set_ICPlIXtdl | P2_Set_ICPlIYtdl | P2_Set_IJPnn_0 | P2_Set_IJPnn_1 | P2_Set_IJPccnn_2_0 | P2_Set_IJPccnn_3_0 | P2_Set_IJPccnn_6_0 | P2_Set_IJPccnn_7_0 | P2_Set_IJPccnn_2_1 | P2_Set_IJPccnn_3_1 | P2_Set_IJPccnn_6_1 | P2_Set_IJPccnn_7_1 | P2_Set_IJRCe | P2_Set_IJRNCe | P2_Set_IJRZe | P2_Set_IJRNZe | P2_Set_ICALLnn_2_0 | P2_Set_ICALLnn_3_0 | P2_Set_ICALLnn_6_0 | P2_Set_ICALLnn_7_0 | P2_Set_ICALLnn_2_1 | P2_Set_ICALLnn_3_1 | P2_Set_ICALLnn_6_1 | P2_Set_ICALLnn_7_1);

endmodule