// ばらしてデコーダーの近くに置くことになるかも
// nor省略!!
// 114
module FLIPFLOP_I_encoder_5(
        input wire P2_Set_ILDrlIXtdl_B,   // 0010 0000
        input wire P2_Set_ILDrlIXtdl_C,   // 0010 0001
        input wire P2_Set_ILDrlIXtdl_D,   // 0010 0010
        input wire P2_Set_ILDrlIXtdl_E,   // 0010 0011
        input wire P2_Set_ILDrlIXtdl_H,   // 0010 0100
        input wire P2_Set_ILDrlIXtdl_L,   // 0010 0101
        input wire P2_Set_ILDrlIXtdl_A,   // 0010 0111
        input wire P2_Set_ILDrlIYtdl_B,   // 0011 0000
        input wire P2_Set_ILDrlIYtdl_C,   // 0011 0001
        input wire P2_Set_ILDrlIYtdl_D,   // 0011 0010
        input wire P2_Set_ILDrlIYtdl_E,   // 0011 0011
        input wire P2_Set_ILDrlIYtdl_H,   // 0011 0100
        input wire P2_Set_ILDrlIYtdl_L,   // 0011 0101
        input wire P2_Set_ILDrlIYtdl_A,   // 0011 0111
        input wire P2_Set_ILDlIXtdln_0,   // 1111 1010
        input wire P2_Set_ILDlIXtdln_1,   // 1111 1011
        input wire P2_Set_ILDlIYtdln_0,   // 1111 1110
        input wire P2_Set_ILDlIYtdln_1,   // 1111 1111
        input wire P2_Set_ILDddnn_BC_0,   // 0110 0000
        input wire P2_Set_ILDddnn_DE_0,   // 0110 0001
        input wire P2_Set_ILDddnn_HL_0,   // 0110 0010
        input wire P2_Set_ILDddnn_SP_0,   // 0110 0011
        input wire P2_Set_ILDddnn_BC_1,   // 0110 0100
        input wire P2_Set_ILDddnn_DE_1,   // 0110 0101
        input wire P2_Set_ILDddnn_HL_1,   // 0110 0110
        input wire P2_Set_ILDddnn_SP_1,   // 0110 0111
        input wire P2_Set_ILDddlnnl_BC_0, // 0111 0000
        input wire P2_Set_ILDddlnnl_DE_0, // 0111 0001
        input wire P2_Set_ILDddlnnl_HL_0, // 0111 0010
        input wire P2_Set_ILDddlnnl_SP_0, // 0111 0011
        input wire P2_Set_ILDddlnnl_BC_1, // 0111 0100
        input wire P2_Set_ILDddlnnl_DE_1, // 0111 0101
        input wire P2_Set_ILDddlnnl_HL_1, // 0111 0110
        input wire P2_Set_ILDddlnnl_SP_1, // 0111 0111
        input wire P2_Set_ILDlnnlIX_0,    // 0010 1010
        input wire P2_Set_ILDlnnlIX_1,    // 0010 1011
        input wire P2_Set_ILDlnnlIY_0,    // 0010 1110
        input wire P2_Set_ILDlnnlIY_1,    // 0010 1111
        input wire P2_Set_IADDAn,         // 1111 0000
        input wire P2_Set_IADCAn,         // 1111 0100
        input wire P2_Set_ISUBAn,         // 1111 0001
        input wire P2_Set_ISBCAn,         // 1111 0101
        input wire P2_Set_IANDn,          // 1111 0010
        input wire P2_Set_IORn,           // 1111 0011
        input wire P2_Set_IXORn,          // 1111 0110
        input wire P2_Set_ICPn,           // 1111 0111
        input wire P2_Set_IINClIXtdl,     // 1111 1000
        input wire P2_Set_IINClIYtdl,     // 1111 1001
        input wire P2_Set_IDEClIXtdl,     // 1111 1100
        input wire P2_Set_IDEClIYtdl,     // 1111 1101
        input wire P2_Set_IJRe,           // 0011 1000
        input wire P2_Set_IJRCe,          // 0011 1010
        input wire P2_Set_IJRNCe,         // 0011 1011
        input wire P2_Set_IJRZe,          // 0011 1110
        input wire P2_Set_IJRNZe,         // 0011 1111
        input wire P2_Set_IINAlnl,        // 0010 1000
        input wire P2_Set_IOUTlnlA,       // 0010 1001
        input wire P2_Set_IDJNZe,         // 0011 1100
        output wire encoded5
    );

    // or

    assign encoded5 = (P2_Set_ILDrlIXtdl_B | P2_Set_ILDrlIXtdl_C | P2_Set_ILDrlIXtdl_D | P2_Set_ILDrlIXtdl_E | P2_Set_ILDrlIXtdl_H | P2_Set_ILDrlIXtdl_L | P2_Set_ILDrlIXtdl_A | P2_Set_ILDrlIYtdl_B | P2_Set_ILDrlIYtdl_C | P2_Set_ILDrlIYtdl_D | P2_Set_ILDrlIYtdl_E | P2_Set_ILDrlIYtdl_H | P2_Set_ILDrlIYtdl_L | P2_Set_ILDrlIYtdl_A | P2_Set_ILDlIXtdln_0 | P2_Set_ILDlIXtdln_1 | P2_Set_ILDlIYtdln_0 | P2_Set_ILDlIYtdln_1 | P2_Set_ILDddnn_BC_0 | P2_Set_ILDddnn_DE_0 | P2_Set_ILDddnn_HL_0 | P2_Set_ILDddnn_SP_0 | P2_Set_ILDddnn_BC_1 | P2_Set_ILDddnn_DE_1 | P2_Set_ILDddnn_HL_1 | P2_Set_ILDddnn_SP_1 | P2_Set_ILDddlnnl_BC_0 | P2_Set_ILDddlnnl_DE_0 | P2_Set_ILDddlnnl_HL_0 | P2_Set_ILDddlnnl_SP_0 | P2_Set_ILDddlnnl_BC_1 | P2_Set_ILDddlnnl_DE_1 | P2_Set_ILDddlnnl_HL_1 | P2_Set_ILDddlnnl_SP_1 | P2_Set_ILDlnnlIX_0 | P2_Set_ILDlnnlIX_1 | P2_Set_ILDlnnlIY_0 | P2_Set_ILDlnnlIY_1 | P2_Set_IADDAn | P2_Set_IADCAn | P2_Set_ISUBAn | P2_Set_ISBCAn | P2_Set_IANDn | P2_Set_IORn | P2_Set_IXORn | P2_Set_ICPn | P2_Set_IINClIXtdl | P2_Set_IINClIYtdl | P2_Set_IDEClIXtdl | P2_Set_IDEClIYtdl | P2_Set_IJRe | P2_Set_IJRCe | P2_Set_IJRNCe | P2_Set_IJRZe | P2_Set_IJRNZe | P2_Set_IINAlnl | P2_Set_IOUTlnlA | P2_Set_IDJNZe);


endmodule