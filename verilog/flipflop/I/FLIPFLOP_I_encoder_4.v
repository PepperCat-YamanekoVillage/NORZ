// ばらしてデコーダーの近くに置くことになるかも
// nor省略!!
// 160
module FLIPFLOP_I_encoder_4(
        input wire P2_Set_ILDrn_B,        // 0001 0000
        input wire P2_Set_ILDrn_C,        // 0001 0001
        input wire P2_Set_ILDrn_D,        // 0001 0010
        input wire P2_Set_ILDrn_E,        // 0001 0011
        input wire P2_Set_ILDrn_H,        // 0001 0100
        input wire P2_Set_ILDrn_L,        // 0001 0101
        input wire P2_Set_ILDrn_A,        // 0001 0111
        input wire P2_Set_ILDrlIYtdl_B,   // 0011 0000
        input wire P2_Set_ILDrlIYtdl_C,   // 0011 0001
        input wire P2_Set_ILDrlIYtdl_D,   // 0011 0010
        input wire P2_Set_ILDrlIYtdl_E,   // 0011 0011
        input wire P2_Set_ILDrlIYtdl_H,   // 0011 0100
        input wire P2_Set_ILDrlIYtdl_L,   // 0011 0101
        input wire P2_Set_ILDrlIYtdl_A,   // 0011 0111
        input wire P2_Set_ILDlIYtdlr_B,   // 0101 0000
        input wire P2_Set_ILDlIYtdlr_C,   // 0101 0001
        input wire P2_Set_ILDlIYtdlr_D,   // 0101 0010
        input wire P2_Set_ILDlIYtdlr_E,   // 0101 0011
        input wire P2_Set_ILDlIYtdlr_H,   // 0101 0100
        input wire P2_Set_ILDlIYtdlr_L,   // 0101 0101
        input wire P2_Set_ILDlIYtdlr_A,   // 0101 0111
        input wire P2_Set_ILDlIXtdln_0,   // 1111 1010
        input wire P2_Set_ILDlIXtdln_1,   // 1111 1011
        input wire P2_Set_ILDlIYtdln_0,   // 1111 1110
        input wire P2_Set_ILDlIYtdln_1,   // 1111 1111
        input wire P2_Set_ILDddlnnl_BC_0, // 0111 0000
        input wire P2_Set_ILDddlnnl_DE_0, // 0111 0001
        input wire P2_Set_ILDddlnnl_HL_0, // 0111 0010
        input wire P2_Set_ILDddlnnl_SP_0, // 0111 0011
        input wire P2_Set_ILDddlnnl_BC_1, // 0111 0100
        input wire P2_Set_ILDddlnnl_DE_1, // 0111 0101
        input wire P2_Set_ILDddlnnl_HL_1, // 0111 0110
        input wire P2_Set_ILDddlnnl_SP_1, // 0111 0111
        input wire P2_Set_ILDIXlnnl_0,    // 0001 1010
        input wire P2_Set_ILDIXlnnl_1,    // 0001 1011
        input wire P2_Set_ILDIYlnnl_0,    // 0001 1110
        input wire P2_Set_ILDIYlnnl_1,    // 0001 1111
        input wire P2_Set_IADDAn,         // 1111 0000
        input wire P2_Set_IADDAlIYtdl,    // 1101 1000
        input wire P2_Set_IADCAn,         // 1111 0100
        input wire P2_Set_IADCAlIYtdl,    // 1101 1100
        input wire P2_Set_ISUBAn,         // 1111 0001
        input wire P2_Set_ISUBAlIYtdl,    // 1101 1001
        input wire P2_Set_ISBCAn,         // 1111 0101
        input wire P2_Set_ISBCAlIYtdl,    // 1101 1101
        input wire P2_Set_IANDn,          // 1111 0010
        input wire P2_Set_IANDlIYtdl,     // 1101 1010
        input wire P2_Set_IORn,           // 1111 0011
        input wire P2_Set_IORlIYtdl,      // 1101 1011
        input wire P2_Set_IXORn,          // 1111 0110
        input wire P2_Set_IXORlIYtdl,     // 1101 1110
        input wire P2_Set_ICPn,           // 1111 0111
        input wire P2_Set_ICPlIYtdl,      // 1101 1111
        input wire P2_Set_IINClIXtdl,     // 1111 1000
        input wire P2_Set_IINClIYtdl,     // 1111 1001
        input wire P2_Set_IDEClIXtdl,     // 1111 1100
        input wire P2_Set_IDEClIYtdl,     // 1111 1101
        input wire P2_Set_IJPccnn_0_1,    // 0101 1000
        input wire P2_Set_IJPccnn_1_1,    // 0101 1001
        input wire P2_Set_IJPccnn_2_1,    // 0101 1010
        input wire P2_Set_IJPccnn_3_1,    // 0101 1011
        input wire P2_Set_IJPccnn_4_1,    // 0101 1100
        input wire P2_Set_IJPccnn_5_1,    // 0101 1101
        input wire P2_Set_IJPccnn_6_1,    // 0101 1110
        input wire P2_Set_IJPccnn_7_1,    // 0101 1111
        input wire P2_Set_IJRe,           // 0011 1000
        input wire P2_Set_IJRCe,          // 0011 1010
        input wire P2_Set_IJRNCe,         // 0011 1011
        input wire P2_Set_IJRZe,          // 0011 1110
        input wire P2_Set_IJRNZe,         // 0011 1111
        input wire P2_Set_IDJNZe,         // 0011 1100
        input wire P2_Set_ICALLnn_0,      // 0001 1100
        input wire P2_Set_ICALLnn_1,      // 0001 1101
        input wire P2_Set_ICALLnn_0_1,    // 1001 1000
        input wire P2_Set_ICALLnn_1_1,    // 1001 1001
        input wire P2_Set_ICALLnn_2_1,    // 1001 1010
        input wire P2_Set_ICALLnn_3_1,    // 1001 1011
        input wire P2_Set_ICALLnn_4_1,    // 1001 1100
        input wire P2_Set_ICALLnn_5_1,    // 1001 1101
        input wire P2_Set_ICALLnn_6_1,    // 1001 1110
        input wire P2_Set_ICALLnn_7_1,    // 1001 1111
        output wire encoded4
    );

    // or
    
    assign encoded4 = (P2_Set_ILDrn_B | P2_Set_ILDrn_C | P2_Set_ILDrn_D | P2_Set_ILDrn_E | P2_Set_ILDrn_H | P2_Set_ILDrn_L | P2_Set_ILDrn_A | P2_Set_ILDrlIYtdl_B | P2_Set_ILDrlIYtdl_C | P2_Set_ILDrlIYtdl_D | P2_Set_ILDrlIYtdl_E | P2_Set_ILDrlIYtdl_H | P2_Set_ILDrlIYtdl_L | P2_Set_ILDrlIYtdl_A | P2_Set_ILDlIYtdlr_B | P2_Set_ILDlIYtdlr_C | P2_Set_ILDlIYtdlr_D | P2_Set_ILDlIYtdlr_E | P2_Set_ILDlIYtdlr_H | P2_Set_ILDlIYtdlr_L | P2_Set_ILDlIYtdlr_A | P2_Set_ILDlIXtdln_0 | P2_Set_ILDlIXtdln_1 | P2_Set_ILDlIYtdln_0 | P2_Set_ILDlIYtdln_1 | P2_Set_ILDddlnnl_BC_0 | P2_Set_ILDddlnnl_DE_0 | P2_Set_ILDddlnnl_HL_0 | P2_Set_ILDddlnnl_SP_0 | P2_Set_ILDddlnnl_BC_1 | P2_Set_ILDddlnnl_DE_1 | P2_Set_ILDddlnnl_HL_1 | P2_Set_ILDddlnnl_SP_1 | P2_Set_ILDIXlnnl_0 | P2_Set_ILDIXlnnl_1 | P2_Set_ILDIYlnnl_0 | P2_Set_ILDIYlnnl_1 | P2_Set_IADDAn | P2_Set_IADDAlIYtdl | P2_Set_IADCAn | P2_Set_IADCAlIYtdl | P2_Set_ISUBAn | P2_Set_ISUBAlIYtdl | P2_Set_ISBCAn | P2_Set_ISBCAlIYtdl | P2_Set_IANDn | P2_Set_IANDlIYtdl | P2_Set_IORn | P2_Set_IORlIYtdl | P2_Set_IXORn | P2_Set_IXORlIYtdl | P2_Set_ICPn | P2_Set_ICPlIYtdl | P2_Set_IINClIXtdl | P2_Set_IINClIYtdl | P2_Set_IDEClIXtdl | P2_Set_IDEClIYtdl | P2_Set_IJPccnn_0_1 | P2_Set_IJPccnn_1_1 | P2_Set_IJPccnn_2_1 | P2_Set_IJPccnn_3_1 | P2_Set_IJPccnn_4_1 | P2_Set_IJPccnn_5_1 | P2_Set_IJPccnn_6_1 | P2_Set_IJPccnn_7_1 | P2_Set_IJRe | P2_Set_IJRCe | P2_Set_IJRNCe | P2_Set_IJRZe | P2_Set_IJRNZe | P2_Set_IDJNZe | P2_Set_ICALLnn_0 | P2_Set_ICALLnn_1 | P2_Set_ICALLnn_0_1 | P2_Set_ICALLnn_1_1 | P2_Set_ICALLnn_2_1 | P2_Set_ICALLnn_3_1 | P2_Set_ICALLnn_4_1 | P2_Set_ICALLnn_5_1 | P2_Set_ICALLnn_6_1 | P2_Set_ICALLnn_7_1); 

endmodule