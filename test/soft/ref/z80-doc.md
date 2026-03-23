---
title: NORだけでZ80互換CPUをつくる 〜 仕様決め 〜
description: NORゲートだけでCPUをつくるため、Z80の仕様を確認し、どんなふうに回路をつくればちゃんと動作しそうかの仕様決めをしました
slug: norz_3
thumbnail_url: "https://media.yamanekovillage.com/norz_3"
category: create
createdAt: 2024/08/25
modifiedAt: 2025/06/13
writer: 山椒ねこまんま
draft: false
---

1ヶ月ほどかかってようやく仕様が決まりました。いや〜長かった。202コも命令があるのでなかなか大変でしたよ。

もっとも、まだ実際に回路をつくってテストしたわけではないのでこれから変更される可能性もあるのですがね。

なお、仕様決定にあたり以下の本やページを参考にしました。とても参考になりました。ありがとうございます。\
{{< link
    "https://ndlsearch.ndl.go.jp/books/R100000002-I000001418670"
    "https://ndlsearch.ndl.go.jp/books/R100000002-I000001418670">}}\
{{< link
    "http://www.zilog.com/docs/z80/um0080.pdf"
    "http://www.zilog.com/docs/z80/um0080.pdf">}}\
{{< link
    "https://www.zilog.com/docs/z80/ps0178.pdf"
    "https://www.zilog.com/docs/z80/ps0178.pdf">}}\
{{< link
    "http://www.z80.info/zip/z80-interrupts.pdf"
    "http://www.z80.info/zip/z80-interrupts.pdf">}}\
{{< link
    "http://www.kazumi-kikou.com/pdf/TMPZ84C00AP.pdf"
    "http://www.kazumi-kikou.com/pdf/TMPZ84C00AP.pdf">}}\
{{< link
    "http://www.maroon.dti.ne.jp/youkan/mz700/z80cycle.html"
    "http://www.maroon.dti.ne.jp/youkan/mz700/z80cycle.html">}}\
{{< link
    "http://mydocuments.g2.xrea.com/html/p6/z80ref.html"
    "http://mydocuments.g2.xrea.com/html/p6/z80ref.html">}}

{{< toc >}}
インターフェース{#interface}
レジスタ{#register}
  - 公式{#rg-official}
  - 非公式{#rg-unofficial}
フリップフロップ{#flipflop}
  - 公式{#ff-official}
  - 非公式{#ff-unofficial}
パスフラグ{#pathflag}
  - レジスタ{#pf-pr}
  - フラグ{#pf-pf}
  - フリップフロップ{#pf-p2}
  - ALU{#pf-pa}
  - インターフェース{#pf-pi}
  - 半遅延インターフェース{#pf-phi}
  - 遅延{#pf-pai}
ALU{#alu}
  - 演算{#alu-operation}
  - 出力バス{#alu-bus}
デコーダ{#decoder}
  - 標準サイクル{#basecycle}
    - M1{#bc-m1}
    - MR{#bc-mr}
    - MA{#bc-ma}
    - R{#bc-r}
    - RA{#bc-ra}
    - W{#bc-w}
    - I{#bc-i}
    - O{#bc-o}
  - 割り込みサイクル{#interruptcycle}
    - マスク可能割り込み{#ic-int}
    - マスク不能割り込み{#ic-nmi}
    - バス要求{#ic-busrq}
    - リセット{#ic-reset}
  - 命令{#instruction}
    - 8bitデータ移動{#in-8ld}
      - LD r,r’{#in-LDrr}
      - LD r,n{#in-LDrn}
      - LD r,(HL){#in-LDrqHLp}
      - LD r,(IX+d){#in-LDrqIXtdp}
      - LD r,(IY+d){#in-LDrqIYtdp}
      - LD (HL),r{#in-LDqHLpr}
      - LD (IX+d),r{#in-LDqIXtdpr}
      - LD (IY+d),r{#in-LDqIYtdpr}
      - LD (HL),n{#in-LDqHLpn}
      - LD (IX+d),n{#in-LDqIXtdpn}
      - LD (IY+d),n{#in-LDqIYtdpn}
      - LD A,(BC){#in-LDAqBCp}
      - LD A,(DE){#in-LDAqDEp}
      - LD A,(nn){#in-LDAqnnp}
      - LD (BC),A{#in-LDqBCpA}
      - LD (DE),A{#in-LDqDEpA}
      - LD (nn),A{#in-LDqnnpA}
      - LD A,I{#in-LDAI}
      - LD A,R{#in-LDAR}
      - LD I,A{#in-LDIA}
      - LD R,A{#in-LDRA}
    - 16bitデータ移動{#in-16ld}
      - LD dd,nn{#in-LDddnn}
      - LD IX,nn{#in-LDIXnn}
      - LD IY,nn{#in-LDIYnn}
      - LD HL,(nn){#in-LDHLqnnp}
      - LD dd,(nn){#in-LDddqnnp}
      - LD IX,(nn){#in-LDIXqnnp}
      - LD IY,(nn){#in-LDIYqnnp}
      - LD (nn),HL{#in-LDqnnpHL}
      - LD (nn),dd{#in-LDqnnpdd}
      - LD (nn),IX{#in-LDqnnpIX}
      - LD (nn),IY{#in-LDqnnpIY}
      - LD SP,HL{#in-LDSPHL}
      - LD SP,IX{#in-LDSPIX}
      - LD SP,IY{#in-LDSPIY}
      - PUSH qq{#in-PUSHqq}
      - PUSH IX{#in-PUSHIX}
      - PUSH IY{#in-PUSHIY}
      - POP qq{#in-POPqq}
      - POP IX{#in-POPIX}
      - POP IY{#in-POPIY}
    - 交換・ブロック転送および検索{#in-ex}
      - EX DE,HL{#in-EXDEHL}
      - EX AF,A’F’{#in-EXAFAF}
      - EXX{#in-EXX}
      - EX (SP),HL{#in-EXqSPpHL}
      - EX (SP),IX{#in-EXqSPpIX}
      - EX (SP),IY{#in-EXqSPpIY}
      - LDI{#in-LDI}
      - LDIR{#in-LDIR}
      - LDD{#in-LDD}
      - LDDR{#in-LDDR}
      - CPI{#in-CPI}
      - CPIR{#in-CPIR}
      - CPD{#in-CPD}
      - CPDR{#in-CPDR}
    - 8bit算術・論理演算{#in-8ari}
      - ADD A,r{#in-ADDAr}
      - ADD A,n{#in-ADDAn}
      - ADD A,(HL){#in-ADDAqHLp}
      - ADD A,(IX+d){#in-ADDAqIXtdp}
      - ADD A,(IY+d){#in-ADDAqIYtdp}
      - ADC A,r{#in-ADCAr}
      - ADC A,n{#in-ADCAn}
      - ADC A,(HL){#in-ADCAqHLp}
      - ADC A,(IX+d){#in-ADCAqIXtdp}
      - ADC A,(IY+d){#in-ADCAqIYtdp}
      - SUB A,r{#in-SUBAr}
      - SUB A,n{#in-SUBAn}
      - SUB A,(HL){#in-SUBAqHLp}
      - SUB A,(IX+d){#in-SUBAqIXtdp}
      - SUB A,(IY+d){#in-SUBAqIYtdp}
      - SBC A,r{#in-SBCAr}
      - SBC A,n{#in-SBCAn}
      - SBC A,(HL){#in-SBCAqHLp}
      - SBC A,(IX+d){#in-SBCAqIXtdp}
      - SBC A,(IY+d){#in-SBCAqIYtdp}
      - AND A,r{#in-ANDAr}
      - AND A,n{#in-ANDAn}
      - AND A,(HL){#in-ANDAqHLp}
      - AND A,(IX+d){#in-ANDAqIXtdp}
      - AND A,(IY+d){#in-ANDAqIYtdp}
      - OR A,r{#in-ORAr}
      - OR A,n{#in-ORAn}
      - OR A,(HL){#in-ORAqHLp}
      - OR A,(IX+d){#in-ORAqIXtdp}
      - OR A,(IY+d){#in-ORAqIYtdp}
      - XOR A,r{#in-XORAr}
      - XOR A,n{#in-XORAn}
      - XOR A,(HL){#in-XORAqHLp}
      - XOR A,(IX+d){#in-XORAqIXtdp}
      - XOR A,(IY+d){#in-XORAqIYtdp}
      - CP A,r{#in-CPAr}
      - CP A,n{#in-CPAn}
      - CP A,(HL){#in-CPAqHLp}
      - CP A,(IX+d){#in-CPAqIXtdp}
      - CP A,(IY+d){#in-CPAqIYtdp}
      - INC r{#in-INCr}
      - INC (HL){#in-INCqHLp}
      - INC (IX+d){#in-INCqIXtdp}
      - INC (IY+d){#in-INCqIYtdp}
      - DEC r{#in-DECr}
      - DEC (HL){#in-DECqHLp}
      - DEC (IX+d){#in-DECqIXtdp}
      - DEC (IY+d){#in-DECqIYtdp}
    - 汎用算術演算およびCPU制御{#in-gpa}
      - DAA{#in-DAA}
      - CPL{#in-CPL}
      - NEG{#in-NEG}
      - CCF{#in-CCF}
      - SCF{#in-SCF}
      - NOP{#in-NOP}
      - HALT{#in-HALT}
      - DI{#in-DI}
      - EI{#in-EI}
      - IM 0{#in-IM0}
      - IM 1{#in-IM1}
      - IM 2{#in-IM2}
    - 16bit算術演算{#in-16ari}
      - ADD HL,ss{#in-ADDHLss}
      - ADC HL,ss{#in-ADCHLss}
      - SBC HL,ss{#in-SBCHLss}
      - ADD IX,pp{#in-ADDIXpp}
      - ADD IY,rr{#in-ADDIYrr}
      - INC ss{#in-INCss}
      - INC IX{#in-INCIX}
      - INC IY{#in-INCIY}
      - DEC ss{#in-DECss}
      - DEC IX{#in-DECIX}
      - DEC IY{#in-DECIY}
    - 循環および桁移動{#in-rot}
      - RLCA{#in-RLCA}
      - RLA{#in-RLA}
      - RRCA{#in-RRCA}
      - RRA{#in-RRA}
      - RLC r{#in-RLCr}
      - RLC (HL){#in-RLCqHLp}
      - RLC (IX+d){#in-RLCqIXtdp}
      - RLC (IY+d){#in-RLCqIYtdp}
      - RL r{#in-RLr}
      - RL (HL){#in-RLqHLp}
      - RL (IX+d){#in-RLqIXtdp}
      - RL (IY+d){#in-RLqIYtdp}
      - RRC r{#in-RRCr}
      - RRC (HL){#in-RRCqHLp}
      - RRC (IX+d){#in-RRCqIXtdp}
      - RRC (IY+d){#in-RRCqIYtdp}
      - RR r{#in-RRr}
      - RR (HL){#in-RRqHLp}
      - RR (IX+d){#in-RRqIXtdp}
      - RR (IY+d){#in-RRqIYtdp}
      - RLC r{#in-RLCr}
      - RLC (HL){#in-RLCqHLp}
      - RLC (IX+d){#in-RLCqIXtdp}
      - RLC (IY+d){#in-RLCqIYtdp}
      - SLA r{#in-SLAr}
      - SLA (HL){#in-SLAqHLp}
      - SLA (IX+d){#in-SLAqIXtdp}
      - SLA (IY+d){#in-SLAqIYtdp}
      - SRA r{#in-SRAr}
      - SRA (HL){#in-SRAqHLp}
      - SRA (IX+d){#in-SRAqIXtdp}
      - SRA (IY+d){#in-SRAqIYtdp}
      - SRL r{#in-SRLr}
      - SRL (HL){#in-SRLqHLp}
      - SRL (IX+d){#in-SRLqIXtdp}
      - SRL (IY+d){#in-SRLqIYtdp}
      - RLD{#in-RLD}
      - RRD{#in-RRD}
    - bit操作および判定{#in-bit}
      - BIT b,r{#in-BITbr}
      - BIT b,(HL){#in-BITbqHLp}
      - BIT b,(IX+d){#in-BITbqIXtdp}
      - BIT b,(IY+d){#in-BITbqIYtdp}
      - SET b,r{#in-SETbr}
      - SET b,(HL){#in-SETbqHLp}
      - SET b,(IX+d){#in-SETbqIXtdp}
      - SET b,(IY+d){#in-SETbqIYtdp}
      - RES b,r{#in-RESbr}
      - RES b,(HL){#in-RESbqHLp}
      - RES b,(IX+d){#in-RESbqIXtdp}
      - RES b,(IY+d){#in-RESbqIYtdp}
    - 飛び越し命令{#in-jmp}
      - JP nn{#in-JPnn}
      - JP cc,nn{#in-JPccnn}
      - JR e{#in-JRe}
      - JR C,e{#in-JRCe}
      - JR NC,e{#in-JRNCe}
      - JR Z,e{#in-JRZe}
      - JR NZ,e{#in-JRNZe}
      - JP (HL){#in-JPqHLp}
      - JP (IX){#in-JPqIXp}
      - JP (IY){#in-JPqIYp}
      - DJNZ e{#in-DJNZe}
    - サブルーチン接続および戻り命令{#in-sub}
      - CALL nn{#in-CALLnn}
      - CALL cc,nn{#in-CALLccnn}
      - RET{#in-RET}
      - RET cc{#in-RETcc}
      - RETI{#in-RETI}
      - RETN{#in-RETN}
      - RST p{#in-RSTp}
    - 入力および出力命令{#in-io}
      - IN A,(n){#in-INAqnp}
      - IN r,(C){#in-INrqCp}
      - INI{#in-INI}
      - INIR{#in-INIR}
      - IND{#in-IND}
      - INDR{#in-INDR}
      - OUT (n),A{#in-OUTqnpA}
      - OUT (C),r{#in-OUTqCpr}
      - OUTI{#in-OUTI}
      - OTIR{#in-OTIR}
      - OUTD{#in-OUTD}
      - OTDR{#in-OTDR}
命令分布{#instuructiontable}
  - X1{#it-x1}
  - XIX{#it-xix}
  - XIX4{#it-xix4}
  - XIY{#it-xiy}
  - XIY4{#it-xiy4}
  - XOTR{#it-xotr}
  - XBIT{#it-xbit}
{{< /toc >}}

## インターフェース{#interface}

{{<table5HM>}}
A: 種類
B: io
C: とりうる値
D: デフォルト値
E: 名前
items:
    - a: アドレスバス
      b: out
      c: 1/0/Z
      d: Z
      e: A0~A15
    - a: データバス
      b: in/out
      c: 1/0/Z
      d: Z
      e: D0~D7
    - a: バス制御
      b: in
      c: 
      d: 
      e: /BUSRQ
    - a: 
      b: out
      c: 1/0
      d: 1
      e: BUSAK
    - a: 主記憶制御
      b: out
      c: 1/0/Z
      d: 1
      e: /MREQ
    - a: 
      b: out
      c: 1/0/Z
      d: 1
      e: /RD
    - a: 
      b: out
      c: 1/0/Z
      d: 1
      e: /WR
    - a: 
      b: out
      c: 1/0
      d: 1
      e: /RFSH
    - a: 入出力制御
      b: out
      c: 1/0/Z
      d: 1
      e: /IORQ
    - a: その他の制御
      b: out
      c: 1/0
      d: 1
      e: /M1
    - a: 
      b: in
      c: 
      d: 
      e: /RESET
    - a: 
      b: in
      c: 
      d: 
      e: /WAIT
    - a: 
      b: out
      c: 1/0
      d: 1
      e: /HALT
    - a: 割り込み入力
      b: in
      c: 
      d: 
      e: /NMI
    - a: 
      b: in
      c: 
      d: 
      e: /INT
    - a: クロック
      b: in
      c: 
      d: 
      e: /CLK
    - a: 電源
      b: in
      c: 
      d: 
      e: VCC(5V)
    - a: 
      b: in
      c: 
      d: 
      e: GND
{{</table5HM>}}

<br>
{{<line>}}

## レジスタ{#register}

## 公式レジスタ{#rg-official}

### アキュムレータ (A)

8bit

EX系命令で交換できる

### フラグレジスタ (F)

8bit

EX系命令で交換できる\
フラグ書き込みが可能

{{<table8HM>}}
A: 第7bit
B: 第6bit
C: 第5bit
D: 第4bit
E: 第3bit
F: 第2bit
G: 第1bit
H: 第0bit
items:
    - a: S
      b: Z
      c: (X)
      d: H
      e: (Y)
      f: P/V
      g: "N"
      h: C
{{</table8HM>}}

S: ALUの結果が負\
Z: ALUの結果が0\
H: ALUにおいてハーフキャリー/ハーフボローが発生\
P: ALUの結果が偶パリティ\
V: ALUにおいてオーバーフローが発生\
N: ALUで減算を実行\
C: ALUにおいてキャリー/ボローが発生

キャリー・ボロー・ハーフキャリー・ハーフボロー・パリティ・オーバーフローについてはALUの項で解説します。

### 汎用レジスタ (B,C,D,E,H,L)

8bit

EX系命令で交換できる

### 裏レジスタ (A',F',B',C',D',E',H',L')

8bit

EX系命令で交換できる

### プログラムカウンタ (PC)

16bit

インクリメント可能

### スタックポインタ (SP)

16bit

インクリメント・デクリメント可能

### インデックスレジスタ (IX,IY)

16bit

### 割り込み番地指定レジスタ (I)

8bit

### リフレッシュレジスタ (R)

8bit

インクリメントが可能(ただし、第7bitは不変)

## 非公式レジスタ{#rg-unofficial}

### 命令1バイト経過Tサイクル (XPT)

5bit

クロックに合わせて自動でインクリメントしていく\
Write不可\
HaltとResetが可能

### データレジスタ (Dt,Dtex)

8bit

### 位相半ずらしデータレジスタ (Dtcs)

8bit

クロックがhighのときに、Dinから読み込みできる\
Write不可

### 命令レジスタ (OP,OPold)

8bit

WriteはOPのみ可能(lowが入る)\
OPからOPoldへのスライドが可能

<br>
{{<line>}}

## フリップフロップ{#flipflop}

## 公式フリップフロップ{#ff-official}

### IFF1/2

割り込み許可用

### IMFa/b

IM 0/1/2 で指定する割り込みモード用

{{<table3HM>}}
A: IMFa
B: IMFb
C: モード
items:
    - a: 0
      b: 0
      c: 0
    - a: 0
      b: 1
      c: NOT USED
    - a: 1
      b: 0
      c: 1
    - a: 1
      b: 1
      c: 2
{{</table3HM>}}

## 非公式フリップフロップ{#ff-unofficial}

### 検出系(T)

TINT:2 負論理 ↓入力と↑入力がある ↑入力は出力を半クロックずらす 使用時はAND\
TNMI:2 負論理 ↓入力と↑入力がある ↑入力は出力を半クロックずらす 使用時はAND\
TWAIT:1 負論理 ↑入力 寿命1サイクル\
TRSET:3 負論理 3サイクルカウント用 使用は3つ目

### 保持系(L)

LHALT: if(LHALT=1)→PI_Flag_HALT

### サイクル系(C)

XPTと組み合わせてパスフラグを出力する

CM1\
CMR\
CMA\
CBUSRQ\
CRESET\
CNMI\
CINT0\
CINT0_RST\
CINT0_CALL\
CINT1\
CINT2

### M1型命令系(X)

XIX(11 011 101): 1\
XIX4_0/1(XIX→11 001 011): 2\
XIY(11 111 101): 1\
XIY4_0/1(XIY→11 001 011): 2\
XOTR(11 101 101): 1\
XBIT(11 001 011): 1

### MR型命令系(I)

XPTと組み合わせてパスフラグを出力する\
全156のパスフラグを構成するため、8つのフリップフロップを使用

ILDrn_A/B/C/D/E/H/L: 7\
ILDr(IX+d)_A/B/C/D/E/H/L: 7\
ILDr(IY+d)_A/B/C/D/E/H/L: 7\
ILD(IX+d)r_A/B/C/D/E/H/L: 7\
ILD(IY+d)r_A/B/C/D/E/H/L: 7\
ILD(HL)n: 1\
ILD(IX+d)n_0/1: 2\
ILD(IY+d)n_0/1: 2\
ILDA(nn)_0/1: 2\
ILD(nn)A_0/1: 2\
ILDddnn_BC/DE/HL/SP_0/1: 8\
ILDIXnn_0/1: 2\
ILDIYnn_0/1: 2\
ILDHL(nn)_0/1: 2\
ILDdd(nn)_BC/DE/HL/SP_0/1: 8\
ILDIX(nn)_0/1: 2\
ILDIY(nn)_0/1: 2\
ILD(nn)HL_0/1: 2\
ILD(nn)dd_BC/DE/HL/SP_0/1: 8\
ILD(nn)IX_0/1: 2\
ILD(nn)IY_0/1: 2\
IADDAn: 1\
IADDA(IX+d): 1\
IADDA(IY+d): 1\
IADCAn: 1\
IADCA(IX+d): 1\
IADCA(IY+d): 1\
ISUBAn: 1\
ISUBA(IX+d): 1\
ISUBA(IY+d): 1\
ISBCAn: 1\
ISBCA(IX+d): 1\
ISBCA(IY+d): 1\
IANDn: 1\
IAND(IX+d): 1\
IAND(IY+d): 1\
IORn: 1\
IOR(IX+d): 1\
IOR(IY+d): 1\
IXORn: 1\
IXOR(IX+d): 1\
IXOR(IY+d): 1\
ICPn: 1\
ICP(IX+d): 1\
ICP(IY+d): 1\
IINC(IX+d): 1\
IINC(IY+d): 1\
IDEC(IX+d): 1\
IDEC(IY+d): 1\
IJPnn_0/1: 2\
IJPccnn_0/1/2/3/4/5/6/7_0/1: 16\
IJRe: 1\
IJRCe: 1\
IJRNCe: 1\
IJRZe: 1\
IJRNZe: 1\
IDJNZe: 1\
ICALLnn_0/1: 2\
ICALLccnn_0/1/2/3/4/5/6/7_0/1: 16\
IINA(n): 1\
IOUT(n)A: 1

![ITABLE](https://media.yamanekovillage.com/norz_3_itable.webp)

<br>
{{<line>}}

## パスフラグ{#pathflag}

動作を決定する正負状態を表すものを言いたかったのですが、 **フラグ** という言葉を使えなかったのでパスフラグとでも呼称しておきます。

## レジスタ (PR){#pf-pr}

### 書き込み

Write_A: high\
Write_B: high\
Write_C: low\
Write_D: high\
Write_E: low\
Write_H: high\
Write_L: low\
Write_PC_high\
Write_PC_low\
Write_SP_high\
Write_SP_low\
Write_IX_high\
Write_IX_low\
Write_IY_high\
Write_IY_low\
Write_Dt: low\
Write_Dtex: high\
Write_R: low\
Write_I: high\
Write_OP: low InvertInの影響を受けない

### その他

Ex_AF_A’F’: AF↔︎A'F'\
Ex_DE_HL: DE↔︎HL\
Exx: BCDEHL↔︎B'C'D'E'H'L'\
Inc_PC\
Inc_SP\
Inc_R: R_7は不変\
Dec_SP\
Reset_XPT\
Halt_XPT\
SlideOP(OP→OPold)

## フラグ (PF){#pf-pf}

### 書き込み

いずれかが1の時、X<-ALU_5,Y<-ALU_3

Write_S\
Write_Z\
Write_H\
Write_P/V\
Write_N\
Write_C

### 入力選択

Select_S_bitZ\
Select_Z_bitZ\
Select_H_bitZ\
Select_P/V_bitZ\
Select_N_bitZ\
Select_C_bitZ

## フリップフロップ (P2){#pf-p2}

### 割り込み公式

Set_IFF1\
Set_IFF2\
Reset_IFF1\
Reset_IFF2\
EvacuateIFF: IFF2←IFF1\
RestoreIFF: IFF1←IFF2\
IM0\
IM1\
IM2

### 検出系(T)

Reset_TNMI: TNMI←1\
Reset_TINT: TINT←1\
Reset_TRESET TRESET_0/1/2←1

### 保持系(L)

Set_LHALT\
Reset_LHALT

### サイクル系(C)

Set_CM1\
Set_CMR\
Set_CMA\
Set_CBUSRQ\
Set_CRESET\
Set_CNMI\
Set_CINT0\
Set_CINT0_RST\
Set_CINT0_CALL\
Set_CINT1\
Set_CINT2\
Reset_CM1\
Reset_CMR\
Reset_CMA\
Reset_CBUSRQ\
Reset_CRESET\
Reset_CNMI\
Reset_CINT

### M1型命令系(X)

Set_XIX\
Set_XIX4_0/1\
Set_XIY\
Set_XIY4_0/1\
Set_XOTR\
Set_XBIT\
Reset_XIX\
Reset_XIX4\
Reset_XIY\
Reset_XIY4\
Reset_XOTR\
Reset_XBIT

### MR型命令系(I)

Set_ILDrn_A/B/C/D/E/H/L\
Set_ILDr(IX+d)_A/B/C/D/E/H/L\
Set_ILDr(IY+d)_A/B/C/D/E/H/L\
Set_ILD(IX+d)r_A/B/C/D/E/H/L\
Set_ILD(IY+d)r_A/B/C/D/E/H/L\
Set_ILD(HL)n\
Set_ILD(IX+d)n_0/1\
Set_ILD(IY+d)n_0/1\
Set_ILDA(nn)_0/1\
Set_ILD(nn)A_0/1\
Set_ILDddnn_BC/DE/HL/SP_0/1\
Set_ILDIXnn_0/1\
Set_ILDIYnn_0/1\
Set_ILDHL(nn)_0/1\
Set_ILDdd(nn)_BC/DE/HL/SP_0/1\
Set_ILDIX(nn)_0/1\
Set_ILDIY(nn)_0/1\
Set_ILD(nn)HL_0/1\
Set_ILD(nn)dd_BC/DE/HL/SP_0/1\
Set_ILD(nn)IX_0/1\
Set_ILD(nn)IY_0/1\
Set_IADDAn\
Set_IADDA(IX+d)\
Set_IADDA(IY+d)\
Set_IADCAn\
Set_IADCA(IX+d)\
Set_IADCA(IY+d)\
Set_ISUBAn\
Set_ISUBA(IX+d)\
Set_ISUBA(IY+d)\
Set_ISBCAn\
Set_ISBCA(IX+d)\
Set_ISBCA(IY+d)\
Set_IANDn\
Set_IAND(IX+d)\
Set_IAND(IY+d)\
Set_IORn\
Set_IOR(IX+d)\
Set_IOR(IY+d)\
Set_IXORn\
Set_IXOR(IX+d)\
Set_IXOR(IY+d)\
Set_ICPn\
Set_ICP(IX+d)\
Set_ICP(IY+d)\
Set_IINC(IX+d)\
Set_IINC(IY+d)\
Set_IDEC(IX+d)\
Set_IDEC(IY+d)\
Set_IJPnn_0/1\
Set_IJPccnn_0/1/2/3/4/5/6/7_0/1\
Set_IJRe\
Set_IJRCe\
Set_IJRNCe\
Set_IJRZe\
Set_IJRNZe\
Set_IDJNZe\
Set_ICALLnn_0/1\
Set_ICALLccnn_0/1/2/3/4/5/6/7_0/1\
Set_IINA(n)\
Set_IOUT(n)A\
Reset_ITABLE

### その他

Reset_ALLUNOFFICIALFF: CRESET以外の非公式フリップフロップをオールクリアする

## ALU (PA){#pf-pa}

### 入力

Select_A_high\
Select_B_high\
Select_C_high\
Select_D_high\
Select_E_high\
Select_H_high\
Select_L_high\
Select_Dt_high\
Select_BC_high\
Select_DE_high\
Select_HL_high\
Select_PC_high\
Select_SP_high\
Select_IX_high\
Select_IY_high\
Select_0x0_high\
Select_0x1_high\
Select_A_low\
Select_F_low\
Select_B_low\
Select_C_low\
Select_D_low\
Select_E_low\
Select_H_low\
Select_L_low\
Select_Dt_low\
Select_Dtcs_low\
Select_Din_low\
Select_R_low\
Select_I_low\
Select_OP_low\
Select_BC_low\
Select_DE_low\
Select_HL_low\
Select_PC_low\
Select_SP_low\
Select_IX_low\
Select_IY_low\
Select_IOP_low\
Select_OPOPold_low\
Select_0xffOP_low\
Select_OPxx_low\
Select_0x0_low\
Select_0x1_low\
Select_0x8_low\
Select_0x10_low\
Select_0x18_low\
Select_0x20_low\
Select_0x28_low\
Select_0x30_low\
Select_0x38_low\
Select_0x66_low\
Select_0x99_low\
Select_0x06_low\
Select_0x60_low\
Select_0x2_low\
Select_0x4_low\
Select_0x40_low\
Select_0x80_low

### 演算

NOP\
ADD\
ADC\
SUB\
SBC\
AND\
NLAND\
OR\
XOR\
NOT\
RLC\
RL\
RRC\
RR\
SLA\
SRA\
SRL\
RLD\
RRD

## インターフェース (PI){#pf-pi}

### トライステート

Activate_Ad_high\
Activate_Ad_low\
Activate_Dt\
Nullify_MREQ\
Nullify_RD\
Nullify_WR\
Nullify_IORQ

### アドレスバス

SelectAd_PC\
SelectAd_SP\
SelectAd_BC\
SelectAd_DE\
SelectAd_IR\
SelectAd_HL\
SelectAd_DtexDt\
SelectAd_OPOPold\
SelectAd_ALU\
SelectAd_AOP

### データバス

SelectDt_PC_high\
SelectDt_PC_low\
SelectDt_IX_high\
SelectDt_IX_low\
SelectDt_IY_high\
SelectDt_IY_low\
SelectDt_A\
SelectDt_F\
SelectDt_B\
SelectDt_C\
SelectDt_D\
SelectDt_E\
SelectDt_H\
SelectDt_L\
SelectDt_OP\
SelectDt_Dt\
SelectDt_Dtex

### その他

ReadDtcs: Dtcs←Din\
SelectAd+1: アドレスバスを+1する\
Flag_MREQ\
Flag_RD\
Flag_WR\
Flag_RFSH\
Flag_IORQ\
Flag_M1\
Flag_BUSACK\
Flag_HALT

## 半遅延インターフェース (PhI){#pf-phi}

Activate_Dt\
Flag_MREQ\
Flag_RD\
Flag_WR\
Flag_RFSH\
Flag_IORQ\
Flag_M1\
Flag_BUSACK

## 遅延 (Pa){#pf-pai}

Ophd (命令の先頭であることを表す)

<br>
{{<line>}}

## ALU{#alu}

## 演算{#alu-operation}

### NOP

### ADD

high + low

### ADC

high + low + Flag_C

### SUB

high + NOT(low) + 1

### SBC

high + NOT(low) + !Flag_C

### AND

### NLAND

{ high }AND{ NOT(low) }

### OR

### XOR

### NOT

### RLC

\[low_6,…,low_0,low_7\]

### RL

\[low_6,…,low_0,Flag_C\]

### RRC

\[low_0,low_7,…,low_1\]

### RR

\[Flag_C,low_7,…,low_1\]

### SLA

\[low_6,…,low_0,0\]

### SRA

\[low_7,low_7,…,low_1\]

### SRL

\[0,low_7,…,low_1\]

### RLD

low_0\~3→high_0\~3→high_4\~7→low_0\~3

### RRD

low_0\~3→high_4\~7→high_0\~3→low_0\~3

## 出力バス{#alu-bus}

{{<table2HR>}}
A: bit
B: 
items:
    - a: 0~15
      b: 演算結果
    - a: (16)
      b: 0
    - a: (17)
      b: 1
    - a: (18)
      b: IFF2{AND}CINT
    - a: 19
      b: is8bitEqual
    - a: 20
      b: notIs16bitEqual
    - a: 21
      b: HCY(4つめの全加算機から5つめへのcarry)
    - a: (22)
      b: ハーフボロー not(HCY)のこと
    - a: 23
      b: CY(8つ目からのキャリー)
    - a: 24
      b: isResultLow0
    - a: 25
      b: is8bitOverFlow
    - a: (26)
      b: ボロー
    - a: 27
      b: is8bitEvenParity
    - a: 28
      b: DAA_Flag_H
    - a: (29)
      b: Flag_S or Flag_C
    - a: (30)
      b: Flag_C
    - a: 31
      b: 16bitハーフキャリー(12から)
    - a: 32
      b: 16bitキャリー(16から)
    - a: 33
      b: is16bitOverFlow
    - a: 34
      b: isResult0
    - a: (35)
      b: 16bitハーフボロー
    - a: (36)
      b: 16bitボロー
    - a: 37
      b: inputLow0
    - a: 38
      b: inputLow7
    - a: 39
      b: DAACY
    - a: (40~55)
      b: Not(演算結果)
{{</table2HR>}}

### 19 is8bitEqual

\[low_0\~7\] == \[high_0\~7\]

### 21 ハーフキャリー

4つ目の全加算器からのキャリー

### 22 ハーフボロー

!ハーフキャリー

### 25 is8bitOverFlow

{{<table4HM>}}
A: high_7
B: low_7
C: result_7
D: V
items:
    - a: 1
      b: 1
      c: 0
      d: 1
    - a: 0
      b: 0
      c: 1
      d: 1
{{</table4HM>}}

SUB/SBC はNOT処理をしたlowで比較する

### 27 is8bitEvenParity

result_0\~7における bit**1** の数が偶数

### 28 DAA_Flag_H

{ high_4 }XOR{ result_4 }

### 39 DAACY

(ALU_High = 1xx1xxxx and CY4) or CY8

<br>
{{<line>}}

## デコーダ{#decoder}

![デコーダ](https://media.yamanekovillage.com/norz_3_decoder.webp)

正しい書き方がわからないので\... いまいち分かりにくいかもしれません。

## 標準サイクル{#basecycle}

### M1(4){#bc-m1}

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\PI_SelectAd_PC\PI_Flag_M1
- a: 
  b: 
  c: cl↓
  d: PhI_Flag_MREQ\PhI_Flag_RD
- a: 1(W)
  b: 
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\PI_SelectAd_PC\PI_Flag_M1\PI_Flag_MREQ\PI_Flag_RD\PA_Select_Din_low\PA_NOP\if(WAIT)→PR_Write_OP\　　　　　PI_SlideOP\if(/WAIT)→PR_Halt_XPT
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\PI_SelectAd_IR\PI_Flag_RFSH\(PR_Inc_PC)
- a: 
  b: 
  c: cl↓
  d: PhI_Flag_MREQ
- a: 3
  b: 
  c: cl↑
  d: P2_Reset_CM1\PI_Activate_Ad_high\PI_Activate_Ad_low\PI_SelectAd_IR\PI_Flag_RFSH\PR_Inc_R
- a: 
  b: 
  c: cl↓
  d: 
{{</table4R>}}

### MR (3){#bc-mr}

{{<table4R>}}
- a: 0
  b: MR
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\PI_SelectAd_PC
- a: 
  b: 
  c: cl↓
  d: PhI_Flag_MREQ\PhI_Flag_RD
- a: 1(W)
  b: 
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\PI_SelectAd_PC\if(/TWAIT)→PR_Halt_XPT
- a: 
  b: 
  c: cl↓
  d: PhI_Flag_MREQ\PhI_Flag_RD
- a: 2
  b: 
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\PI_SelectAd_PC\PI_Read_Dtcs\PR_SlideOP\PA_Select_Dtcs_low\PA_NOP\PR_Write_OP\P2_Reset_CMR\if(!CINT0_CALL)→PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
{{</table4R>}}

### MA (3){#bc-ma}

{{<table4R>}}
- a: 0
  b: MR
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\PI_SelectAd_PC
- a: 
  b: 
  c: cl↓
  d: PhI_Flag_MREQ\PhI_Flag_RD
- a: 1(W)
  b: 
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\PI_SelectAd_PC\if(/TWAIT)→PR_Halt_XPT
- a: 
  b: 
  c: cl↓
  d: PhI_Flag_MREQ\PhI_Flag_RD
- a: 2
  b: 
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\PI_SelectAd_PC\PI_Read_Dtcs\(PA_Select_???_high)\PA_Select_Dtcs_low\(PA_???)\(PR_Write_???)\(?PR_InvertIn)\PR_Inc_PC\P2_Reset_CMA
- a: 
  b: 
  c: cl↓
  d: 
{{</table4R>}}

### R (3){#bc-r}

{{<table4R>}}
- a: 0
  b: R
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\(PI_SelectAd_???)
- a: 
  b: 
  c: cl↓
  d: PhI_Flag_MREQ\PhI_Flag_RD
- a: 1(W)
  b: 
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\(PI_SelectAd_???)\if(/TWAIT)→PR_Halt_XPT
- a: 
  b: 
  c: cl↓
  d: PhI_Flag_MREQ\PhI_Flag_RD
- a: 2
  b: 
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\(PI_SelectAd_???)\PI_Read_Dtcs\PA_Select_Dtcs_low\PA_NOP\(PR_Write_???)\(?PR_InvertIn)
- a: 
  b: 
  c: cl↓
  d: 
{{</table4R>}}

### RA (3){#bc-ra}

{{<table4R>}}
- a: 0
  b: R
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\(PI_SelectAd_???)
- a: 
  b: 
  c: cl↓
  d: PhI_Flag_MREQ\PhI_Flag_RD
- a: 1(W)
  b: 
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\(PI_SelectAd_???)\if(/TWAIT)→PR_Halt_XPT
- a: 
  b: 
  c: cl↓
  d: PhI_Flag_MREQ\PhI_Flag_RD
- a: 2
  b: 
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\(PI_SelectAd_???)\PI_Read_Dtcs\(PA_Select_???_high)\PA_Select_Dtcs_low\(PA_???)\(PR_Write_???)\(?PR_InvertIn)
- a: 
  b: 
  c: cl↓
  d: 
{{</table4R>}}

### W (3){#bc-w}

{{<table4R>}}
- a: 0
  b: W
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\(PI_SelectAd_???)\(PI_SelectDt_???)
- a: 
  b: 
  c: cl↓
  d: PhI_Flag_MREQ\PhI_Activate_Dt
- a: 1(W)
  b: 
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\(PI_SelectAd_???)\PI_Activate_Dt\(PI_SelectDt_???)\if(/TWAIT)→PR_Halt_XPT
- a: 
  b: 
  c: cl↓
  d: PhI_Flag_MREQ\PhI_Flag_WR
- a: 2
  b: 
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\(PI_SelectAd_???)\PI_Activate_Dt\(PI_Select_Dt_???)
- a: 
  b: 
  c: cl↓
  d: 
{{</table4R>}}

### I (4){#bc-i}

{{<table4R>}}
- a: 0
  b: I
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\(PI_SelectAd_???)
- a: 
  b: 
  c: cl↓
  d: 
- a: 1
  b: 
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\(PI_SelectAd_???)\PI_Flag_IORQ\PI_Flag_RD
- a: 
  b: 
  c: cl↓
  d: 
- a: 2(W)
  b: 
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\(PI_SelectAd_???)\PI_Flag_IORQ\PI_Flag_RD\if(/TWAIT)→PR_Halt_XPT
- a: 
  b: 
  c: cl↓
  d: PhI_Flag_IORQ\PhI_Flag_RD
- a: 3
  b: 
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\(PI_SelectAd_???)\PI_Read_Dtcs\PA_Select_Dtcs_low\PA_NOP\(PR_Write_???)\(?PR_InvertIn)
- a: 
  b: 
  c: cl↓
  d: 
{{</table4R>}}

### O (4){#bc-o}

{{<table4R>}}
- a: 0
  b: O
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\(PI_SelectAd_???)\(PI_SelectDt_???)
- a: 
  b: 
  c: cl↓
  d: PhI_Activate_Dt
- a: 1
  b: 
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\(PI_SelectAd_???)\PI_Activate_Dt\(PI_SelectDt_???)\PI_Flag_IORQ\PI_Flag_WR
- a: 
  b: 
  c: cl↓
  d: 
- a: 2(W)
  b: 
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\(PI_SelectAd_???)\PI_Activate_Dt\(PI_SelectDt_???)\PI_Flag_IORQ\PI_Flag_WR\if(/TWAIT)→PR_Halt_XPT
- a: 
  b: 
  c: cl↓
  d: PhI_Flag_IORQ\PhI_Flag_WR
- a: 3
  b: 
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\(PI_SelectAd_???)\PI_Activate_Dt\(PI_SelectDt_???)
- a: 
  b: 
  c: cl↓
  d: 
{{</table4R>}}

## 割り込みサイクル{#interruptcycle}

### マスク可能割り込み{#ic-int}

IFF==1&&/TINT or CINT0,1,2

{{<table4R>}}
- a: 0
  b: 
  c: cl↑
  d: P2_Set_CINT0/1/2\P2_Reset_LHALT\P2_Reset_TINT\P2_Reset_IFF1\P2_Reset_IFF2\PI_Activate_Ad_high\PI_Activate_Ad_low\PI_SelectAd_PC\PI_Flag_M1
- a: 
  b: 
  c: cl↓
  d: 
- a: 1
  b: 
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\PI_SelectAd_PC\PI_Flag_M1
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\PI_SelectAd_PC\PI_Flag_M1
- a: 
  b: 
  c: cl↓
  d: PhI_Flag_IORQ
- a: 3(W)
  b: 
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\PI_SelectAd_PC\PI_Flag_M1\PI_Flag_IORQ\PA_Select_Din_low\PA_NOP\PR_Write_OP\if(/WAIT)→PR_Halt_XPT
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\PI_SelectAd_IR\PI_Flag_RFSH
- a: 
  b: 
  c: cl↓
  d: PhI_Flag_MREQ
- a: 5
  b: 
  c: cl↑
  d: PI_Activate_Ad_high\PI_Activate_Ad_low\PI_SelectAd_IR\PI_Flag_RFSH\PR_Inc_R\if(CINT0)→PI_Reset_CINT\　　　　　if(OP=11 ppp 111)→PI_Set_CINT0_RST\　　　　　if(OP=11 001 101)→PI_Set_CINT0_CALL
- a: 
  b: 
  c: cl↓
  d: 
{{</table4R>}}

**モード0 RST**

CINT0_RST

{{<table4R>}}
- a: 6
  b: 1
  c: cl↑
  d: PR_Dec_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high
- a: 
  b: 
  c: cl↓
  d: 
- a: 8(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high\PR_Dec_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 11(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 12
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_CINT\PI_SelectAd_SP\PI_SelectDt_PC_low\PA_Select_0x0/8/10/18/20/28/30/38_low\PA_NOP\PR_Write_PC_high\PR_Write_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

**モード0 CALL**

CINT0_CALL

{{<table4R>}}
- a: 6
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 12
  b: 1
  c: cl↑
  d: PR_Dec_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 13
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high
- a: 
  b: 
  c: cl↓
  d: 
- a: 14(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high
- a: 
  b: 
  c: cl↓
  d: 
- a: 15
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high\PR_Dec_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 16
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 17(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 18
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_CINT\PI_SelectAd_SP\PI_SelectDt_PC_low\PA_Select_OPOPold_low\PA_NOP\PR_Write_PC_high\PR_Write_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

**モード1**

CINT1

{{<table4R>}}
- a: 6
  b: 1
  c: cl↑
  d: PR_Dec_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high
- a: 
  b: 
  c: cl↓
  d: 
- a: 8(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high\PR_Dec_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 11(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 12
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_CINT\PI_SelectAd_SP\PI_SelectDt_PC_low\PA_Select_0x38_low\PA_NOP\PR_Write_PC_high\PR_Write_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

**モード2**

CINT2

{{<table4R>}}
- a: 6
  b: 1
  c: cl↑
  d: PR_Dec_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high
- a: 
  b: 
  c: cl↓
  d: 
- a: 8(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high\PR_Dec_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 11(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 12
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_CINT\PI_SelectAd_SP\PI_SelectDt_PC_low\PA_Select_IOP_low\PA_NOP\PR_Write_PC_high\PR_Write_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### マスク不能割り込み{#ic-nmi}

/TNMI or CNMI

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: P2_Set_CNMI\P2_Reset_TNMI\P2_Reset_LHALT\P2_EvacuateIFF\P2_Reset_IFF1
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 1
  c: cl↑
  d: PR_Dec_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high
- a: 
  b: 
  c: cl↓
  d: 
- a: 6(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high\PR_Dec_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_CNMI\PI_SelectAd_SP\PI_SelectDt_PC_low\PA_Select_0x66_low\PA_NOP\PR_Write_PC_high\PR_Write_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### バス要求{#ic-busrq}

/BUSRQ or CBUSRQ

{{<table4R>}}
- a: 0(W)
  b: 
  c: cl↑
  d: P2_Set_CBUSRQ\PI_Nullify_MREQ\PI_Nullify_RD\PI_Nullify_WR\PI_Nullify_IORQ\PI_Flag_BUSACK\if(/BUSRQ)PR_Halt_XPT
- a: 
  b: 
  c: cl↓
  d: PhI_Flag_BUSACK
- a: 1
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_CBUSRQ
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}


### リセット{#ic-reset}

/TRSET&&/RESET

{{<table4R>}}
- a: 0
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
{{</table4R>}}

/TRSET&&RESET

{{<table4R>}}
- a: /TRSET&&RESET
  b: 
  c: cl↑
  d: P2_Set_CRESET\P2_Reset_ALL_except_CRESET
- a: 
  b: 
  c: cl↓
  d: 
{{</table4R>}}

CRESET

{{<table4R>}}
- a: CRESET
  b: 
  c: cl↑
  d: PR_Reset_XPT\PA_Select_0x0\PA_NOP\PR_Write_PC_low\PR_Write_PC_high\PR_Write_I\PR_Write_R\P2_Reset_CRESET\P2_Set_CM1\P2_IM0\P2_Reset_IFF1\P2_Reset_IFF2
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

## 命令{#instruction}

X:命令長\
M:Mサイクル数\
T:Tサイクル数\
r:レジスタ(8bit)

{{<table2HM>}}
A: rrr/r’r’r’
B: 対応レジスタ
items:
    - a: "000"
      b: B
    - a: "001"
      b: C
    - a: "010"
      b: D
    - a: "011"
      b: E
    - a: "100"
      b: H
    - a: "101"
      b: L
    - a: "111"
      b: A
{{</table2HM>}}

dd:レジスタ(16bit)

{{<table2HM>}}
A: dd
B: 対応レジスタ
items:
    - a: "00"
      b: BC
    - a: "01"
      b: DE
    - a: "10"
      b: HL
    - a: "11"
      b: SP
{{</table2HM>}}

qq:レジスタ(16bit)

{{<table2HM>}}
A: qq
B: 対応レジスタ
items:
    - a: "00"
      b: BC
    - a: "01"
      b: DE
    - a: "10"
      b: HL
    - a: "11"
      b: AF
{{</table2HM>}}

ss:レジスタ(16bit)

{{<table2HM>}}
A: ss
B: 対応レジスタ
items:
    - a: "00"
      b: BC
    - a: "01"
      b: DE
    - a: "10"
      b: HL
    - a: "11"
      b: SP
{{</table2HM>}}

pp:レジスタ(16bit)

{{<table2HM>}}
A: pp
B: 対応レジスタ
items:
    - a: "00"
      b: BC
    - a: "01"
      b: DE
    - a: "10"
      b: IX
    - a: "11"
      b: SP
{{</table2HM>}}

rr:レジスタ(16bit)

{{<table2HM>}}
A: rr
B: 対応レジスタ
items:
    - a: "00"
      b: BC
    - a: "01"
      b: DE
    - a: "10"
      b: IY
    - a: "11"
      b: SP
{{</table2HM>}}

cc:条件

{{<table2HM>}}
A: ccc
B: 対応レジスタ
items:
    - a: "000"
      b: Z==0
    - a: "001"
      b: Z==1
    - a: "010"
      b: C==0
    - a: "011"
      b: C==1
    - a: "100"
      b: P==0
    - a: "101"
      b: P==1
    - a: "110"
      b: S==0
    - a: "111"
      b: S==1
{{</table2HM>}}

p

{{<table2HM>}}
A: ppp
B: 8*p
items:
    - a: "000"
      b: "0x00"
    - a: "001"
      b: "0x08"
    - a: "010"
      b: "0x10"
    - a: "011"
      b: "0x18"
    - a: "100"
      b: "0x20"
    - a: "101"
      b: "0x28"
    - a: "110"
      b: "0x30"
    - a: "111"
      b: "0x38"
{{</table2HM>}}

; 同時実行\
\* フラグ変更

## 8bitデータ移動{#in-8ld}

### LD r,r’ (X1/M1/T4) [M1]{#in-LDrr}

r←r’

**命令**\
01 rrr r’r’r’

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PA_SELECT_A/B/C/D/E/H/L_low\PA_NOP\?PR_InvertIn\PR_Write_A/B/C/D/E/H/L\PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### LD r,n (X2/M2/T7) [M1\MR]{#in-LDrn}

r←n

**命令**\
00 rrr 110\
nn nnn nnn

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: P2_Set_CMR\PR_Reset_XPT\P2_Set_ILDrn_A/B/C/D/E/H/L
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\?PR_InvertIn\PR_Write_A/B/C/D/E/H/L\P2_Reset_ITABLE
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### LD r,(HL) (X1/M2/T7) [M1+R]{#in-LDrqHLp}

r←(HL)

**命令**\
01 rrr 110

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PI_SelectAd_HL\?PR_InvertIn\PR_Write_A/B/C/D/E/H/L
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### LD r,(IX+d) (X3/M5/T19) [M1\M1\MR+5+R]{#in-LDrqIXtdp}

r←(IX+d)

**命令**\
11 011 101\
01 rrr 110\
dd ddd ddd

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_ILDr(IX+d)_A/B/C/D/E/H/L
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_DtexDt\PR_Write_A/B/C/D/E/H/L\?PR_InvertIn
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### LD r,(IY+d) (X3/M5/T19) [M1\M1\MR+5+R]{#in-LDrqIYtdp}

r←(IY+d)

**命令**\
11 111 101\
01 rrr 110\
dd ddd ddd
 
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_ILDr(IY+d)_A/B/C/D/E/H/L
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a:
  b:
  c: cl↓
  d:
- a: 4
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 5
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 7
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 8
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a:
  b:
  c: cl↓
  d:
- a: 9(W)
  b:
  c: cl↑
  d: PI_SelectAd_DtexDt
- a:
  b:
  c: cl↓
  d:
- a: 10
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_DtexDt\PR_Write_A/B/C/D/E/H/L\?PR_InvertIn
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD (HL),r (X1/M2/T7) [M1+W]{#in-LDqHLpr}

(HL)←r

**命令**\
01 110 rrr

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: W
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_A/B/C/D/E/H/L
- a:
  b:
  c: cl↓
  d:
- a: 5(W)
  b:
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_A/B/C/D/E/H/L
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PI_SelectAd_HL\PI_SelectDt_A/B/C/D/E/H/L
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD (IX+d),r (X3/M5/T19) [M1\M1\MR+5+W]{#in-LDqIXtdpr}

(IX+d)←r

**命令**\
11 011 101\
01 110 rrr\
dd ddd ddd

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_ILD(IX+d)r_A/B/C/D/E/H/L
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a:
  b:
  c: cl↓
  d:
- a: 4
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 5
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 7
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 8
  b: W
  c: cl↑
  d: PI_SelectAd_DtexDt\PI_SelectDt_A/B/C/D/E/H/L
- a:
  b:
  c: cl↓
  d:
- a: 9(W)
  b:
  c: cl↑
  d: PI_SelectAd_DtexDt\PI_SelectDt_A/B/C/D/E/H/L
- a:
  b:
  c: cl↓
  d:
- a: 10
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_DtexDt\PI_SelectDt_A/B/C/D/E/H/L
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD (IY+d),r (X3/M5/T19) [M1\M1\MR+5+W]{#in-LDqIYtdpr}

(IY+d)←r

**命令**\
11 111 101\
01 110 rrr\
dd ddd ddd

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_ILD(IY+d)r_A/B/C/D/E/H/L
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a:
  b:
  c: cl↓
  d:
- a: 4
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 5
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 7
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 8
  b: W
  c: cl↑
  d: PI_SelectAd_DtexDt\PI_SelectDt_A/B/C/D/E/H/L
- a:
  b:
  c: cl↓
  d:
- a: 9(W)
  b:
  c: cl↑
  d: PI_SelectAd_DtexDt\PI_SelectDt_A/B/C/D/E/H/L
- a:
  b:
  c: cl↓
  d:
- a: 10
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_DtexDt\PI_SelectDt_A/B/C/D/E/H/L
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD (HL),n (X2/M3/T10) [M1\MR+W]{#in-LDqHLpn}

(HL)←n

**命令**\
00 110 110\
nn nnn nnn

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_ILD(HL)n
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: W
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_OP
- a:
  b:
  c: cl↓
  d:
- a: 4(W)
  b:
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_OP
- a:
  b:
  c: cl↓
  d:
- a: 5
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_HL\PI_SelectDt_OP
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD (IX+d),n (X4/M5/T19) [M1\M1\MR\MR+2+W]{#in-LDqIXtdpn}

(IX+d)←n

**命令**\
11 011 101\
00 110 110\
dd ddd ddd\
nn nnn nnn

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_ILD(IX+d)n_0
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_ILD(IX+d)n_1
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: 2
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a:
  b:
  c: cl↓
  d:
- a: 4
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 5
  b: W
  c: cl↑
  d: PI_SelectAd_DtexDt\PI_SelectDt_OP
- a:
  b:
  c: cl↓
  d:
- a: 6(W)
  b:
  c: cl↑
  d: PI_SelectAd_DtexDt\PI_SelectDt_OP
- a:
  b:
  c: cl↓
  d:
- a: 7
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_DtexDt\PI_SelectDt_OP
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD (IY+d),n (X4/M5/T19) [M1\M1\MR\MR+2+W]{#in-LDqIYtdpn}

(IY+d)←n

**命令**\
11 111 101\
00 110 110\
dd ddd ddd\
nn nnn nnn

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_ILD(IY+d)n_0
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_ILD(IY+d)n_1
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: 2
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a:
  b:
  c: cl↓
  d:
- a: 4
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 5
  b: W
  c: cl↑
  d: PI_SelectAd_DtexDt\PI_SelectDt_OP
- a:
  b:
  c: cl↓
  d:
- a: 6(W)
  b:
  c: cl↑
  d: PI_SelectAd_DtexDt\PI_SelectDt_OP
- a:
  b:
  c: cl↓
  d:
- a: 7
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_DtexDt\PI_SelectDt_OP
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD A,(BC) (X1/M2/T7) [M1+R]{#in-LDAqBCp}

A←(BC)

**命令**\
00 001 010

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_BC
- a:
  b:
  c: cl↓
  d:
- a: 5(W)
  b:
  c: cl↑
  d: PI_SelectAd_BC
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PI_SelectAd_BC\PR_Write_A\PR_InvertIn
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD A,(DE) (X1/M2/T7) [M1+R]{#in-LDAqDEp}

A←(DE)

**命令**\
00 011 010

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_DE
- a:
  b:
  c: cl↓
  d:
- a: 5(W)
  b:
  c: cl↑
  d: PI_SelectAd_DE
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PI_SelectAd_DE\PR_Write_A\PR_InvertIn
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD A,(nn) (X3/M4/T13) [M1\MR\MR+R]{#in-LDAqnnp}

A←(nn)

**命令**\
00 111 010\
nn nnn nnn (low)\
nn nnn nnn (high)

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_ILDA(nn)_0
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_ILDA(nn)_1
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: R
  c: cl↑
  d: PI_SelectAd_OPOPold
- a:
  b:
  c: cl↓
  d:
- a: 4(W)
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold
- a:
  b:
  c: cl↓
  d:
- a: 5
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_OPOPold\PR_Write_A\PR_InvertIn
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD (BC),A (X1/M2/T7) [M1+W]{#in-LDqBCpA}

(BC)←A

**命令**\
00 000 010

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: W
  c: cl↑
  d: PI_SelectAd_BC\PI_SelectDt_A
- a:
  b:
  c: cl↓
  d:
- a: 5(W)
  b:
  c: cl↑
  d: PI_SelectAd_BC\PI_SelectDt_A
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PI_SelectAd_BC\PI_SelectDt_A
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD (DE),A (X1/M2/T7) [M1+W]{#in-LDqDEpA}

(DE)←A

**命令**\
00 010 010

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: W
  c: cl↑
  d: PI_SelectAd_DE\PI_SelectDt_A
- a:
  b:
  c: cl↓
  d:
- a: 5(W)
  b:
  c: cl↑
  d: PI_SelectAd_DE\PI_SelectDt_A
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PI_SelectAd_DE\PI_SelectDt_A
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD (nn),A (X3/M4/T13) [M1\MR\MR+W]{#in-LDqnnpA}

(nn)←A

**命令**\
00 110 010\
nn nnn nnn (low)\
nn nnn nnn (high)

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: P2_Set_ILD(nn)A_0\PR_Reset_XPT\P2_Set_CMR
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: P2_Set_ILD(nn)A_1\PR_Reset_XPT\P2_Set_CMR
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: W
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectDt_A
- a:
  b:
  c: cl↓
  d:
- a: 4(W)
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectDt_A
- a:
  b:
  c: cl↓
  d:
- a: 5
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_OPOPold\PI_SelectDt_A
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### *LD A,I (X2/M2/T9) [M1\M1+1]{#in-LDAI}

A←I

**命令**\
11 101 101\
01 010 111

**フラグ変化**

{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: I==0
    c: IFF2
    d: I<0
    e: 0
    f: 0
{{</table6HM>}}

<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: 1
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR\PA_Select_I_low\PA_NOP\PR_Write_A\PR_InvertIn\PF_Write_Z\PF_Select_Z_bit19\PF_Write_P/V\PF_Select_P/V_bit18\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### *LD A,R (X2/M2/T9) [M1\M1+1]{#in-LDAR}

A←R

**命令**\
11 101 101\
01 011 111

**フラグ変化**

{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: R==0
    c: IFF2
    d: R<0
    e: 0
    f: 0
{{</table6HM>}}

<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: 1
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR\PA_Select_R_low\PA_NOP\PR_Write_A\PR_InvertIn\PF_Write_Z\PF_Select_Z_bit19\PF_Write_P/V\PF_Select_P/V_bit18\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD I,A (X2/M2/T9) [M1\M1+1]{#in-LDIA}

I←A

**命令**\
11 101 101\
01 000 111

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: 1
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR\PA_Select_A_low\PA_NOP\PR_Write_I\PR_InvertIn
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD R,A (X2/M2/T9) [M1\M1+1]{#in-LDRA}

R←A

**命令**\
11 101 101\
01 001 111

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: 1
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR\PA_Select_A_low\PA_NOP\PR_Write_R
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

## 16bitデータ移動{#in-16ld}

### LD dd,nn (X3/M3/T10) [M1\MR\MR]{#in-LDddnn}

dd←nn

**命令**\
00 dd0 001\
nn nnn nnn (low)\
nn nnn nnn (high)

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: P2_Set_ILDddnn_BC/DE/HL/SP_0\PR_Reset_XPT\P2_Set_CMR
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: P2_Set_ILDddnn_BC/DE/HL/SP_1\PR_Reset_XPT\P2_Set_CMR\PR_Write_C/E/L/SP_low
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PR_Write_B/D/H/SP_high\PR_InvertIn
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD IX,nn (X4/M4/T14) [M1\M1\MR\MR]{#in-LDIXnn}

IX←nn

**命令**\
11 011 101\
00 100 001\
nn nnn nnn (low)\
nn nnn nnn (high)

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_ILDIXnn_0
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_ILDIXnn_1\P2_Set_CMR\PR_Write_IX_low
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PR_Write_IX_high\PR_InvertIn
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD IY,nn (X4/M4/T14) [M1\M1\MR\MR]{#in-LDIYnn}

IY←nn

**命令**\
11 111 101\
00 100 001\
nn nnn nnn (low)\
nn nnn nnn (high)

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_ILDIYnn_0
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_ILDIYnn_1\P2_Set_CMR\PR_Write_IY_low
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PR_Write_IY_high\PR_InvertIn
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD HL,(nn) (X3/M5/T16) [M1\MR\MR+R+R]{#in-LDHLqnnp}

L←(nn)\
H←(nn+1)

**命令**\
00 101 010\
nn nnn nnn (low)\
nn nnn nnn (high)

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_ILDHL(nn)_0
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_ILDHL(nn)_1
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: R
  c: cl↑
  d: PI_SelectAd_OPOPold
- a:
  b:
  c: cl↓
  d:
- a: 4(W)
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold
- a:
  b:
  c: cl↓
  d:
- a: 5
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold\PR_Write_L
- a:
  b:
  c: cl↓
  d:
- a: 6
  b: R
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectAd+1
- a:
  b:
  c: cl↓
  d:
- a: 7(W)
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectAd+1
- a:
  b:
  c: cl↓
  d:
- a: 8
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_OPOPold\PI_SelectAd+1\PR_Write_H\PR_InvertIn
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD dd,(nn) (X4/M6/T20) [M1\M1\MR\MR+R+R]{#in-LDddqnnp}

dd_low←(nn)\
dd_high←(nn+1)

**命令**\
11 101 101\
01 dd1 011\
nn nnn nnn (low)\
nn nnn nnn (high)

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XOTR\P2_Set_ILDdd(nn)_BC/DE/HL/SP_0
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_ILDdd(nn)_BC/DE/HL/SP_1
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: R
  c: cl↑
  d: PI_SelectAd_OPOPold
- a:
  b:
  c: cl↓
  d:
- a: 4(W)
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold
- a:
  b:
  c: cl↓
  d:
- a: 5
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold\PR_Write_C/E/L/SP_low
- a:
  b:
  c: cl↓
  d:
- a: 6
  b: R
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectAd+1
- a:
  b:
  c: cl↓
  d:
- a: 7(W)
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectAd+1
- a:
  b:
  c: cl↓
  d:
- a: 8
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_OPOPold\PI_SelectAd+1\PR_Write_B/D/H/SP_high\PR_InvertIn
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD IX,(nn) (X4/M6/T20) [M1\M1\MR\MR+R+R]{#in-LDIXqnnp}

IX_low←(nn)\
IX_high←(nn+1)

**命令**\
11 011 101\
00 101 010\
nn nnn nnn (low)\
nn nnn nnn (high)

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_ILDIX(nn)_0
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_ILDIX(nn)_1
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: R
  c: cl↑
  d: PI_SelectAd_OPOPold
- a:
  b:
  c: cl↓
  d:
- a: 4(W)
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold
- a:
  b:
  c: cl↓
  d:
- a: 5
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold\PR_Write_IX_low
- a:
  b:
  c: cl↓
  d:
- a: 6
  b: R
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectAd+1
- a:
  b:
  c: cl↓
  d:
- a: 7(W)
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectAd+1
- a:
  b:
  c: cl↓
  d:
- a: 8
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_OPOPold\PI_SelectAd+1\PR_Write_IX_high\PR_InvertIn
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD IY,(nn) (X4/M6/T20) [M1\M1\MR\MR+R+R]{#in-LDIYqnnp}

IY_low←(nn)\
IY_high←(nn+1)

**命令**\
11 111 101\
00 101 010\
nn nnn nnn (low)\
nn nnn nnn (high)

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_ILDIY(nn)_0
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_ILDIY(nn)_1
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: R
  c: cl↑
  d: PI_SelectAd_OPOPold
- a:
  b:
  c: cl↓
  d:
- a: 4(W)
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold
- a:
  b:
  c: cl↓
  d:
- a: 5
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold\PR_Write_IY_low
- a:
  b:
  c: cl↓
  d:
- a: 6
  b: R
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectAd+1
- a:
  b:
  c: cl↓
  d:
- a: 7(W)
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectAd+1
- a:
  b:
  c: cl↓
  d:
- a: 8
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_OPOPold\PI_SelectAd+1\PR_Write_IY_high\PR_InvertIn
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD (nn),HL (X3/M5/T16) [M1\MR\MR+W+W]{#in-LDqnnpHL}

(nn)←L\
(nn+1)←H

**命令**\
00 100 010\
nn nnn nnn (low)\
nn nnn nnn (high)

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_ILD(nn)HL_0
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_ILD(nn)HL_1
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: W
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectDt_L
- a:
  b:
  c: cl↓
  d:
- a: 4(W)
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectDt_L
- a:
  b:
  c: cl↓
  d:
- a: 5
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectDt_L
- a:
  b:
  c: cl↓
  d:
- a: 6
  b: W
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectAd+1\PI_SelectDt_H
- a:
  b:
  c: cl↓
  d:
- a: 7(W)
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectAd+1\PI_SelectDt_H
- a:
  b:
  c: cl↓
  d:
- a: 8
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_OPOPold\PI_SelectAd+1\PI_SelectDt_H
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD (nn),dd (X4/M6/T20) [M1\M1\MR\MR+W+W]{#in-LDqnnpdd}

(nn)←dd_low\
(nn+1)←dd_high

**命令**\
11 101 101\
01 dd0 011\
nn nnn nnn (low)\
nn nnn nnn (high)

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XOTR\P2_Set_ILD(nn)dd_BC/DE/HL/SP_0
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_ILD(nn)dd_BC/DE/HL/SP_1
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: W
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectDt_C/E/L/SP_low
- a:
  b:
  c: cl↓
  d:
- a: 4(W)
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectDt_C/E/L/SP_low
- a:
  b:
  c: cl↓
  d:
- a: 5
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectDt_C/E/L/SP_low
- a:
  b:
  c: cl↓
  d:
- a: 6
  b: W
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectAd+1\PI_SelectDt_B/D/H/SP_high
- a:
  b:
  c: cl↓
  d:
- a: 7(W)
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectAd+1\PI_SelectDt_B/D/H/SP_high
- a:
  b:
  c: cl↓
  d:
- a: 8
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_OPOPold\PI_SelectAd+1\PI_SelectDt_B/D/H/SP_high
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD (nn),IX (X4/M6/T20) [M1\M1\MR\MR+W+W]{#in-LDqnnpIX}

(nn)←IX_low\
(nn+1)←IX_high

**命令**\
11 011 101\
00 100 010\
nn nnn nnn (low)\
nn nnn nnn (high)

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_ILD(nn)IX_0
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_ILD(nn)IX_1
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: W
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectDt_IX_low
- a:
  b:
  c: cl↓
  d:
- a: 4(W)
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectDt_IX_low
- a:
  b:
  c: cl↓
  d:
- a: 5
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectDt_IX_low
- a:
  b:
  c: cl↓
  d:
- a: 6
  b: W
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectAd+1\PI_SelectDt_IX_high
- a:
  b:
  c: cl↓
  d:
- a: 7(W)
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectAd+1\PI_SelectDt_IX_high
- a:
  b:
  c: cl↓
  d:
- a: 8
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_OPOPold\PI_SelectAd+1\PI_SelectDt_IX_high
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD (nn),IY (X4/M6/T20) [M1\M1\MR\MR+W+W]{#in-LDqnnpIY}

(nn)←IY_low\
(nn+1)←IY_high

**命令**\
11 111 101\
00 100 010\
nn nnn nnn (low)\
nn nnn nnn (high)

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_ILD(nn)IY_0
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_ILD(nn)IY_1
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: W
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectDt_IY_low
- a:
  b:
  c: cl↓
  d:
- a: 4(W)
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectDt_IY_low
- a:
  b:
  c: cl↓
  d:
- a: 5
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectDt_IY_low
- a:
  b:
  c: cl↓
  d:
- a: 6
  b: W
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectAd+1\PI_SelectDt_IY_high
- a:
  b:
  c: cl↓
  d:
- a: 7(W)
  b:
  c: cl↑
  d: PI_SelectAd_OPOPold\PI_SelectAd+1\PI_SelectDt_IY_high
- a:
  b:
  c: cl↓
  d:
- a: 8
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_OPOPold\PI_SelectAd+1\PI_SelectDt_IY_high
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD SP,HL (X1/M1/T6) [M1+2]{#in-LDSPHL}

SP←HL

**命令**\
11 111 001

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: 2
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 5
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PA_Select_HL_low\PA_NOP\PR_Write_SP
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD SP,IX (X2/M2/T10) [M1\M1+2]{#in-LDSPIX}

SP←IX

**命令**\
11 011 101\
11 111 001

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: 2
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 5
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIX\PA_Select_IX_low\PA_NOP\PR_Write_SP
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### LD SP,IY (X2/M2/T10) [M1\M1+2]{#in-LDSPIY}

SP←IY

**命令**\
11 111 101\
11 111 001

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: 2
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 5
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIY\PA_Select_IY_low\PA_NOP\PR_Write_SP
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### PUSH qq (X1/M3/T11) [M1+1+W+W]{#in-PUSHqq}

SP←SP-1\
(SP)←qq_high\
SP←SP-1\
(SP)←qq_low

**命令**\
11 qq0 101

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: 1
  c: cl↑
  d: PR_Dec_SP
- a:
  b:
  c: cl↓
  d:
- a: 5
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_B/D/H/A
- a:
  b:
  c: cl↓
  d:
- a: 6(W)
  b:
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_B/D/H/A
- a:
  b:
  c: cl↓
  d:
- a: 7
  b:
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_B/D/H/A\PR_Dec_SP
- a:
  b:
  c: cl↓
  d:
- a: 8
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_C/E/L/F
- a:
  b:
  c: cl↓
  d:
- a: 9(W)
  b:
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_C/E/L/F
- a:
  b:
  c: cl↓
  d:
- a: 10
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PI_SelectAd_SP\PI_SelectDt_C/E/L/F
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### PUSH IX (X2/M4/T15) [M1\M1+1+W+W]{#in-PUSHIX}

SP←SP-1\
(SP)←IX_high\
SP←SP-1\
(SP)←IX_low

**命令**\
11 011 101\
11 100 101

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: 1
  c: cl↑
  d: PR_Dec_SP
- a:
  b:
  c: cl↓
  d:
- a: 5
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_IX_high
- a:
  b:
  c: cl↓
  d:
- a: 6(W)
  b:
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_IX_high
- a:
  b:
  c: cl↓
  d:
- a: 7
  b:
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_IX_high\PR_Dec_SP
- a:
  b:
  c: cl↓
  d:
- a: 8
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_IX_low
- a:
  b:
  c: cl↓
  d:
- a: 9(W)
  b:
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_IX_low
- a:
  b:
  c: cl↓
  d:
- a: 10
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Reset_XIX\P2_Set_CM1\PI_SelectAd_SP\PI_SelectDt_IX_low
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### PUSH IY (X2/M4/T15) [M1\M1+1+W+W]{#in-PUSHIY}

SP←SP-1\
(SP)←IY_high\
SP←SP-1\
(SP)←IY_low

**命令**\
11 111 101\
11 100 101

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: 1
  c: cl↑
  d: PR_Dec_SP
- a:
  b:
  c: cl↓
  d:
- a: 5
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_IY_high
- a:
  b:
  c: cl↓
  d:
- a: 6(W)
  b:
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_IY_high
- a:
  b:
  c: cl↓
  d:
- a: 7
  b:
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_IY_high\PR_Dec_SP
- a:
  b:
  c: cl↓
  d:
- a: 8
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_IY_low
- a:
  b:
  c: cl↓
  d:
- a: 9(W)
  b:
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_IY_low
- a:
  b:
  c: cl↓
  d:
- a: 10
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Reset_XIY\P2_Set_CM1\PI_SelectAd_SP\PI_SelectDt_IY_low
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### POP qq (X1/M3/T10) [M1+R+R]{#in-POPqq}

qq_low←(SP)\
SP←SP+1\
qq_high←(SP)\
SP←SP+1

**命令**\
11 qq0 001

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_SP
- a:
  b:
  c: cl↓
  d:
- a: 5(W)
  b:
  c: cl↑
  d: PI_SelectAd_SP
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d: PI_SelectAd_SP\PR_Inc_SP\PR_Write_C/E/L/F
- a:
  b:
  c: cl↓
  d:
- a: 7
  b: R
  c: cl↑
  d: PI_SelectAd_SP
- a:
  b:
  c: cl↓
  d:
- a: 8(W)
  b:
  c: cl↑
  d: PI_SelectAd_SP
- a:
  b:
  c: cl↓
  d:
- a: 9
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PI_SelectAd_SP\PR_Inc_SP\PR_Write_B/D/H/A\PR_InvertIn
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### POP IX (X2/M4/T14) [M1\M1+R+R]{#in-POPIX}

IX_low←(SP)\
SP←SP+1\
IX_high←(SP)\
SP←SP+1

**命令**\
11 011 101\
11 100 001

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PR_Inc_SP\PR_Write_IX_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: R
  c: cl↑
  d: PI_SelectAd_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 8(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIX\PI_SelectAd_SP\PR_Inc_SP\PR_Write_IX_high\PR_InvertIn
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### POP IY (X2/M4/T14) [M1\M1+R+R]{#in-POPIY}

IY_low←(SP)\
SP←SP+1\
IY_high←(SP)\
SP←SP+1

**命令**\
11 111 101\
11 100 001

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PR_Inc_SP\PR_Write_IY_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: R
  c: cl↑
  d: PI_SelectAd_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 8(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIY\PI_SelectAd_SP\PR_Inc_SP\PR_Write_IY_high\PR_InvertIn
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

## 交換・ブロック転送および検索{#in-ex}

### EX DE,HL (X1/M1/T4) [M1]{#in-EXDEHL}

DE↔HL

**命令**\
11 101 011

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PR_Ex_DE_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### EX AF,A’F’ (X1/M1/T4) [M1]{#in-EXAFAF}

AF↔A’F’

**命令**\
00 001 000

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PR_Ex_AF_A’F’
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### EXX (X1/M1/T4) [M1]{#in-EXX}

BC↔B’C’\
DE↔D’E’\
HL↔H’L’

**命令**\
11 011 001

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PR_Exx
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### EX (SP),HL (X1/M5/T19) [M1+R+R+1+W+W+2]{#in-EXqSPpHL}

L↔(SP)\
H↔(SP+1)

**命令**\
11 100 011

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PA_Select_HL_low\PA_NOP\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PR_Write_L
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: R
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectAd+1
- a: 
  b: 
  c: cl↓
  d: 
- a: 8(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectAd+1
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectAd+1\PR_Write_H\PR_InvertIn
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 12(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 13
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 14
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectAd+1\PI_SelectDt_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 15(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectAd+1\PI_SelectDt_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 16
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectAd+1\PI_SelectDt_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 17
  b: 2
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 18
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### EX (SP),IX (X2/M6/T23) [M1\M1+R+R+1+W+W+2]{#in-EXqSPpIX}

IX_low↔(SP)\
IX_high↔(SP+1)

**命令**\
11 011 101\
11 100 011

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PA_Select_IX_low\PA_NOP\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PR_Write_IX_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: R
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectAd+1
- a: 
  b: 
  c: cl↓
  d: 
- a: 8(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectAd+1
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectAd+1\PR_Write_IX_high\PR_InvertIn
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 12(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 13
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 14
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectAd+1\PI_SelectDt_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 15(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectAd+1\PI_SelectDt_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 16
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectAd+1\PI_SelectDt_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 17
  b: 2
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 18
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### EX (SP),IY (X2/M6/T23) [M1\M1+R+R+1+W+W+2]{#in-EXqSPpIY}

IY_low↔(SP)\
IY_high↔(SP+1)

**命令**\
11 111 101\
11 100 011

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PA_Select_IY_low\PA_NOP\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PR_Write_IY_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: R
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectAd+1
- a: 
  b: 
  c: cl↓
  d: 
- a: 8(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectAd+1
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectAd+1\PR_Write_IY_high\PR_InvertIn
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 12(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 13
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 14
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectAd+1\PI_SelectDt_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 15(W)
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectAd+1\PI_SelectDt_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 16
  b: 
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectAd+1\PI_SelectDt_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 17
  b: 2
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 18
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *LDI (X2/M4/T16) [M1\M1+R+W+2]{#in-LDI}

(DE)←(HL)\
DE←DE+1\
BC←BC-1\
HL←HL+1

**命令**\
11 101 101\
10 100 000

{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: 
    c: BC - 1 != 0
    d: 
    e: 0
    f: 0
{{</table6HM>}}

<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: W
  c: cl↑
  d: PI_SelectAd_DE\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 8(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DE\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: PI_SelectAd_DE\PI_SelectDt_Dt\PA_Select_DE_low\PA_Select_0x1_high\PA_ADD\PR_Write_D\PR_Write_E
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 2
  c: cl↑
  d: PA_Select_BC_high\PA_Select_0x1_low\PA_SUB\PR_Write_B\PR_Write_C\PF_Write_P/V\PF_Select_P/V_bit20\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR\PA_Select_HL_low\PA_Select_0x1_high\PA_ADD\PR_Write_H\PR_Write_L
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *LDIR (X2/M5/T21)/(X2/M4/T16) [M1\M1+R+W+7/2]{#in-LDIR}

BC -1 == 0のときはT16

(DE)←(HL)\
DE←DE+1\
BC←BC-1\
HL←HL+1\
BC != 0 ⇒ PC←PC-2

**命令**\
11 101 101\
10 110 000

{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: 
    c: BC - 1 != 0
    d: 
    e: 0
    f: 0
{{</table6HM>}}

<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: W
  c: cl↑
  d: PI_SelectAd_DE\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 8(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DE\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: PI_SelectAd_DE\PI_SelectDt_Dt\PA_Select_DE_low\PA_Select_0x1_high\PA_ADD\PR_Write_D\PR_Write_E
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 2
  c: cl↑
  d: PA_Select_BC_high\PA_Select_0x1_low\PA_SUB\PR_Write_B\PR_Write_C\PF_Write_P/V\PF_Select_P/V_bit20\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PA_Select_HL_low\PA_Select_0x1_high\PA_ADD\PR_Write_H\PR_Write_L\if(!Flag_P/V)→PR_Reset_XPT\　　　　　　　P2_Set_CM1\　　　　　　　P2_Reset_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: if(!Flag_P/V)→Pa_Ophd
{{</table4R>}}
<br>
{{<table4R>}}
- a: 12
  b: 5
  c: cl↑
  d: PA_Select_PC_high\PA_Select_0x1_low\PA_SUB\PR_Write_PC_high\PR_Write_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 13
  b: 
  c: cl↑
  d: PA_Select_PC_high\PA_Select_0x1_low\PA_SUB\PR_Write_PC_high\PR_Write_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 14
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 15
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 16
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *LDD (X2/M4/T16) [M1\M1+R+W+2]{#in-LDD}

(DE)←(HL)\
DE←DE-1\
BC←BC-1\
HL←HL-1

**命令**\
11 101 101\
10 101 000

**フラグ変化**

{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: 
    c: BC - 1 != 0
    d: 
    e: 0
    f: 0
{{</table6HM>}}

<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: W
  c: cl↑
  d: PI_SelectAd_DE\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 8(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DE\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: PI_SelectAd_DE\PI_SelectDt_Dt\PA_Select_DE_high\PA_Select_0x1_low\PA_SUB\PR_Write_D\PR_Write_E
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 2
  c: cl↑
  d: PA_Select_BC_high\PA_Select_0x1_low\PA_SUB\PR_Write_B\PR_Write_C\PF_Write_P/V\PF_Select_P/V_bit20\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR\PA_Select_HL_high\PA_Select_0x1_low\PA_SUB\PR_Write_H\PR_Write_L
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *LDDR (X2/M5/T21)/(X2/M4/T16) [M1\M1+R+W+7/2]{#in-LDDR}

BC -1 == 0のときはT16

(DE)←(HL)\
DE←DE-1\
BC←BC-1\
HL←HL-1\
BC != 0 ⇒ PC←PC-2

**命令**\
11 101 101\
10 111 000

**フラグ変化**

{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: 
    c: BC - 1 != 0
    d: 
    e: 0
    f: 0
{{</table6HM>}}

<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: W
  c: cl↑
  d: PI_SelectAd_DE\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 8(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DE\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: PI_SelectAd_DE\PI_SelectDt_Dt\PA_Select_DE_high\PA_Select_0x1_low\PA_SUB\PR_Write_D\PR_Write_E
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 2
  c: cl↑
  d: PA_Select_BC_high\PA_Select_0x1_low\PA_SUB\PR_Write_B\PR_Write_C\PF_Write_P/V\PF_Select_P/V_bit20\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PA_Select_HL_high\PA_Select_0x1_low\PA_SUB\PR_Write_H\PR_Write_L\if(!Flag_P/V)→PR_Reset_XPT\　　　　　　　P2_Set_CM1\　　　　　　　P2_Reset_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: if(!Flag_P/V)→Pa_Ophd
{{</table4R>}}
<br>
{{<table4R>}}
- a: 12
  b: 5
  c: cl↑
  d: PA_Select_PC_high\PA_Select_0x1_low\PA_SUB\PR_Write_PC_high\PR_Write_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 13
  b: 
  c: cl↑
  d: PA_Select_PC_high\PA_Select_0x1_low\PA_SUB\PR_Write_PC_high\PR_Write_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 14
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 15
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 16
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *CPI (X2/M4/T16) [M1\M1+R+5]{#in-CPI}

A-(HL) (するだけ)\
BC←BC-1\
HL←HL+1

**命令**\
11 101 101\
10 100 001

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: A == (HL)
    c: BC - 1 != 0
    d: A-(HL) < 0
    e: 1
    f: A-(HL)のハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 5
  c: cl↑
  d: PA_Select_A_high\PA_Select_Dt_low\PA_SUB\PF_Write_Z\PF_Select_Z_bit19\PF_Write_S\PF_Select_S_bit7\PF_Write_H\PF_Select_H_bit22
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 
  c: cl↑
  d: PA_Select_BC_high\PA_Select_0x1_low\PA_SUB\PR_Write_B\PR_Write_C\PF_Write_P/V\PF_Select_P/V_bit20
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: PA_Select_HL_high\PA_Select_0x1_low\PA_ADD\PR_Write_H\PR_Write_L\PF_Write_N\PF_Select_N_bit17
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *CPIR (X2/M5/T21)/(X2/M4/T16) [M1\M1+R+10/5]{#in-CPIR}

A == (HL) or BC-1 == 0のときT16

A-(HL) (するだけ) \
HL←HL+1\
BC←BC-1\
BC != 0 ⇒ PC←PC-2

**命令**\
11 101 101\
10 110 001

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: A == (HL)
    c: BC - 1 != 0
    d: A-(HL) < 0
    e: 1
    f: A-(HL)のハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 5
  c: cl↑
  d: PA_Select_A_high\PA_Select_Dt_low\PA_SUB\PF_Write_Z\PF_Select_Z_bit19\PF_Write_S\PF_Select_S_bit7\PF_Write_H\PF_Select_H_bit22
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 
  c: cl↑
  d: PA_Select_BC_high\PA_Select_0x1_low\PA_SUB\PR_Write_B\PR_Write_C\PF_Write_P/V\PF_Select_P/V_bit20
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: PA_Select_HL_high\PA_Select_0x1_low\PA_ADD\PR_Write_H\PR_Write_L\PF_Write_N\PF_Select_N_bit17
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: if(!Flag_P/V or Flag_Z)→PR_Reset_XPT\　　　　　　　　　　　P2_Set_CM1\　　　　　　　　　　　P2_Reset_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: if(!Flag_P/V or Flag_Z)→Pa_Ophd
{{</table4R>}}
<br>
{{<table4R>}}
- a: 12
  b: 5
  c: cl↑
  d: PA_Select_PC_high\PA_Select_0x1_low\PA_SUB\PR_Write_PC_high\PR_Write_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 13
  b: 
  c: cl↑
  d: PA_Select_PC_high\PA_Select_0x1_low\PA_SUB\PR_Write_PC_high\PR_Write_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 14
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 15
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 16
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *CPD (X2/M4/T16) [M1\M1+R+5]{#in-CPD}

A-(HL) (するだけ)\
BC←BC-1\
HL←HL-1

**命令**\
11 101 101\
10 101 001

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: A == (HL)
    c: BC - 1 != 0
    d: A-(HL) < 0
    e: 1
    f: A-(HL)のハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 5
  c: cl↑
  d: PA_Select_A_high\PA_Select_Dt_low\PA_SUB\PF_Write_Z\PF_Select_Z_bit19\PF_Write_S\PF_Select_S_bit7\PF_Write_H\PF_Select_H_bit22
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 
  c: cl↑
  d: PA_Select_BC_high\PA_Select_0x1_low\PA_SUB\PR_Write_B\PR_Write_C\PF_Write_P/V\PF_Select_P/V_bit20
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: PA_Select_HL_high\PA_Select_0x1_low\PA_SUB\PR_Write_H\PR_Write_L\PF_Write_N\PF_Select_N_bit17
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *CPDR (X2/M5/T21)/(X2/M4/T16) [M1\M1+R+10/5]{#in-CPDR}

A==(HL) or BC-1 == 0のときT16

A-(HL) (するだけ)\
BC←BC-1\
HL←HL-1\
BC != 0 ⇒ PC←PC-2

**命令**\
11 101 101\
10 111 001

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: A == (HL)
    c: BC - 1 != 0
    d: A-(HL) < 0
    e: 1
    f: A-(HL)のハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 5
  c: cl↑
  d: PA_Select_A_high\PA_Select_Dt_low\PA_SUB\PF_Write_Z\PF_Select_Z_bit19\PF_Write_S\PF_Select_S_bit7\PF_Write_H\PF_Select_H_bit22
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 
  c: cl↑
  d: PA_Select_BC_high\PA_Select_0x1_low\PA_SUB\PR_Write_B\PR_Write_C\PF_Write_P/V\PF_Select_P/V_bit20
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: PA_Select_HL_high\PA_Select_0x1_low\PA_SUB\PR_Write_H\PR_Write_L\PF_Write_N\PF_Select_N_bit17
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: if(!Flag_P/V or Flag_Z)→PR_Reset_XPT\　　　　　　　　　　　P2_Set_CM1\　　　　　　　　　　　P2_Reset_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: if(!Flag_P/V or Flag_Z)→Pa_Ophd
{{</table4R>}}
<br>
{{<table4R>}}
- a: 12
  b: 5
  c: cl↑
  d: PA_Select_PC_high\PA_Select_0x1_low\PA_SUB\PR_Write_PC_high\PR_Write_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 13
  b: 
  c: cl↑
  d: PA_Select_PC_high\PA_Select_0x1_low\PA_SUB\PR_Write_PC_high\PR_Write_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 14
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 15
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 16
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

## 8bit算術・論理演算{#in-8ari}

### *ADD A,r (X1/M1/T4) [M1]{#in-ADDAr}

A←A+r

**命令**\
10 000 rrr

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: キャリー
    b: A+r = 0
    c: V
    d: A+r < 0
    e: 0
    f: ハーフキャリー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PA_Select_A_high\PA_Select_A/B/C/D/E/H/L_low\PA_ADD\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit21\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit23
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *ADD A,n (X2/M2/T7) [M1\MA]{#in-ADDAn}

A←A+n

**命令**\
11 000 110\
nn nnn nnn

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: キャリー
    b: A+n = 0
    c: V
    d: A+n < 0
    e: 0
    f: ハーフキャリー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: P2_Set_IADDAn\PR_Reset_XPT\P2_Set_CMA
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MA
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: P2_Reset_ITABLE\PR_Reset_XPT\P2_Set_CM1\PA_Select_A_high\PA_ADD\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit21\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit23
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *ADD A,(HL) (X1/M2/T7) [M1+RA]{#in-ADDAqHLp}

A←A+(HL)

**命令**\
10 000 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: キャリー
    b: A+(HL) = 0
    c: V
    d: A+(HL) < 0
    e: 0
    f: ハーフキャリー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: RA
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PI_SelectAd_HL\PA_Select_A_high\PA_ADD\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit21\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit23
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *ADD A,(IX+d) (X3/M5/T19) [M1\M1\MR+5+RA]{#in-ADDAqIXtdp}

A←A+(IX+d)

**命令**\
11 011 101\
10 000 110\
dd ddd ddd

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: キャリー
    b: A+(IX+d) = 0
    c: V
    d: A+(IX+d) < 0
    e: 0
    f: ハーフキャリー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_IADDA(IX+d)
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: RA
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_DtexDt\PA_Select_A_high\PA_ADD\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit21\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit23
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *ADD A,(IY+d) (X3/M5/T19) [M1\M1\MR+5+RA]{#in-ADDAqIYtdp}

A←A+(IY+d)

**命令**\
11 111 101\
10 000 110\
dd ddd ddd

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: キャリー
    b: A+(IY+d) = 0
    c: V
    d: A+(IY+d) < 0
    e: 0
    f: ハーフキャリー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_IADDA(IY+d)
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: RA
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_DtexDt\PA_Select_A_high\PA_ADD\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit21\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit23
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *ADC A,r (X1/M1/T4) [M1]{#in-ADCAr}

A←A+r+Flag_C

**命令**\
10 001 rrr

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: N
F: H
items:
  - a: キャリー
    b: A+r+Flag_C = 0
    c: V
    d: A+r+Flag_C < 0
    e: 0
    f: ハーフキャリー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PA_Select_A_high\PA_Select_A/B/C/D/E/H/L_low\PA_ADC\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit21\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit23
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *ADC A,n (X2/M2/T7) [M1\MA]{#in-ADCAn}

A←A+n+Flag_C

**命令**\
11 001 110\
nn nnn nnn

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: N
F: H
items:
  - a: キャリー
    b: A+n+Flag_C = 0
    c: V
    d: A+n+Flag_C < 0
    e: 0
    f: ハーフキャリー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: P2_Set_IADCAn\PR_Reset_XPT\P2_Set_CMA
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MA
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: P2_Reset_ITABLE\PR_Reset_XPT\P2_Set_CM1\PA_Select_A_high\PA_ADC\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit21\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit23
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *ADC A,(HL) (X1/M2/T7) [M1+RA]{#in-ADCAqHLp}

A←A+(HL)+Flag_C

**命令**\
10 001 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: キャリー
    b: A+(HL)+Flag_C = 0
    c: V
    d: A+(HL)+Flag_C < 0
    e: 0
    f: ハーフキャリー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: RA
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: >-
    PR_Reset_XPT\P2_Set_CM1\PI_SelectAd_HL\PA_Select_A_high\PA_ADC\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit21\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit23
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *ADC A,(IX+d) (X3/M5/T19) [M1\M1\MR+5+RA]{#in-ADCAqIXtdp}

A←A+(IX+d)+Flag_C

**命令**\
11 011 101\
10 001 110\
dd ddd ddd

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: キャリー
    b: A+(IX+d)+Flag_C = 0
    c: V
    d: A+(IX+d)+Flag_C < 0
    e: 0
    f: ハーフキャリー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_IADCA(IX+d)
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: RA
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_DtexDt\PA_Select_A_high\PA_ADC\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit21\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit23
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *ADC A,(IY+d) (X3/M5/T19) [M1\M1\MR+5+RA]{#in-ADCAqIYtdp}

A←A+(IY+d)+Flag_C

**命令**\
11 111 101\
10 001 110\
dd ddd ddd

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: キャリー
    b: A+(IY+d)+Flag_C = 0
    c: V
    d: A+(IY+d)+Flag_C < 0
    e: 0
    f: ハーフキャリー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_IADCA(IY+d)
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: RA
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_DtexDt\PA_Select_A_high\PA_ADC\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit21\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit23
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SUB r (X1/M1/T4) [M1]{#in-SUBAr}

A←A-r

**命令**\
10 010 rrr

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: ボロー
    b: A-r = 0
    c: V
    d: A-r < 0
    e: 1
    f: ハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PA_Select_A_high\PA_Select_A/B/C/D/E/H/L_low\PA_SUB\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit22\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit17\PF_Write_C\PF_Select_C_bit26
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SUB n (X2/M2/T7) [M1\MA]{#in-SUBAn}

A←A-n

**命令**\
11 010 110\
nn nnn nnn

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: ボロー
    b: A-n = 0
    c: V
    d: A-n < 0
    e: 1
    f: ハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: P2_Set_ISUBAn\PR_Reset_XPT\P2_Set_CMA
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MA
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: P2_Reset_ITABLE\PR_Reset_XPT\P2_Set_CM1\PA_Select_A_high\PA_SUB\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit22\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit17\PF_Write_C\PF_Select_C_bit26
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SUB (HL) (X1/M2/T7) [M1+RA]{#in-SUBAqHLp}

A←A-(HL)

**命令**\
10 010 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: ボロー
    b: A-(HL) = 0
    c: V
    d: A-(HL) < 0
    e: 1
    f: ハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: RA
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PI_SelectAd_HL\PA_Select_A_high\PA_SUB\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit22\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit17\PF_Write_C\PF_Select_C_bit26
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SUB (IX+d) (X3/M5/T19) [M1\M1\MR+5+RA]{#in-SUBAqIXtdp}

A←A-(IX+d)

**命令**\
11 011 101\
10 010 110\
dd ddd ddd

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: ボロー
    b: A-(IX+d) = 0
    c: V
    d: A-(IX+d) < 0
    e: 1
    f: ハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_ISUBA(IX+d)
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: RA
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_DtexDt\PA_Select_A_high\PA_SUB\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit22\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit17\PF_Write_C\PF_Select_C_bit26
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SUB (IY+d) (X3/M5/T19) [M1\M1\MR+5+RA]{#in-SUBAqIYtdp}

A←A-(IY+d)

**命令**\
11 111 101\
10 010 110\
dd ddd ddd

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: ボロー
    b: A-(IY+d) = 0
    c: V
    d: A-(IY+d) < 0
    e: 1
    f: ハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_ISUBA(IY+d)
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: RA
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_DtexDt\PA_Select_A_high\PA_SUB\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit22\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit17\PF_Write_C\PF_Select_C_bit26
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SBC r (X1/M1/T4) [M1]{#in-SBCAr}

A←A-r-Flag_C

**命令**\
10 011 rrr

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: ボロー
    b: A-r-Flag_C = 0
    c: V
    d: A-r-Flag_C < 0
    e: 1
    f: ハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PA_Select_A_high\PA_Select_A/B/C/D/E/H/L_low\PA_SBC\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit22\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit17\PF_Write_C\PF_Select_C_bit26
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SBC n (X2/M2/T7) [M1\MA]{#in-SBCAn}

A←A-n-Flag_C

**命令**\
11 011 110\
nn nnn nnn

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: ボロー
    b: A-n-Flag_C = 0
    c: V
    d: A-n-Flag_C < 0
    e: 1
    f: ハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: P2_Set_ISBCAn\PR_Reset_XPT\P2_Set_CMA
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MA
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: P2_Reset_ITABLE\PR_Reset_XPT\P2_Set_CM1\PA_Select_A_high\PA_SBC\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit22\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit17\PF_Write_C\PF_Select_C_bit26
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SBC (HL) (X1/M2/T7) [M1+RA]{#in-SBCAqHLp}

A←A-(HL)-Flag_C

**命令**\
10 011 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: ボロー
    b: A-(HL)-Flag_C = 0
    c: V
    d: A-(HL)-Flag_C < 0
    e: 1
    f: ハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: RA
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PI_SelectAd_HL\PA_Select_A_high\PA_SBC\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit22\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit17\PF_Write_C\PF_Select_C_bit26
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SBC (IX+d) (X3/M5/T19) [M1\M1\MR+5+RA]{#in-SBCAqIXtdp}

A←A-(IX+d)-Flag_C

**命令**\
11 011 101\
10 011 110\
dd ddd ddd

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: ボロー
    b: A-(IX+d)-Flag_C = 0
    c: V
    d: A-(IX+d)-Flag_C < 0
    e: 1
    f: ハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_ISBCA(IX+d)
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: RA
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_DtexDt\PA_Select_A_high\PA_SBC\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit22\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit17\PF_Write_C\PF_Select_C_bit26
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SBC (IY+d) (X3/M5/T19) [M1\M1\MR+5+RA]{#in-SBCAqIYtdp}

A←A-(IY+d)-Flag_C

**命令**\
11 111 101\
10 011 110\
dd ddd ddd

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: ボロー
    b: A-(IY+d)-Flag_C = 0
    c: V
    d: A-(IY+d)-Flag_C < 0
    e: 1
    f: ハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_ISBCA(IY+d)
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: RA
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_DtexDt\PA_Select_A_high\PA_SBC\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit22\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit17\PF_Write_C\PF_Select_C_bit26
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *AND r (X1/M1/T4) [M1]{#in-ANDAr}

A←A&r

**命令**\
10 100 rrr

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 0
    b: A&r = 0
    c: P
    d: A&r < 0
    e: 0
    f: 1
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PA_Select_A_high\PA_Select_A/B/C/D/E/H/L_low\PA_AND\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit17\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *AND n (X2/M2/T7) [M1\MA]{#in-ANDAn}

A←A&n

**命令**\
11 100 110\
nn nnn nnn

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 0
    b: A&n = 0
    c: P
    d: A&n < 0
    e: 0
    f: 1
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: P2_Set_IANDn\PR_Reset_XPT\P2_Set_CMA
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MA
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: P2_Reset_ITABLE\PR_Reset_XPT\P2_Set_CM1\PA_Select_A_high\PA_AND\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit17\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *AND (HL) (X1/M2/T7) [M1+RA]{#in-ANDAqHLp}

A←A&(HL)

**命令**\
10 100 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 0
    b: A&(HL) = 0
    c: P
    d: A&(HL) < 0
    e: 0
    f: 1
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: RA
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PI_SelectAd_HL\PA_Select_A_high\PA_AND\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit17\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *AND (IX+d) (X3/M5/T19) [M1\M1\MR+5+RA]{#in-ANDAqIXtdp}

A←A&(IX+d)

**命令**\
11 011 101\
10 100 110\
dd ddd ddd

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 0
    b: A&(IX+d) = 0
    c: P
    d: A&(IX+d) < 0
    e: 0
    f: 1
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_IAND(IX+d)
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: RA
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_DtexDt\PA_Select_A_high\PA_AND\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit17\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *AND (IY+d) (X3/M5/T19) [M1\M1\MR+5+RA]{#in-ANDAqIYtdp}

A←A&(IY+d)

**命令**\
11 111 101\
10 100 110\
dd ddd ddd

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 0
    b: A&(IY+d) = 0
    c: P
    d: A&(IY+d) < 0
    e: 0
    f: 1
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_IAND(IY+d)
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: RA
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_DtexDt\PA_Select_A_high\PA_AND\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit17\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *OR r (X1/M1/T4) [M1]{#in-ORAr}

A←A|r

**命令**\
10 110 rrr

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 0
    b: A|r = 0
    c: P
    d: A|r < 0
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PA_Select_A_high\PA_Select_A/B/C/D/E/H/L_low\PA_OR\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit16\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *OR n (X2/M2/T7) [M1\MA]{#in-ORAn}

A←A|n

**命令**\
11 110 110\
nn nnn nnn

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 0
    b: A|n = 0
    c: P
    d: A|n < 0
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: P2_Set_IORn\PR_Reset_XPT\P2_Set_CMA
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MA
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: P2_Reset_ITABLE\PR_Reset_XPT\P2_Set_CM1\PA_Select_A_high\PA_OR\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit16\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *OR (HL) (X1/M2/T7) [M1+RA]{#in-ORAqHLp}

A←A|(HL)

**命令**\
10 110 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 0
    b: A|(HL) = 0
    c: P
    d: A|(HL) < 0
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: RA
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PI_SelectAd_HL\PA_Select_A_high\PA_OR\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit16\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *OR (IX+d) (X3/M5/T19) [M1\M1\MR+5+RA]{#in-ORAqIXtdp}

A←A|(IX+d)

**命令**\
11 011 101\
10 110 110\
dd ddd ddd

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 0
    b: A|(IX+d) = 0
    c: P
    d: A|(IX+d) < 0
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_IOR(IX+d)
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: RA
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_DtexDt\PA_Select_A_high\PA_OR\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit16\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *OR (IY+d) (X3/M5/T19) [M1\M1\MR+5+RA]{#in-ORAqIYtdp}

A←A|(IY+d)

**命令**\
11 111 101\
10 110 110\
dd ddd ddd

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 0
    b: A|(IY+d) = 0
    c: P
    d: A|(IY+d) < 0
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_IOR(IY+d)
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: RA
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_DtexDt\PA_Select_A_high\PA_OR\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit16\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *XOR r (X1/M1/T4) [M1]{#in-XORAr}

A←A^r

**命令**\
10 101 rrr

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 0
    b: A^r = 0
    c: P
    d: A^r < 0
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PA_Select_A_high\PA_Select_A/B/C/D/E/H/L_low\PA_XOR\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit16\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *XOR n (X2/M2/T7) [M1\MA]{#in-XORAn}

A←A^n

**命令**\
11 101 110\
nn nnn nnn

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 0
    b: A^n = 0
    c: P
    d: A^n < 0
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: P2_Set_IXORn\PR_Reset_XPT\P2_Set_CMA
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MA
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: P2_Reset_ITABLE\PR_Reset_XPT\P2_Set_CM1\PA_Select_A_high\PA_XOR\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit16\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *XOR (HL) (X1/M2/T7) [M1+RA]{#in-XORAqHLp}

A←A^(HL)

**命令**\
10 101 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 0
    b: A^(HL) = 0
    c: P
    d: A^(HL) < 0
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: RA
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PI_SelectAd_HL\PA_Select_A_high\PA_XOR\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit16\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *XOR (IX+d) (X3/M5/T19) [M1\M1\MR+5+RA]{#in-XORAqIXtdp}

A←A^(IX+d)

**命令**\
11 011 101\
10 101 110\
dd ddd ddd

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 0
    b: A^(IX+d) = 0
    c: P
    d: A^(IX+d) < 0
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_IXOR(IX+d)
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: RA
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_DtexDt\PA_Select_A_high\PA_XOR\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit16\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *XOR (IY+d) (X3/M5/T19) [M1\M1\MR+5+RA]{#in-XORAqIYtdp}

A←A^(IY+d)

**命令**\
11 111 101\
10 101 110\
dd ddd ddd

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 0
    b: A^(IY+d) = 0
    c: P
    d: A^(IY+d) < 0
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_IXOR(IY+d)
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: RA
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_DtexDt\PA_Select_A_high\PA_XOR\PR_Write_A\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit16\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *CP r (X1/M1/T4) [M1]{#in-CPAr}

A-r (するだけ)

**命令**\
10 111 rrr

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: ボロー
    b: A-r = 0
    c: V
    d: A-r < 0
    e: 1
    f: ハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PA_Select_A_high\PA_Select_A/B/C/D/E/H/L_low\PA_SUB\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit22\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit17\PF_Write_C\PF_Select_C_bit26
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *CP n (X2/M2/T7) [M1\MA]{#in-CPAn}

A-n

**命令**\
11 111 110\
nn nnn nnn

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: ボロー
    b: A-n = 0
    c: V
    d: A-n < 0
    e: 1
    f: ハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: P2_Set_ICPn\PR_Reset_XPT\P2_Set_CMA
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MA
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: P2_Reset_ITABLE\PR_Reset_XPT\P2_Set_CM1\PA_Select_A_high\PA_SUB\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit22\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit17\PF_Write_C\PF_Select_C_bit26
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *CP (HL) (X1/M2/T7) [M1+RA]{#in-CPAqHLp}

A-(HL)

**命令**\
10 111 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: ボロー
    b: A-(HL) = 0
    c: V
    d: A-(HL) < 0
    e: 1
    f: ハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: RA
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PI_SelectAd_HL\PA_Select_A_high\PA_SUB\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit22\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit17\PF_Write_C\PF_Select_C_bit26
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *CP (IX+d) (X3/M5/T19) [M1\M1\MR+5+RA]{#in-CPAqIXtdp}

A-(IX+d)

**命令**\
11 011 101\
10 111 110\
dd ddd ddd

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: ボロー
    b: A-(IX+d) = 0
    c: V
    d: A-(IX+d) < 0
    e: 1
    f: ハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_ICP(IX+d)
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: RA
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_DtexDt\PA_Select_A_high\PA_SUB\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit22\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit17\PF_Write_C\PF_Select_C_bit26
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *CP (IY+d) (X3/M5/T19) [M1\M1\MR+5+RA]{#in-CPAqIYtdp}

A-(IY+d)

**命令**\
11 111 101\
10 111 110\
dd ddd ddd

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: ボロー
    b: A-(IY+d) = 0
    c: V
    d: A-(IY+d) < 0
    e: 1
    f: ハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_ICP(IY+d)
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: RA
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_DtexDt\PA_Select_A_high\PA_SUB\PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit22\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit17\PF_Write_C\PF_Select_C_bit26
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *INC r (X1/M1/T4) [M1]{#in-INCr}

r←r+1

**命令**\
00 rrr 100

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: r+1 = 0
    c: V
    d: r+1 < 0
    e: 0
    f: ハーフキャリー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PA_Select_A/B/C/D/E/H/L_high\PA_Select_0x1_low\PA_ADD\PR_Write_A/B/C/D/E/H/L\?PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit21\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *INC (HL) (X1/M3/T11) [M1+R+1+W]{#in-INCqHLp}
(HL)←(HL)+1

**命令**\
00 110 100

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: "(HL)+1 = 0"
    c: V
    d: "(HL)+1 < 0"
    e: 0
    f: ハーフキャリー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 1
  c: cl↑
  d: PA_Select_Dt_high\PA_Select_0x1_low\PA_ADD\PR_Write_Dt\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit21\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: W
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *INC (IX+d) (X3/M6/T23) [M1\M1\MR+5+R+1+W]{#in-INCqIXtdp}

(IX+d)←(IX+d)+1

**命令**\
11 011 101\
00 110 100\
dd ddd ddd

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: "(IX+d)+1 = 0"
    c: V
    d: "(IX+d)+1 < 0"
    e: 0
    f: ハーフキャリー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_IINC(IX+d)
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 1
  c: cl↑
  d: PA_Select_Dt_high\PA_Select_0x1_low\PA_ADD\PR_Write_Dt\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit21\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 12
  b: W
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OP_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 13(W)
  b: 
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OP_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 14
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PA_Select_IX_high\PA_Select_OP_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *INC (IY+d) (X3/M6/T23) [M1\M1\MR+5+R+1+W]{#in-INCqIYtdp}

(IY+d)←(IY+d)+1

**命令**\
11 111 101\
00 110 100\
dd ddd ddd

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: "(IY+d)+1 = 0"
    c: V
    d: "(IY+d)+1 < 0"
    e: 0
    f: ハーフキャリー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_IINC(IY+d)
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 1
  c: cl↑
  d: PA_Select_Dt_high\PA_Select_0x1_low\PA_ADD\PR_Write_Dt\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit21\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 12
  b: W
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OP_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 13(W)
  b: 
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OP_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 14
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PA_Select_IY_high\PA_Select_OP_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *DEC r (X1/M1/T4) [M1]{#in-DECr}

r←r-1

**命令**\
00 rrr 101

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: r-1 = 0
    c: V
    d: r-1 < 0
    e: 1
    f: ハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PA_Select_A/B/C/D/E/H/L_high\PA_Select_0x1_low\PA_SUB\PR_Write_A/B/C/D/E/H/L\?PR_InvertIn\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit22\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit17
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *DEC (HL) (X1/M3/T11) [M1+R+1+W]{#in-DECqHLp}

(HL)←(HL)-1

**命令**\
00 110 101

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: "(HL)-1 = 0"
    c: V
    d: "(HL)-1 < 0"
    e: 1
    f: ハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 1
  c: cl↑
  d: PA_Select_Dt_high\PA_Select_0x1_low\PA_SUB\PR_Write_Dt\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit22\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit17
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: W
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *DEC (IX+d) (X3/M6/T23) [M1\M1\MR+5+R+1+W]{#in-DECqIXtdp}

(IX+d)←(IX+d)-1

**命令**\
11 011 101\
00 110 101\
dd ddd ddd

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: "(IX+d)-1 = 0"
    c: V
    d: "(IX+d)-1 < 0"
    e: 1
    f: ハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_IDEC(IX+d)
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 1
  c: cl↑
  d: PA_Select_Dt_high\PA_Select_0x1_low\PA_SUB\PR_Write_Dt\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit22\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit17
- a: 
  b: 
  c: cl↓
  d: 
- a: 12
  b: W
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OP_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 13(W)
  b: 
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OP_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 14
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PA_Select_IX_high\PA_Select_OP_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *DEC (IY+d) (X3/M6/T23) [M1\M1\MR+5+R+1+W]{#in-DECqIYtdp}

(IY+d)←(IY+d)-1

**命令**\
11 111 101\
00 110 101\
dd ddd ddd

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: "(IY+d)-1 = 0"
    c: V
    d: "(IY+d)-1 < 0"
    e: 1
    f: ハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_IDEC(IY+d)
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OP_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 1
  c: cl↑
  d: PA_Select_Dt_high\PA_Select_0x1_low\PA_SUB\PR_Write_Dt\PF_Write_S\PF_Select_S_bit7\PF_Write_Z\PF_Select_Z_bit24\PF_Write_H\PF_Select_H_bit22\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_N\PF_Select_N_bit17
- a: 
  b: 
  c: cl↓
  d: 
- a: 12
  b: W
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OP_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 13(W)
  b: 
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OP_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 14
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PA_Select_IY_high\PA_Select_OP_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

## 汎用算術演算およびCPU制御{#in-gpa}

### *DAA (X1/M1/T4) [M1]*DAA (X1/M1/T4) [M1]{#in-DAA}

A←A.toDec()

詳しく書くと、\
if(Flag_N)→\
　def m0x6 = (Flag_H or Aの下4bitが9より大きい)\
　def m0x60 = (Flag_C or Aが0x99より大きい)\
　switch((m0x6,m0x60)){\
　　(1,1) A.toDec() = A - 0x66\
　　(1,0) A.toDec() = A - 0x6\
　　(0,0) A.toDec() = A\
　　(0,1) A.toDec() = A -0x60\
　}\
if(!Flag_N)→\
　def p0x6 = (Flag_H or Aの下4bitが9より大きい)\
　def p0x60 = (Flag_C or Aが0x99より大きい)\
　switch((m0x6,m0x60)){\
　　(1,1) A.toDec() = A + 0x66\
　　(1,0) A.toDec() = A + 0x6\
　　(0,0) A.toDec() = A\
　　(0,1) A.toDec() = A + 0x60\
　}

**命令**\
00 100 111

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: Aが0x99より大きい or Flag_Cold
    b: A.toDec()=0
    c: P
    d: A.toDec()<0
    e: ""
    f: A_4 XOR A.toDec()_4
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC\PA_Select_A_high\PA_Select_0xaa_low\PA_SUB\PF_Write_S\PF_Select_S_bit39\PF_Write_Z\PF_Select_Z_bit21
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\if(Flag_N)→PA_SUB\if(!Flag_N)→PA_ADD\PA_Select_A_high\PR_Write_A\PR_InvertIn\if((Flag_H or Flag_Z) and (Flag_C or Flag_S))→PA_Select_0x66_low\if((Flag_H or Flag_Z) and !(Flag_C or Flag_S))→PA_Select_0x06_low\if(!(Flag_H or Flag_Z) and (Flag_C or Flag_S))→PA_Select_0x60_low\if(!(Flag_H or Flag_Z) and !(Flag_C or Flag_S))→PA_Select_0x0_low\PF_Write_C\PF_Select_C_bit29\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_H\PF_Select_H_bit28
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *CPL (X1/M1/T4) [M1]{#in-CPL}

A←NOT(A)

**命令**\
00 101 111

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: 
    c: 
    d: 
    e: 1
    f: 1
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PA_Select_A_low\PA_NOT\PR_Write_A\PR_InvertIn\PF_Write_H\PF_Select_H_bit17\PF_Write_N\PF_Select_N_bit17
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *NEG (X2/M2/T8) [M1\M1]{#in-NEG}

A←-A

**命令**\
11 101 101\
01 000 100

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: ボロー
    b: -A = 0
    c: V
    d: -A < 0
    e: 1
    f: ハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR\PA_Select_0x0_high\PA_Select_A_low\PA_SUB\PR_Write_A\PR_InvertIn\PF_Write_C\PF_Select_C_bit26\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit25\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit17\PF_Write_H\PF_Select_H_bit22
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *CCF (X1/M1/T4) [M1]{#in-CCF}

Flag_C←NOT(Flag_C)

**命令**\
00 111 111

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: Not(Flag_C)
    b: 
    c: 
    d: 
    e: 0
    f: Flag_C
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PA_Select_F_low\PA_NOT\PF_Write_H\PF_Select_H_bit30\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit0
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SCF (X1/M1/T4) [M1]{#in-SCF}

Flag_C←1

**命令**\
00 110 111

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 1
    b: 
    c: 
    d: 
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PF_Write_H\PF_Select_H_bit16\PF_Write_N\PF_Select_N_bit16\PF_Write_C\PF_Select_C_bit17
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### NOP (X1/M1/T4) [M1]{#in-NOP}

何もしない

**命令**\
00 000 000

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### HALT (X1/M1/T4) [M1]{#in-HALT}

CPUを停止させる

**命令**\
01 110 110

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: P2_Set_LHALT
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### DI (X1/M1/T4) [M1]{#in-DI}

IFF1/IFF2←0

**命令**\
11 110 011

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_IFF1\P2_Reset_IFF2
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### EI (X1/M1/T4) [M1]{#in-EI}

IFF1/IFF2←1

**命令**\
11 111 011

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_IFF1\P2_Set_IFF2
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### IM 0 (X2/M2/T8) [M1\M1]{#in-IM0}

割り込みモードを0に

**命令**\
11 101 101\
01 000 110

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR\P2_IM0
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### IM 1 (X2/M2/T8) [M1\M1]{#in-IM1}

割り込みモードを1に

**命令**\
11 101 101\
01 010 110

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR\P2_IM1
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### IM 2 (X2/M2/T8) [M1\M1]{#in-IM2}

割り込みモードを2に

**命令**\
11 101 101\
01 011 110

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR\P2_IM2
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

## 16bit算術演算{#in-16ari}

### *ADD HL,ss (X1/M3/T11) [M1+7]{#in-ADDHLss}

HL←HL+ss

**命令**\
00 ss1 001

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 16bitキャリー
    b: 
    c: 
    d: 
    e: 0
    f: 16bitハーフキャリー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 7
  c: cl↑
  d: PA_Select_HL_high\PA_Select_BC/DE/HL/SP_low\PA_ADD\PR_Write_H\PR_Write_L\PF_Write_C\PF_Select_C_bit32\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit31
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *ADC HL,ss (X2/M4/T15) [M1\M1+7]{#in-ADCHLss}

HL←HL+ss+Flag_C

**命令**\
11 101 101\
01 ss1 010

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 16bitキャリー
    b: HL+ss+Flag_C = 0
    c: V
    d: HL+ss+Flag_C < 0
    e: 0
    f: 16bitハーフキャリー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 7
  c: cl↑
  d: PA_Select_HL_high\PA_Select_BC/DE/HL/SP_low\PA_ADC\PR_Write_H\PR_Write_L\PF_Write_C\PF_Select_C_bit32\PF_Write_Z\PF_Select_Z_bit34\PF_Write_P/V\PF_Select_P/V_bit33\PF_Write_S\PF_Select_S_bit15\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit31
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SBC HL,ss (X2/M4/T15) [M1\M1+7]{#in-SBCHLss}

HL←HL-ss-Flag_C

**命令**\
11 101 101\
01 ss0 010

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 16bitボロー
    b: HL-ss-Flag_C = 0
    c: V
    d: HL-ss-Flag_C < 0
    e: 1
    f: 16bitハーフボロー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 7
  c: cl↑
  d: PA_Select_HL_high\PA_Select_BC/DE/HL/SP_low\PA_SBC\PR_Write_H\PR_Write_L\PF_Write_C\PF_Select_C_bit36\PF_Write_Z\PF_Select_Z_bit34\PF_Write_P/V\PF_Select_P/V_bit33\PF_Write_S\PF_Select_S_bit15\PF_Write_N\PF_Select_N_bit17\PF_Write_H\PF_Select_H_bit35
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *ADD IX,pp (X2/M4/T15) [M1\M1+7]{#in-ADDIXpp}

IX←IX+pp

**命令**\
11 011 101\
00 pp1 001

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 16bitキャリー
    b: 
    c: 
    d: 
    e: 0
    f: 16bitハーフキャリー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 7
  c: cl↑
  d: PA_Select_IX_high\PA_Select_BC/DE/IX/SP_low\PA_ADD\PR_Write_IX_high\PR_Write_IX_low\PF_Write_C\PF_Select_C_bit32\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit31
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *ADD IY,rr (X2/M4/T15) [M1\M1+7]{#in-ADDIYrr}

IY←IY+rr

**命令**\
11 111 101\
00 rr1 001

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 16bitキャリー
    b: 
    c: 
    d: 
    e: 0
    f: 16bitハーフキャリー
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 7
  c: cl↑
  d: PA_Select_IY_high\PA_Select_BC/DE/IY/SP_low\PA_ADD\PR_Write_IY_high\PR_Write_IY_low\PF_Write_C\PF_Select_C_bit32\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit31
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### INC ss (X1/M1/T6) [M1+2]{#in-INCss}

ss←ss+1

**命令**\
00 ss0 011

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 2
  c: cl↑
  d: PA_Select_BC/DE/HL/SP_high\PA_Select_0x1_low\PA_ADD\PR_Write_B/D/H/SP_high\PR_Write_C/E/L/SP_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### INC IX (X2/M2/T10) [M1\M1+2]{#in-INCIX}

IX←IX+1

**命令**\
11 011 101\
00 100 011

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 2
  c: cl↑
  d: PA_Select_IX_high\PA_Select_0x1_low\PA_ADD\PR_Write_IX_high\PR_Write_IX_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### INC IY (X2/M2/T10) [M1\M1+2]{#in-INCIY}

IY←IY+1

**命令**\
11 111 101\
00 100 011

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 2
  c: cl↑
  d: PA_Select_IY_high\PA_Select_0x1_low\PA_ADD\PR_Write_IY_high\PR_Write_IY_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### DEC ss (X1/M1/T6) [M1+2]{#in-DECss}

ss←ss-1

**命令**\
00 ss1 011

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 2
  c: cl↑
  d: PA_Select_BC/DE/HL/SP_high\PA_Select_0x1_low\PA_SUB\PR_Write_B/D/H/SP_high\PR_Write_C/E/L/SP_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### DEC IX (X2/M2/T10) [M1\M1+2]{#in-DECIX}

IX←IX-1

**命令**\
11 011 101\
00 101 011

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 2
  c: cl↑
  d: PA_Select_IX_high\PA_Select_0x1_low\PA_SUB\PR_Write_IX_high\PR_Write_IX_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### DEC IY (X2/M2/T10) [M1\M1+2]{#in-DECIY}

IY←IY-1

**命令**\
11 111 101\
00 101 011

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 2
  c: cl↑
  d: PA_Select_IY_high\PA_Select_0x1_low\PA_SUB\PR_Write_IY_high\PR_Write_IY_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

## 循環および桁移動{#in-rot}

### *RLCA (X1/M1/T4) [M1]{#in-RLCA}

Flag_C←A_7\
A←\[A_6,…,A_0,A_7\]

**命令**\
00 000 111

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: A_7
    b: 
    c: 
    d: 
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PA_Select_A_low\PA_RLC\PR_Write_A\PR_InvertIn\PF_Write_C\PF_Select_C_bit38\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *RLA (X1/M1/T4) [M1]{#in-RLA}

Flag_C←A_7;A←\[A_6,…,A_0,Flag_C\]

**命令**\
00 010 111

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: A_7
    b: 
    c: 
    d: 
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PA_Select_A_low\PA_RL\PR_Write_A\PR_InvertIn\PF_Write_C\PF_Select_C_bit38\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *RRCA (X1/M1/T4) [M1]{#in-RRCA}

Flag_C←A_0\
A←\[A_0,A_7,…,A_1\]

**命令**\
00 001 111

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: A_0
    b: 
    c: 
    d: 
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PA_Select_A_low\PA_RRC\PR_Write_A\PR_InvertIn\PF_Write_C\PF_Select_C_bit37\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *RRA (X1/M1/T4) [M1]{#in-RRA}

Flag_C←A_0; A←\[Flag_C,A_7,…,A_1\]

**命令**\
00 011 111

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: A_0
    b: 
    c: 
    d: 
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PA_Select_A_low\PA_RR\PR_Write_A\PR_InvertIn\PF_Write_C\PF_Select_C_bit37\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *RLC r (X2/M2/T8) [M1\M1]{#in-RLCr}

Flag_C←r_7\
r←\[r_6,…,r_0,r_7\]

**命令**\
11 001 011\
00 000 rrr

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: r_7
    b: "[r_6,…,r_0,r_7] = 0"
    c: P
    d: "[r_6,…,r_0,r_7] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XBIT
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XBIT\PA_Select_B/C/D/E/H/L/A_low\PA_RLC\PR_Write_B/C/D/E/H/L/A\?PR_InvertIn\PF_Write_C\PF_Select_C_bit38\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *RLC (HL) (X2/M4/T15) [M1\M1+R+1+W]{#in-RLCqHLp}

Flag_C←(HL)_7\
(HL)←\[(HL)_6,…,(HL)_0,(HL)_7\]

**命令**\
11 001 011\
00 000 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: "(HL)_7"
    b: "[(HL)_6,…,(HL)_0,(HL)_7] = 0"
    c: P
    d: "[(HL)_6,…,(HL)_0,(HL)_7] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XBIT
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 1
  c: cl↑
  d: PA_Select_Dt_low\PA_RLC\PR_Write_Dt\PF_Write_C\PF_Select_C_bit38\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: W
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XBIT\PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *RLC (IX+d) (X4/M6/T23) [M1\M1\MR\MR+2+R+1+W]{#in-RLCqIXtdp}

Flag_C←(IX+d)_7\
(IX+d)←\[(IX+d)_6,…,(IX+d)_0,(IX+d)_7\]

**命令**\
11 011 101\
11 001 011\
dd ddd ddd\
00 000 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: "(IX+d)_7"
    b: "[(IX+d)_6,…,(IX+d)_0,(IX+d)_7] = 0"
    c: P
    d: "[(IX+d)_6,…,(IX+d)_0,(IX+d)_7] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_XIX4_0
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_XIX4_1
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 2
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 6(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 1
  c: cl↑
  d: PA_Select_Dt_low\PA_RLC\PR_Write_Dt\PF_Write_C\PF_Select_C_bit38\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: W
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10(W)
  b: 
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIX4\PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *RLC (IY+d) (X4/M6/T23) [M1\M1\MR\MR+2+R+1+W]{#in-RLCqIYtdp}

Flag_C←(IY+d)_7\
(IY+d)←\[(IY+d)_6,…,(IY+d)_0,(IY+d)_7\]

**命令**\
11 111 101\
11 001 011\
dd ddd ddd\
00 000 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: "(IY+d)_7"
    b: "[(IY+d)_6,…,(IY+d)_0,(IY+d)_7] = 0"
    c: P
    d: "[(IY+d)_6,…,(IY+d)_0,(IY+d)_7] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_XIY4_0
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_XIY4_1
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 2
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 6(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 1
  c: cl↑
  d: PA_Select_Dt_low\PA_RLC\PR_Write_Dt\PF_Write_C\PF_Select_C_bit38\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: W
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10(W)
  b: 
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIY4\PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *RL r (X2/M2/T8) [M1\M1]{#in-RLr}

Flag_C←r_7; r←\[r_6,…,r_0,Flag_C\]

**命令**\
11 001 011\
00 010 rrr

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: r_7
    b: "[r_6,…,r_0,Flag_C] = 0"
    c: P
    d: "[r_6,…,r_0,Flag_C] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XBIT
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XBIT\PA_Select_B/C/D/E/H/L/A_low\PA_RL\PR_Write_B/C/D/E/H/L/A\?PR_InvertIn\PF_Write_C\PF_Select_C_bit38\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *RL (HL) (X2/M4/T15) [M1\M1+R+1+W]{#in-RLqHLp}

Flag_C←(HL)_7; (HL)←\[(HL)_6,…,(HL)_0,Flag_C\]

**命令**\
11 001 011\
00 010 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: "(HL)_7"
    b: "[(HL)_6,…,(HL)_0,Flag_C] = 0"
    c: P
    d: "[(HL)_6,…,(HL)_0,Flag_C] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XBIT
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 1
  c: cl↑
  d: PA_Select_Dt_low\PA_RL\PR_Write_Dt\PF_Write_C\PF_Select_C_bit38\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: W
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XBIT\PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *RL (IX+d) (X4/M6/T23) [M1\M1\MR\MR+2+R+1+W]{#in-RLqIXtdp}

Flag_C←(IX+d)_7; (IX+d)←\[(IX+d)_6,…,(IX+d)_0,Flag_C\]

**命令**\
11 011 101\
11 001 011\
dd ddd ddd\
00 010 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: "(IX+d)_7"
    b: "[(IX+d)_6,…,(IX+d)_0,Flag_C] = 0"
    c: P
    d: "[(IX+d)_6,…,(IX+d)_0,Flag_C] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_XIX4_0
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_XIX4_1
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 2
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 6(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 1
  c: cl↑
  d: PA_Select_Dt_low\PA_RL\PR_Write_Dt\PF_Write_C\PF_Select_C_bit38\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: W
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10(W)
  b: 
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIX4\PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *RL (IY+d) (X4/M6/T23) [M1\M1\MR\MR+2+R+1+W]{#in-RLqIYtdp}

Flag_C←(IY+d)_7; (IY+d)←\[(IY+d)_6,…,(IY+d)_0,Flag_C\]

**命令**\
11 111 101\
11 001 011\
dd ddd ddd\
00 010 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: "(IY+d)_7"
    b: "[(IY+d)_6,…,(IY+d)_0,Flag_C] = 0"
    c: P
    d: "[(IY+d)_6,…,(IY+d)_0,Flag_C] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_XIY4_0
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_XIY4_1
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 2
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 6(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 1
  c: cl↑
  d: PA_Select_Dt_low\PA_RL\PR_Write_Dt\PF_Write_C\PF_Select_C_bit38\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: W
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10(W)
  b: 
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIY4\PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *RRC r (X2/M2/T8) [M1\M1]{#in-RRCr}

Flag_C←r_0\
r←\[r_0,r_7,…,r_1\]

**命令**\
11 001 011\
00 001 rrr

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: r_0
    b: "[r_0,r_7,…,r_1] = 0"
    c: P
    d: "[r_0,r_7,…,r_1] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XBIT
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XBIT\PA_Select_B/C/D/E/H/L/A_low\PA_RRC\PR_Write_B/C/D/E/H/L/A\?PR_InvertIn\PF_Write_C\PF_Select_C_bit37\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *RRC (HL) (X2/M4/T15) [M1\M1+R+1+W]{#in-RRCqHLp}

Flag_C←(HL)_0\
(HL)←\[(HL)_0,(HL)_7,…,(HL)_1\]

**命令**\
11 001 011\
00 001 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: "(HL)_0"
    b: "[(HL)_0,(HL)_7,…,(HL)_1] = 0"
    c: P
    d: "[(HL)_0,(HL)_7,…,(HL)_1] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XBIT
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 1
  c: cl↑
  d: PA_Select_Dt_low\PA_RRC\PR_Write_Dt\PF_Write_C\PF_Select_C_bit37\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: W
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XBIT\PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *RRC (IX+d) (X4/M6/T23) [M1\M1\MR\MR+2+R+1+W]{#in-RRCqIXtdp}

Flag_C←(IX+d)_0\
(IX+d)←\[(IX+d)_0,(IX+d)_7,…,(IX+d)_1\]

**命令**\
11 011 101\
11 001 011\
dd ddd ddd\
00 001 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: "(IX+d)_0"
    b: "[(IX+d)_0,(IX+d)_7,…,(IX+d)_1] = 0"
    c: P
    d: "[(IX+d)_0,(IX+d)_7,…,(IX+d)_1] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_XIX4_0
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_XIX4_1
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 2
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 6(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 1
  c: cl↑
  d: PA_Select_Dt_low\PA_RRC\PR_Write_Dt\PF_Write_C\PF_Select_C_bit37\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: W
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10(W)
  b: 
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIX4\PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *RRC (IY+d) (X4/M6/T23) [M1\M1\MR\MR+2+R+1+W]{#in-RRCqIYtdp}

Flag_C←(IY+d)_0\
(IY+d)←\[(IY+d)_0,(IY+d)_7,…,(IY+d)_1\]

**命令**\
11 111 101\
11 001 011\
dd ddd ddd\
00 001 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: "(IY+d)_0"
    b: "[(IY+d)_0,(IY+d)_7,…,(IY+d)_1] = 0"
    c: P
    d: "[(IY+d)_0,(IY+d)_7,…,(IY+d)_1] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_XIY4_0
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_XIY4_1
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 2
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 6(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 1
  c: cl↑
  d: PA_Select_Dt_low\PA_RRC\PR_Write_Dt\PF_Write_C\PF_Select_C_bit37\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: W
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10(W)
  b: 
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIY4\PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *RR r (X2/M2/T8) [M1\M1]{#in-RRr}

Flag_C←r_0; r←\[Flag_C,r_7,…,r_1\]

**命令**\
11 001 011\
00 011 rrr

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: r_0
    b: "[Flag_C,r_7,…,r_1] = 0"
    c: P
    d: "[Flag_C,r_7,…,r_1] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XBIT
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XBIT\PA_Select_B/C/D/E/H/L/A_low\PA_RR\PR_Write_B/C/D/E/H/L/A\?PR_InvertIn\PF_Write_C\PF_Select_C_bit37\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *RR (HL) (X2/M4/T15) [M1\M1+R+1+W]{#in-RRqHLp}

Flag_C←(HL)_0; (HL)←\[Flag_C,(HL)_7,…,(HL)_1\]

**命令**\
11 001 011\
00 011 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: "(HL)_0"
    b: "[Flag_C,(HL)_7,…,(HL)_1] = 0"
    c: P
    d: "[Flag_C,(HL)_7,…,(HL)_1] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XBIT
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 1
  c: cl↑
  d: PA_Select_Dt_low\PA_RR\PR_Write_Dt\PF_Write_C\PF_Select_C_bit37\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: W
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XBIT\PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *RR (IX+d) (X4/M6/T23) [M1\M1\MR\MR+2+R+1+W]{#in-RRqIXtdp}

Flag_C←(IX+d)_0; (IX+d)←\[Flag_C,(IX+d)_7,…,(IX+d)_1\]

**命令**\
11 011 101\
11 001 011\
dd ddd ddd\
00 011 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: "(IX+d)_0"
    b: "[Flag_C,(IX+d)_7,…,(IX+d)_1] = 0"
    c: P
    d: "[Flag_C,(IX+d)_7,…,(IX+d)_1] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_XIX4_0
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_XIX4_1
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 2
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 6(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 1
  c: cl↑
  d: PA_Select_Dt_low\PA_RR\PR_Write_Dt\PF_Write_C\PF_Select_C_bit37\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: W
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10(W)
  b: 
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIX4\PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *RR (IY+d) (X4/M6/T23) [M1\M1\MR\MR+2+R+1+W]{#in-RRqIYtdp}

Flag_C←(IY+d)_0; r←\[Flag_C,(IY+d)_7,…,(IY+d)_1\]

**命令**\
11 111 101\
11 001 011\
dd ddd ddd\
00 011 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: "(IY+d)_0"
    b: "[Flag_C,(IY+d)_7,…,(IY+d)_1] = 0"
    c: P
    d: "[Flag_C,(IY+d)_7,…,(IY+d)_1] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_XIY4_0
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_XIY4_1
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 2
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 6(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 1
  c: cl↑
  d: PA_Select_Dt_low\PA_RR\PR_Write_Dt\PF_Write_C\PF_Select_C_bit37\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: W
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10(W)
  b: 
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIY4\PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SLA r (X2/M2/T8) [M1\M1]{#in-SLAr}

Flag_C←r_7\
r←\[r_6,…,r_0,0\]

**命令**\
11 001 011\
00 100 rrr

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: r_7
    b: "[r_6,…,r_0,0] = 0"
    c: P
    d: "[r_6,…,r_0,0] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XBIT
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XBIT\PA_Select_B/C/D/E/H/L/A_low\PA_SLA\PR_Write_B/C/D/E/H/L/A\?PR_InvertIn\PF_Write_C\PF_Select_C_bit38\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SLA (HL) (X2/M4/T15) [M1\M1+R+1+W]{#in-SLAqHLp}

Flag_C←(HL)_7\
(HL)←\[(HL)_6,…,(HL)_0,0\]

**命令**\
11 001 011\
00 100 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: "(HL)_7"
    b: "[(HL)_6,…,(HL)_0,0] = 0"
    c: P
    d: "[(HL)_6,…,(HL)_0,0] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XBIT
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 1
  c: cl↑
  d: PA_Select_Dt_low\PA_SLA\PR_Write_Dt\PF_Write_C\PF_Select_C_bit38\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: W
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XBIT\PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SLA (IX+d) (X4/M6/T23) [M1\M1\MR\MR+2+R+1+W]{#in-SLAqIXtdp}

Flag_C←(IX+d)_7\
(IX+d)←\[(IX+d)_6,…,(IX+d)_0,0\]

**命令**\
11 011 101\
11 001 011\
dd ddd ddd\
00 100 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: "(IX+d)_7"
    b: "[(IX+d)_6,…,(IX+d)_0,0] = 0"
    c: P
    d: "[(IX+d)_6,…,(IX+d)_0,0] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_XIX4_0
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_XIX4_1
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 2
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 6(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 1
  c: cl↑
  d: PA_Select_Dt_low\PA_SLA\PR_Write_Dt\PF_Write_C\PF_Select_C_bit38\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: W
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10(W)
  b: 
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIX4\PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SLA (IY+d) (X4/M6/T23) [M1\M1\MR\MR+2+R+1+W]{#in-SLAqIYtdp}

Flag_C←(IY+d)_7\
(IY+d)←\[(IY+d)_6,…,(IY+d)_0,0\]

**命令**\
11 111 101\
11 001 011\
dd ddd ddd\
00 100 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: "(IY+d)_7"
    b: "[(IY+d)_6,…,(IY+d)_0,0] = 0"
    c: P
    d: "[(IY+d)_6,…,(IY+d)_0,0] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_XIY4_0
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_XIY4_1
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 2
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 6(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 1
  c: cl↑
  d: PA_Select_Dt_low\PA_SLA\PR_Write_Dt\PF_Write_C\PF_Select_C_bit38\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: W
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10(W)
  b: 
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIY4\PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SRA r (X2/M2/T8) [M1\M1]{#in-SRAr}

Flag_C←r_0\
r←\[r_7,r_7,…,r_1\]

**命令**\
11 001 011\
00 101 rrr

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: r_0
    b: "[r_7,r_7,…,r_1] = 0"
    c: P
    d: "[r_7,r_7,…,r_1] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XBIT
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XBIT\PA_Select_B/C/D/E/H/L/A_low\PA_SRA\PR_Write_B/C/D/E/H/L/A\?PR_InvertIn\PF_Write_C\PF_Select_C_bit37\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SRA (HL) (X2/M4/T15) [M1\M1+R+1+W]{#in-SRAqHLp}

Flag_C←(HL)_0
(HL)←\[(HL)_7,(HL)_7,…,(HL)_1\]

**命令**\
11 001 011\
00 101 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: "(HL)_0"
    b: "[(HL)_7,(HL)_7,…,(HL)_1] = 0"
    c: P
    d: "[(HL)_7,(HL)_7,…,(HL)_1] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XBIT
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 1
  c: cl↑
  d: PA_Select_Dt_low\PA_SRA\PR_Write_Dt\PF_Write_C\PF_Select_C_bit37\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: W
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XBIT\PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SRA (IX+d) (X4/M6/T23) [M1\M1\MR\MR+2+R+1+W]{#in-SRAqIXtdp}

Flag_C←(IX+d)_0
(IX+d)←\[(IX+d)_7,(IX+d)_7,…,(IX+d)_1\]

**命令**\
11 011 101\
11 001 011\
dd ddd ddd\
00 101 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: "(IX+d)_0"
    b: "[(IX+d)_7,(IX+d)_7,…,(IX+d)_1] = 0"
    c: P
    d: "[(IX+d)_7,(IX+d)_7,…,(IX+d)_1] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_XIX4_0
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_XIX4_1
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 2
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 6(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 1
  c: cl↑
  d: PA_Select_Dt_low\PA_SRA\PR_Write_Dt\PF_Write_C\PF_Select_C_bit37\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: W
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10(W)
  b: 
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIX4\PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SRA (IY+d) (X4/M6/T23) [M1\M1\MR\MR+2+R+1+W]{#in-SRAqIYtdp}

Flag_C←(IY+d)_0\
(IY+d)←\[(IY+d)_7,(IY+d)_7,…,(IY+d)_1\]

**命令**\
11 111 101\
11 001 011\
dd ddd ddd\
00 101 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: "(IY+d)_0"
    b: "[(IY+d)_7,(IY+d)_7,…,(IY+d)_1] = 0"
    c: P
    d: "[(IY+d)_7,(IY+d)_7,…,(IY+d)_1] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_XIY4_0
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_XIY4_1
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 2
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 6(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 1
  c: cl↑
  d: PA_Select_Dt_low\PA_SRA\PR_Write_Dt\PF_Write_C\PF_Select_C_bit37\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: W
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10(W)
  b: 
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIY4\PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SRL r (X2/M2/T8) [M1\M1]{#in-SRLr}

Flag_C←r_0\
r←\[0,r_7,…,r_1\]

**命令**\
11 001 011\
00 111 rrr

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: r_0
    b: "[0,r_7,…,r_1] = 0"
    c: P
    d: "[0,r_7,…,r_1] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XBIT
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XBIT\PA_Select_B/C/D/E/H/L/A_low\PA_SRL\PR_Write_B/C/D/E/H/L/A\?PR_InvertIn\PF_Write_C\PF_Select_C_bit37\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SRL (HL) (X2/M4/T15) [M1\M1+R+1+W]{#in-SRLqHLp}

Flag_C←(HL)_0\
(HL)←\[0,(HL)_7,…,(HL)_1\]

**命令**\
11 001 011\
00 111 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: "(HL)_0"
    b: "[0,(HL)_7,…,(HL)_1] = 0"
    c: P
    d: "[0,(HL)_7,…,(HL)_1] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XBIT
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 1
  c: cl↑
  d: PA_Select_Dt_low\PA_SRL\PR_Write_Dt\PF_Write_C\PF_Select_C_bit37\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: W
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XBIT\PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SRL (IX+d) (X4/M6/T23) [M1\M1\MR\MR+2+R+1+W]{#in-SRLqIXtdp}

Flag_C←(IX+d)_0\
(IX+d)←\[0,(IX+d)_7,…,(IX+d)_1\]

**命令**\
11 011 101\
11 001 011\
dd ddd ddd\
00 111 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: "(IX+d)_0"
    b: "[0,(IX+d)_7,…,(IX+d)_1] = 0"
    c: P
    d: "[0,(IX+d)_7,…,(IX+d)_1] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_XIX4_0
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_XIX4_1
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 2
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 6(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 1
  c: cl↑
  d: PA_Select_Dt_low\PA_SRL\PR_Write_Dt\PF_Write_C\PF_Select_C_bit37\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: W
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10(W)
  b: 
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIX4\PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *SRL (IY+d) (X4/M6/T23) [M1\M1\MR\MR+2+R+1+W]{#in-SRLqIYtdp}

Flag_C←(IY+d)_0\
(IY+d)←\[0,(IY+d)_7,…,(IY+d)_1\]

**命令**\
11 111 101\
11 001 011\
dd ddd ddd\
00 111 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: "(IY+d)_0"
    b: "[0,(IY+d)_7,…,(IY+d)_1] = 0"
    c: P
    d: "[0,(IY+d)_7,…,(IY+d)_1] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_XIY4_0
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_XIY4_1
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 2
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 6(W)
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 1
  c: cl↑
  d: PA_Select_Dt_low\PA_SRL\PR_Write_Dt\PF_Write_C\PF_Select_C_bit37\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: W
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 10(W)
  b: 
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIY4\PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *RLD (X2/M5/T18) [M1\M1+R+4+W]{#in-RLD}

A\_{3…0}←(HL)\_{7…4}; (HL)\_{7…4}←(HL)\_{3…0}; (HL)\_{3…0}←A\_{3…0}

**命令**\
11 101 101\
01 101 111

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: "[A_7~4,(HL)_7~4] = 0"
    c: P
    d: "[A_7~4,(HL)_7~4] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 4
  c: cl↑
  d: PA_Select_A_low\PA_Select_Dt_high\PA_RLD\PR_Write_Dt\PR_Write_A\PR_InvertIn\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: W
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 12(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 13
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR\PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *RRD (X2/M5/T18) [M1\M1+R+4+W]{#in-RRD}

A\_{3…0}←(HL)\_{3…0}; (HL)\_{7…4}←A\_{3…0}; (HL)\_{3…0}←(HL)\_{7…4}

**命令**\
11 101 101\
01 100 111

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: "[A_7~4,(HL)_3~0] = 0"
    c: P
    d: "[A_7~4,(HL)_3~0] < 0"
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 4
  c: cl↑
  d: PA_Select_A_low\PA_Select_Dt_high\PA_RRD\PR_Write_Dt\PR_Write_A\PR_InvertIn\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 10
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: W
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 12(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 13
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR\PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

## bit操作および判定{#in-bit}

### *BIT b,r (X2/M2/T8) [M1\M1]{#in-BITbr}

Flag_Z←not r_b

**命令**\
11 001 011\
01 bbb rrr

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: ""
    b: "not r_b"
    c: "?"
    d: "?"
    e: 0
    f: 1
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XBIT
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XBIT\PA_Select_B/C/D/E/H/L/A_low\PA_NOP\PF_Write_Z\PF_Select_Z_bit40/41/42/43/44/45/46/47\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit17
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### *BIT b,(HL) (X2/M3/T12) [M1\M1+R+1]{#in-BITbqHLp}

Flag_Z←not (HL)_b

**命令**\
11 001 011\
01 bbb 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a:
    b: not (HL)_b
    c: "?"
    d: "?"
    e: 0
    f: 1
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XBIT
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a:
  b:
  c: cl↓
  d:
- a: 5(W)
  b:
  c: cl↑
  d: PI_SelectAd_HL
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a:
  b:
  c: cl↓
  d:
- a: 7
  b: 1
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XBIT\PA_Select_Dt_low\PA_NOP\PF_Write_Z\PF_Select_Z_bit40/41/42/43/44/45/46/47\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit17
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### *BIT b,(IX+d) (X4/M5/T20) [M1\M1\MR\MR+2+R+1]{#in-BITbqIXtdp}

Flag_Z←not (IX+d)_b

**命令**\
11 011 101\
11 001 011\
dd ddd ddd\
01 bbb 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a:
    b: not (IX+d)_b
    c: "?"
    d: "?"
    e: 0
    f: 1
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_XIX4_0
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_XIX4_1
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: 2
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a:
  b:
  c: cl↓
  d:
- a: 4
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 8
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a:
  b:
  c: cl↓
  d:
- a: 9(W)
  b:
  c: cl↑
  d: PI_SelectAd_DtexDt
- a:
  b:
  c: cl↓
  d:
- a: 10
  b:
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a:
  b:
  c: cl↓
  d:
- a: 11
  b: 1
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIX4\PA_Select_Dt_low\PA_NOP\PF_Write_Z\PF_Select_Z_bit40/41/42/43/44/45/46/47\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit17
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### *BIT b,(IY+d) (X4/M5/T20) [M1\M1\MR\MR+2+R+1]{#in-BITbqIYtdp}

Flag_Z←not (IY+d)_b

**命令**\
11 111 101\
11 001 011\
dd ddd ddd\
01 bbb 110

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a:
    b: not (IY+d)_b
    c: "?"
    d: "?"
    e: 0
    f: 1
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_XIY4_0
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_XIY4_1
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: 2
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a:
  b:
  c: cl↓
  d:
- a: 4
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 8
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a:
  b:
  c: cl↓
  d:
- a: 9(W)
  b:
  c: cl↑
  d: PI_SelectAd_DtexDt
- a:
  b:
  c: cl↓
  d:
- a: 10
  b:
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a:
  b:
  c: cl↓
  d:
- a: 11
  b: 1
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIY4\PA_Select_Dt_low\PA_NOP\PF_Write_Z\PF_Select_Z_bit40/41/42/43/44/45/46/47\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit17
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### SET b,r (X2/M2/T8) [M1\M1]{#in-SETbr}

r_b←1

**命令**\
11 001 011\
11 bbb rrr

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XBIT
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XBIT\PA_Select_B/C/D/E/H/L/A_high\PA_Select_0x1/2/4/8/10/20/40/80_low\PA_OR\PR_Write_B/C/D/E/H/L/A\?PR_InvertIn
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### SET b,(HL) (X2/M4/T15) [M1\M1+R+1+W]{#in-SETbqHLp}

(HL)_b←1

**命令**\
11 001 011\
11 bbb 110

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XBIT
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a:
  b:
  c: cl↓
  d:
- a: 5(W)
  b:
  c: cl↑
  d: PI_SelectAd_HL
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a:
  b:
  c: cl↓
  d:
- a: 7
  b: 1
  c: cl↑
  d: PA_Select_Dt_high\PA_Select_0x1/2/4/8/10/20/40/80_low\PA_OR\PR_Write_Dt
- a:
  b:
  c: cl↓
  d:
- a: 8
  b: W
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a:
  b:
  c: cl↓
  d:
- a: 9(W)
  b:
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a:
  b:
  c: cl↓
  d:
- a: 10
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XBIT\PI_SelectAd_HL\PI_SelectDt_Dt
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### SET b,(IX+d) (X4/M6/T23) [M1\M1\MR\MR+2+R+1+W]{#in-SETbqIXtdp}

(IX+d)_b←1

**命令**\
11 011 011\
11 001 011\
dd ddd ddd\
11 bbb 110

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_XIX_0
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_XIX_1
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: 2
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a:
  b:
  c: cl↓
  d:
- a: 4
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 5
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a:
  b:
  c: cl↓
  d:
- a: 6(W)
  b:
  c: cl↑
  d: PI_SelectAd_DtexDt
- a:
  b:
  c: cl↓
  d:
- a: 7
  b:
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a:
  b:
  c: cl↓
  d:
- a: 8
  b: 1
  c: cl↑
  d: PA_Select_Dt_high\PA_Select_0x1/2/4/8/10/20/40/80_low\PA_OR\PR_Write_Dt
- a:
  b:
  c: cl↓
  d:
- a: 9
  b: W
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a:
  b:
  c: cl↓
  d:
- a: 10(W)
  b:
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a:
  b:
  c: cl↓
  d:
- a: 11
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIX4\PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### SET b,(IY+d) (X4/M6/T23) [M1\M1\MR\MR+2+R+1+W]{#in-SETbqIYtdp}

(IY+d)_b←1

**命令**\
11 111 011\
11 001 011\
dd ddd ddd\
11 bbb 110

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_XIY_0
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_XIY_1
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: 2
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a:
  b:
  c: cl↓
  d:
- a: 4
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 5
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a:
  b:
  c: cl↓
  d:
- a: 6(W)
  b:
  c: cl↑
  d: PI_SelectAd_DtexDt
- a:
  b:
  c: cl↓
  d:
- a: 7
  b:
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a:
  b:
  c: cl↓
  d:
- a: 8
  b: 1
  c: cl↑
  d: PA_Select_Dt_high\PA_Select_0x1/2/4/8/10/20/40/80_low\PA_OR\PR_Write_Dt
- a:
  b:
  c: cl↓
  d:
- a: 9
  b: W
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a:
  b:
  c: cl↓
  d:
- a: 10(W)
  b:
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a:
  b:
  c: cl↓
  d:
- a: 11
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIY4\PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### RES b,r (X2/M2/T8) [M1\M1]{#in-RESbr}

r_b←0

**命令**\
11 001 011\
10 bbb rrr

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XBIT
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XBIT\PA_Select_B/C/D/E/H/L/A_high\PA_Select_0x1/2/4/8/10/20/40/80_low\PA_NLAND\PR_Write_B/C/D/E/H/L/A\?PR_InvertIn
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### RES b,(HL) (X2/M4/T15) [M1\M1+R+1+W]{#in-RESbqHLp}

(HL)_b←0

**命令**\
11 001 011\
10 bbb 110

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XBIT
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a:
  b:
  c: cl↓
  d:
- a: 5(W)
  b:
  c: cl↑
  d: PI_SelectAd_HL
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a:
  b:
  c: cl↓
  d:
- a: 7
  b: 1
  c: cl↑
  d: PA_Select_Dt_high\PA_Select_0x1/2/4/8/10/20/40/80_low\PA_NLAND\PR_Write_Dt
- a:
  b:
  c: cl↓
  d:
- a: 8
  b: W
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a:
  b:
  c: cl↓
  d:
- a: 9(W)
  b:
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a:
  b:
  c: cl↓
  d:
- a: 10
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XBIT\PI_SelectAd_HL\PI_SelectDt_Dt
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### RES b,(IX+d) (X4/M6/T23) [M1\M1\MR\MR+2+R+1+W]{#in-RESbqIXtdp}

(IX+d)_b←0

**命令**\
11 011 011\
11 001 011\
dd ddd ddd\
10 bbb 110

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIX\P2_Set_XIX_0
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_XIX_1
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: 2
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a:
  b:
  c: cl↓
  d:
- a: 4
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 5
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a:
  b:
  c: cl↓
  d:
- a: 6(W)
  b:
  c: cl↑
  d: PI_SelectAd_DtexDt
- a:
  b:
  c: cl↓
  d:
- a: 7
  b:
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a:
  b:
  c: cl↓
  d:
- a: 8
  b: 1
  c: cl↑
  d: PA_Select_Dt_high\PA_Select_0x1/2/4/8/10/20/40/80_low\PA_NLAND\PR_Write_Dt
- a:
  b:
  c: cl↓
  d:
- a: 9
  b: W
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a:
  b:
  c: cl↓
  d:
- a: 10(W)
  b:
  c: cl↑
  d: PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a:
  b:
  c: cl↓
  d:
- a: 11
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIX4\PA_Select_IX_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### RES b,(IY+d) (X4/M6/T23) [M1\M1\MR\MR+2+R+1+W]{#in-RESbqIYtdp}

(IY+d)_b←0

**命令**\
11 111 011\
11 001 011\
dd ddd ddd\
10 bbb 110

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Reset_XIY\P2_Set_XIY_0
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_XIY_1
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: 2
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PR_Write_Dt\PR_Write_Dtex
- a:
  b:
  c: cl↓
  d:
- a: 4
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 5
  b: R
  c: cl↑
  d: PI_SelectAd_DtexDt
- a:
  b:
  c: cl↓
  d:
- a: 6(W)
  b:
  c: cl↑
  d: PI_SelectAd_DtexDt
- a:
  b:
  c: cl↓
  d:
- a: 7
  b:
  c: cl↑
  d: PI_SelectAd_DtexDt\PR_Write_Dt
- a:
  b:
  c: cl↓
  d:
- a: 8
  b: 1
  c: cl↑
  d: PA_Select_Dt_high\PA_Select_0x1/2/4/8/10/20/40/80_low\PA_NLAND\PR_Write_Dt
- a:
  b:
  c: cl↓
  d:
- a: 9
  b: W
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a:
  b:
  c: cl↓
  d:
- a: 10(W)
  b:
  c: cl↑
  d: PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a:
  b:
  c: cl↓
  d:
- a: 11
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIY4\PA_Select_IY_high\PA_Select_OPold_low\PA_ADD\PI_SelectAd_ALU\PI_SelectDt_Dt
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

## 飛び越し命令{#in-jmp}

### JP nn (X3/M3/T10) [M1\MR\MA]{#in-JPnn}

PC←nn

**命令**\
11 000 011\
nn nnn nnn (low)\
nn nnn nnn (high)

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_IJPnn_0
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMA\P2_Set_IJPnn_1
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MA
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PA_Select_OPxx_low\PA_NOP\PR_Write_PC_high\PR_Write_PC_low\PR_InvertIn
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### JP cc,nn (X3/M3/T10) [M1\MR\MA]{#in-JPccnn}

(cc==True)then PC←nn

**命令**\
11 ccc 010\
nn nnn nnn (low)\
nn nnn nnn (high)

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_IJPccnn_0/1/2/3/4/5/6/7_0
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMA\P2_Set_IJPccnn_0/1/2/3/4/5/6/7_1
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MA
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\if(cc==True)→PA_Select_OPxx_low\
    　　　　　　　PA_NOP\
    　　　　　　　PR_Write_PC_high\
    　　　　　　　PR_Write_PC_low\
    　　　　　　　PR_InvertIn
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### JR e (X2/M3/T12) [M1\MR+5]{#in-JRe}

PC←PC+e

**命令**\
00 011 000\
ee eee eee -2

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_IJRe
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_PC_high\if(OP_7==0)→PA_Select_OP_low\if(OP_7==1)→PA_Select_0xffOP_low\PA_ADD\PR_Write_PC_high\PR_Write_PC_low
- a:
  b:
  c: cl↓
  d:
- a: 4
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 5
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 7
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### JR C,e (X2/M2/T7)/(X2/M3/T12) [M1\MR+0/5]{#in-JRCe}

Flag_C==1のときT12

(Flag_C==1)then PC←PC+e

**命令**\
00 111 000\
ee eee eee -2

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_IJRCe
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: if(!Flag_C)→PR_Reset_XPT\
    　　　　　　P2_Set_CM1\
    　　　　　　P2_Reset_ITABLE
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: if(!Flag_C)→Pa_Ophd
{{</table4R>}}

Flag_Cのとき

{{<table4R>}}
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_PC_high\if(OP_7==0)→PA_Select_OP_low\if(OP_7==1)→PA_Select_0xffOP_low\PA_ADD\PR_Write_PC_high\PR_Write_PC_low
- a:
  b:
  c: cl↓
  d:
- a: 4
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 5
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 7
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### JR NC,e (X2/M2/T7)/(X2/M3/T12) [M1\MR+0/5]{#in-JRNCe}

F_C==0のときT12

(F_C==0)then PC←PC+e

**命令**\
00 110 000\
ee eee eee -2

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_IJRNCe
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: if(Flag_C)→PR_Reset_XPT\
    　　　　　P2_Set_CM1\
    　　　　　P2_Reset_ITABLE
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: if(Flag_C)→Pa_Ophd
{{</table4R>}}

!Flag_Cのとき

{{<table4R>}}
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_PC_high\if(OP_7==0)→PA_Select_OP_low\if(OP_7==1)→PA_Select_0xffOP_low\PA_ADD\PR_Write_PC_high\PR_Write_PC_low
- a:
  b:
  c: cl↓
  d:
- a: 4
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 5
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 7
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### JR Z,e (X2/M2/T7)/(X2/M3/T12) [M1\MR+0/5]{#in-JRZe}

F_Z==1のときT12

(F_Z==1)then PC←PC+e

**命令**\
00 101 000\
ee eee eee -2

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_IJRZe
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: if(!Flag_Z)→PR_Reset_XPT\
    　　　　　　P2_Set_CM1\
    　　　　　　P2_Reset_ITABLE
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: if(!Flag_Z)→Pa_Ophd
{{</table4R>}}

Flag_Zのとき

{{<table4R>}}
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_PC_high\if(OP_7==0)→PA_Select_OP_low\if(OP_7==1)→PA_Select_0xffOP_low\PA_ADD\PR_Write_PC_high\PR_Write_PC_low
- a:
  b:
  c: cl↓
  d:
- a: 4
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 5
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 7
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### JR NZ,e (X2/M2/T7)/(X2/M3/T12) [M1\MR+0/5]{#in-JRNZe}

F_Z==0のときT12

(F_Z==0)then PC←PC+e

**命令**\
00 100 000\
ee eee eee -2

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_IJRNZe
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: if(Flag_Z)→PR_Reset_XPT\
    　　　　　P2_Set_CM1\
    　　　　　P2_Reset_ITABLE
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: if(Flag_Z)→Pa_Ophd
{{</table4R>}}

!Flag_Zのとき

{{<table4R>}}
- a: 3
  b: 5
  c: cl↑
  d: PA_Select_PC_high\if(OP_7==0)→PA_Select_OP_low\if(OP_7==1)→PA_Select_0xffOP_low\PA_ADD\PR_Write_PC_high\PR_Write_PC_low
- a:
  b:
  c: cl↓
  d:
- a: 4
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 5
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 7
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### JP (HL) (X1/M1/T4) [M1]{#in-JPqHLp}

PC←HL

**命令**\
11 101 001

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PA_Select_HL_low\PA_NOP\PR_Write_PC_high\PR_Write_PC_low
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### JP (IX) (X2/M2/T8) [M1\M1]{#in-JPqIXp}

PC←IX

**命令**\
11 011 101\
11 101 001

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIX
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIX\PA_Select_IX_low\PA_NOP\PR_Write_PC_high\PR_Write_PC_low
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### JP (IY) (X2/M2/T8) [M1\M1]{#in-JPqIYp}

PC←IY

**命令**\
11 111 101\
11 101 001

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XIY
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XIY\PA_Select_IY_low\PA_NOP\PR_Write_PC_high\PR_Write_PC_low
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### DJNZ e (X2/M2/T8)/(X2/M3/T13) [M1\MR+1/6]{#in-DJNZe}

B-1!=0のときT13

B←B-1\
(B!=0)thenPC←PC+e

**命令**\
00 010 000\
ee eee eee -2

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_IDJNZe
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: 1
  c: cl↑
  d: PA_Select_B_high\PA_Select_0x1_low\PA_SUB\PR_Write_B\PR_InvertIn\if(ALU_bit24)→PR_Reset_XPT\
    　　　　　　　P2_Set_CM1\
    　　　　　　　P2_Reset_ITABLE
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: if(ALU_bit24)→Pa_Ophd
{{</table4R>}}

!ALU_bit24のとき、

{{<table4R>}}
- a: 4
  b: 5
  c: cl↑
  d: PA_Select_PC_high\if(OP_7==0)→PA_Select_OP_low\if(OP_7==1)→PA_Select_0xffOP_low\PA_ADD\PR_Write_PC_high\PR_Write_PC_low
- a:
  b:
  c: cl↓
  d:
- a: 5
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 7
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 8
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

## サブルーチン接続および戻り命令{#in-sub}

### CALL nn (X3/M5/T17) [M1\MR\MR+1+W+W]{#in-CALLnn}

SP←SP-1\
(SP)←PC_high\
SP←SP-1\
(SP)←PC_low\
PC←nn

**命令**\
11 001 101\
nn nnn nnn (low)\
nn nnn nnn (high)

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_ICALLnn_0
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_ICALLnn_1
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: 1
  c: cl↑
  d: PR_Dec_SP
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high
- a:
  b:
  c: cl↓
  d:
- a: 5(W)
  b:
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high\PR_Dec_SP
- a:
  b:
  c: cl↓
  d:
- a: 7
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_low
- a:
  b:
  c: cl↓
  d:
- a: 8(W)
  b:
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_low
- a:
  b:
  c: cl↓
  d:
- a: 9
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_SP\PI_SelectDt_PC_low\PA_Select_OPOPold_low\PA_NOP\PR_Write_PC_high\PR_Write_PC_low
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### CALL cc,nn (X3/M3/T10)/(X3/M5/T17) [M1\MR\MR+0/(1+W+W)]{#in-CALLccnn}

cc==TrueのときT17

(cc==True)then{\
　SP←SP-1\
　(SP)←PC_high\
　SP←SP-1\
　(SP)←PC_low\
　PC←nn\
}

**命令**\
11 ccc 100\
nn nnn nnn (low)\
nn nnn nnn (high)

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_ICALLccnn_0/1/2/3/4/5/6/7_0
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_ICALLccnn_0/1/2/3/4/5/6/7_1
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: if(cc==False)→PR_Reset_XPT\
    　　　　　　　P2_Set_CM1\
    　　　　　　　P2_Reset_ITABLE
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: if(cc==False)→Pa_Ophd
{{</table4R>}}

cc==Trueのとき、

{{<table4R>}}
- a: 3
  b: 1
  c: cl↑
  d: PR_Dec_SP
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high
- a:
  b:
  c: cl↓
  d:
- a: 5(W)
  b:
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high\PR_Dec_SP
- a:
  b:
  c: cl↓
  d:
- a: 7
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_low
- a:
  b:
  c: cl↓
  d:
- a: 8(W)
  b:
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_low
- a:
  b:
  c: cl↓
  d:
- a: 9
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_SP\PI_SelectDt_PC_low\PA_Select_OPOPold_low\PA_NOP\PR_Write_PC_high\PR_Write_PC_low
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### RET (X1/M3/T10) [M1+R+R]{#in-RET}

PC_low←(SP)\
SP←SP+1\
PC_high←(SP)\
SP←SP+1

**命令**\
11 001 001

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_SP
- a:
  b:
  c: cl↓
  d:
- a: 5(W)
  b:
  c: cl↑
  d: PI_SelectAd_SP
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d: PI_SelectAd_SP\PR_Inc_SP\PR_Write_PC_low
- a:
  b:
  c: cl↓
  d:
- a: 7
  b: R
  c: cl↑
  d: PI_SelectAd_SP
- a:
  b:
  c: cl↓
  d:
- a: 8(W)
  b:
  c: cl↑
  d: PI_SelectAd_SP
- a:
  b:
  c: cl↓
  d:
- a: 9
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PI_SelectAd_SP\PR_Inc_SP\PR_Write_PC_high\PR_InvertIn
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### RET cc (X1/M1/T5)/(X1/M3/T11) [M1+1+0/(R+R)]{#in-RETcc}

cc==TrueのときT11

(cc==True)then{\
　PC_low←(SP)\
　SP←SP+1\
　PC_high←(SP)\
　SP←SP+1\
}

**命令**\
11 ccc 000

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: 1
  c: cl↑
  d: if(cc==False)→PR_Reset_XPT\
    　　　　　　　P2_Set_CM1
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: if(cc==False)→Pa_Ophd
{{</table4R>}}

cc==Trueのとき

{{<table4R>}}
- a: 5
  b: R
  c: cl↑
  d: PI_SelectAd_SP
- a:
  b:
  c: cl↓
  d:
- a: 6(W)
  b:
  c: cl↑
  d: PI_SelectAd_SP
- a:
  b:
  c: cl↓
  d:
- a: 7
  b:
  c: cl↑
  d: PI_SelectAd_SP\PR_Inc_SP\PR_Write_PC_low
- a:
  b:
  c: cl↓
  d:
- a: 8
  b: R
  c: cl↑
  d: PI_SelectAd_SP
- a:
  b:
  c: cl↓
  d:
- a: 9(W)
  b:
  c: cl↑
  d: PI_SelectAd_SP
- a:
  b:
  c: cl↓
  d:
- a: 10
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PI_SelectAd_SP\PR_Inc_SP\PR_Write_PC_high\PR_InvertIn
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### RETI (X2/M4/T14) [M1\M1+R+R]{#in-RETI}

割り込み機器周りのことはPIOが上手いことやってくれるのかな????(IEI/IEO)

PC_low←(SP)\
SP←SP+1\
PC_high←(SP)\
SP←SP+1

**命令**\
11 101 101\
01 001 101

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_SP
- a:
  b:
  c: cl↓
  d:
- a: 5(W)
  b:
  c: cl↑
  d: PI_SelectAd_SP
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d: PI_SelectAd_SP\PR_Inc_SP\PR_Write_PC_low
- a:
  b:
  c: cl↓
  d:
- a: 7
  b: R
  c: cl↑
  d: PI_SelectAd_SP
- a:
  b:
  c: cl↓
  d:
- a: 8(W)
  b:
  c: cl↑
  d: PI_SelectAd_SP
- a:
  b:
  c: cl↓
  d:
- a: 9
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR\PI_SelectAd_SP\PR_Inc_SP\PR_Write_PC_high\PR_InvertIn
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### RETN (X2/M4/T14) [M1\M1+R+R]{#in-RETN}

PC_low←(SP)\
SP←SP+1\
PC_high←(SP)\
SP←SP+1\
IFF1←IFF2

**命令**\
11 101 101\
01 000 101

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: R
  c: cl↑
  d: PI_SelectAd_SP
- a:
  b:
  c: cl↓
  d:
- a: 5(W)
  b:
  c: cl↑
  d: PI_SelectAd_SP
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d: PI_SelectAd_SP\PR_Inc_SP\PR_Write_PC_low
- a:
  b:
  c: cl↓
  d:
- a: 7
  b: R
  c: cl↑
  d: PI_SelectAd_SP
- a:
  b:
  c: cl↓
  d:
- a: 8(W)
  b:
  c: cl↑
  d: PI_SelectAd_SP
- a:
  b:
  c: cl↓
  d:
- a: 9
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR\PI_SelectAd_SP\PR_Inc_SP\PR_Write_PC_high\PR_InvertIn\P2_RestoreIFF
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### RST p (X1/M3/T11) [M1+1+W+W]{#in-RSTp}

SP←SP-1\
(SP)←PC_high\
SP←SP-1\
(SP)←PC_low\
PC_high←0\
PC_low←8*p

**命令**\
11 ppp 111

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 4
  b: 1
  c: cl↑
  d: PR_Dec_SP
- a:
  b:
  c: cl↓
  d:
- a: 5
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high
- a:
  b:
  c: cl↓
  d:
- a: 6(W)
  b:
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high
- a:
  b:
  c: cl↓
  d:
- a: 7
  b:
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_high\PR_Dec_SP
- a:
  b:
  c: cl↓
  d:
- a: 8
  b: W
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_low
- a:
  b:
  c: cl↓
  d:
- a: 9(W)
  b:
  c: cl↑
  d: PI_SelectAd_SP\PI_SelectDt_PC_low
- a:
  b:
  c: cl↓
  d:
- a: 10
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\PI_SelectAd_SP\PI_SelectDt_PC_low\PA_Select_0x0/8/10/18/20/28/30/38_low\PA_NOP\PR_Write_PC_high\PR_Write_PC_low
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

## 入力および出力命令{#in-io}

### IN A,(n) (X2/M3/T11) [M1\MR+I]{#in-INAqnp}

Ad_high←A\
Ad_low←n\
A←Din

**命令**\
11 011 011\
nn nnn nnn

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d: PR_Inc_PC
- a:
  b:
  c: cl↓
  d:
- a: 3
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_IINA(n)
- a:
  b:
  c: cl↓
  d:
- a: 0
  b: MR
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 1(W)
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 2
  b:
  c: cl↑
  d:
- a:
  b:
  c: cl↓
  d:
- a: 3
  b: I
  c: cl↑
  d: PI_SelectAd_AOP
- a:
  b:
  c: cl↓
  d:
- a: 4
  b:
  c: cl↑
  d: PI_SelectAd_AOP
- a:
  b:
  c: cl↓
  d:
- a: 5(W)
  b:
  c: cl↑
  d: PI_SelectAd_AOP
- a:
  b:
  c: cl↓
  d:
- a: 6
  b:
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_AOP\PR_Write_A\PR_InvertIn
- a:
  b:
  c: cl↓
  d:
- a: (E)
  b:
  c:
  d: Pa_Ophd
{{</table4R>}}

### *IN r,(C) (X2/M3/T12) [M1\M1+I]{#in-INrqCp}

Ad_low←C\
Ad_high←B\
(r≠110)then r←Din

**命令**\
11 101 101\
01 rrr 000

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: Din = 0
    c: P
    d: Din < 0
    e: 0
    f: 0
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: I
  c: cl↑
  d: PI_SelectAd_BC
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: PI_SelectAd_BC
- a: 
  b: 
  c: cl↓
  d: 
- a: 6(W)
  b: 
  c: cl↑
  d: PI_SelectAd_BC
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR\PI_SelectAd_BC\PF_Write_Z\PF_Select_Z_bit24\PF_Write_P/V\PF_Select_P/V_bit27\PF_Write_S\PF_Select_S_bit7\PF_Write_N\PF_Select_N_bit16\PF_Write_H\PF_Select_H_bit16\if(r≠110)→PR_Write_B/C/D/E/H/L/A\　　　　　?PR_InvertIn
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *INI (X2/M4/T16) [M1\M1+1+I+W]{#in-INI}

Ad_low←C\
Ad_high←B\
(HL)←Din\
B←B-1\
HL←HL+1

**命令**\
11 101 101\
10 100 010

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: B-1 == 0
    c: "?"
    d: "?"
    e: 1
    f: "?"
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: I
  c: cl↑
  d: PI_SelectAd_BC
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_BC
- a: 
  b: 
  c: cl↓
  d: 
- a: 7(W)
  b: 
  c: cl↑
  d: PI_SelectAd_BC
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 
  c: cl↑
  d: PI_SelectAd_BC\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: W
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt\PA_Select_B_high\PA_Select_0x1_low\PA_SUB\PR_Write_B\PF_Write_Z\PF_Select_Z_bit24\PF_Write_N\PF_Select_N_bit17
- a: 
  b: 
  c: cl↓
  d: 
- a: 10(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR\PI_SelectAd_HL\PI_SelectDt_Dt\PA_Select_HL_high\PA_Select_0x1_low\PA_ADD\PR_Write_H\PR_Write_L
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *INIR (X2/M5/T21)/(X2/M4/T16) [M1\M1+1+I+W+5/0]{#in-INIR}

B - 1 == 0のときはT16

Ad_low←C\
Ad_high←B\
(HL)←Din\
B←B-1\
HL←HL+1\
B != 0 ⇒ PC←PC-2

**命令**\
11 101 101\
10 110 010

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: B-1 == 0
    c: "?"
    d: "?"
    e: 1
    f: "?"
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: I
  c: cl↑
  d: PI_SelectAd_BC
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_BC
- a: 
  b: 
  c: cl↓
  d: 
- a: 7(W)
  b: 
  c: cl↑
  d: PI_SelectAd_BC
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 
  c: cl↑
  d: PI_SelectAd_BC\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: W
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt\PA_Select_B_high\PA_Select_0x1_low\PA_SUB\PR_Write_B\PF_Write_Z\PF_Select_Z_bit24\PF_Write_N\PF_Select_N_bit17
- a: 
  b: 
  c: cl↓
  d: 
- a: 10(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt\PA_Select_HL_high\PA_Select_0x1_low\PA_ADD\PR_Write_H\PR_Write_L\if(Flag_Z)→PR_Reset_XPT\　　　　　P2_Set_CM1\　　　　　P2_Reset_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: if(Flag_Z)→Pa_Ophd
{{</table4R>}}

!Flag_Zのとき、

{{<table4R>}}
- a: 12
  b: 5
  c: cl↑
  d: PA_Select_PC_high\PA_Select_0x1_low\PA_SUB\PR_Write_PC_high\PR_Write_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 13
  b: 
  c: cl↑
  d: PA_Select_PC_high\PA_Select_0x1_low\PA_SUB\PR_Write_PC_high\PR_Write_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 14
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 15
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 16
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *IND (X2/M4/T16) [M1\M1+1+I+W]{#in-IND}

Ad_low←C\
Ad_high←B\
(HL)←Din\
B←B-1\
HL←HL-1

**命令**\
11 101 101\
10 101 010

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: B-1 == 0
    c: "?"
    d: "?"
    e: 1
    f: "?"
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: I
  c: cl↑
  d: PI_SelectAd_BC
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_BC
- a: 
  b: 
  c: cl↓
  d: 
- a: 7(W)
  b: 
  c: cl↑
  d: PI_SelectAd_BC
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 
  c: cl↑
  d: PI_SelectAd_BC\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: W
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt\PA_Select_B_high\PA_Select_0x1_low\PA_SUB\PR_Write_B\PF_Write_Z\PF_Select_Z_bit24\PF_Write_N\PF_Select_N_bit17
- a: 
  b: 
  c: cl↓
  d: 
- a: 10(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR\PI_SelectAd_HL\PI_SelectDt_Dt\PA_Select_HL_high\PA_Select_0x1_low\PA_SUB\PR_Write_H\PR_Write_L
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### INDR (X2/M5/T21)/(X2/M4/T16) [M1\M1+1+I+W+5/0]{#in-INDR}

B - 1 == 0のときはT16

Ad_low←C\
Ad_high←B\
(HL)←Din\
B←B-1\
HL←HL-1\
B != 0 ⇒ PC←PC-2

**命令**\
11 101 101\
10 111 010

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: B-1 == 0
    c: "?"
    d: "?"
    e: 1
    f: "?"
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: I
  c: cl↑
  d: PI_SelectAd_BC
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PI_SelectAd_BC
- a: 
  b: 
  c: cl↓
  d: 
- a: 7(W)
  b: 
  c: cl↑
  d: PI_SelectAd_BC
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: 
  c: cl↑
  d: PI_SelectAd_BC\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: W
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt\PA_Select_B_high\PA_Select_0x1_low\PA_SUB\PR_Write_B\PF_Write_Z\PF_Select_Z_bit24\PF_Write_N\PF_Select_N_bit17
- a: 
  b: 
  c: cl↓
  d: 
- a: 10(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PI_SelectDt_Dt\PA_Select_HL_high\PA_Select_0x1_low\PA_SUB\PR_Write_H\PR_Write_L\if(Flag_Z)→PR_Reset_XPT\　　　　　P2_Set_CM1\　　　　　P2_Reset_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: if(Flag_Z)→Pa_Ophd
{{</table4R>}}

!Flag_Zのとき、

{{<table4R>}}
- a: 12
  b: 5
  c: cl↑
  d: PA_Select_PC_high\PA_Select_0x1_low\PA_SUB\PR_Write_PC_high\PR_Write_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 13
  b: 
  c: cl↑
  d: PA_Select_PC_high\PA_Select_0x1_low\PA_SUB\PR_Write_PC_high\PR_Write_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 14
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 15
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 16
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### OUT (n),A (X2/M3/T11) [M1\MR+O]{#in-OUTqnpA}

Ad_high←A\
Ad_low←n\
Dout←A

**命令**\
11 010 011\
nn nnn nnn

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CMR\P2_Set_IOUT(n)A
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: MR
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: O
  c: cl↑
  d: PI_SelectAd_AOP\PI_SelectDt_A
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 
  c: cl↑
  d: PI_SelectAd_AOP\PI_SelectDt_A
- a: 
  b: 
  c: cl↓
  d: 
- a: 5(W)
  b: 
  c: cl↑
  d: PI_SelectAd_AOP\PI_SelectDt_A
- a: 
  b: 
  c: cl↓
  d: 
- a: 6
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_ITABLE\PI_SelectAd_AOP\PI_SelectDt_A
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### OUT (C),r (X2/M3/T12) [M1\M1+O]{#in-OUTqCpr}

Ad_high←B\
Ad_low←C\
Dout←r

**命令**\
11 101 101\
01 rrr 001

{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: O
  c: cl↑
  d: PI_SelectAd_BC\PI_SelectDt_B/C/D/E/H/L/A
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: 
  c: cl↑
  d: PI_SelectAd_BC\PI_SelectDt_B/C/D/E/H/L/A
- a: 
  b: 
  c: cl↓
  d: 
- a: 6(W)
  b: 
  c: cl↑
  d: PI_SelectAd_BC\PI_SelectDt_B/C/D/E/H/L/A
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR\PI_SelectAd_BC\PI_SelectDt_B/C/D/E/H/L/A
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *OUTI (X2/M4/T16) [M1\M1+1+R+O]{#in-OUTI}

Ad_high←B\
Ad_low←C\
Dout←(HL)\
B←B-1\
HL←HL+1

**命令**\
11 101 101\
10 100 011

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: B-1 == 0
    c: "?"
    d: "?"
    e: 1
    f: "?"
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: O
  c: cl↑
  d: PI_SelectAd_BC\PI_SelectDt_Dt\PA_Select_B_high\PA_Select_0x1_low\PA_SUB\PF_Write_Z\PF_Select_Z_bit24\PF_Write_N\PF_Select_N_bit17
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: PI_SelectAd_BC\PI_SelectDt_Dt\PA_Select_HL_high\PA_Select_0x1_low\PA_ADD\PR_Write_H\PR_Write_L
- a: 
  b: 
  c: cl↓
  d: 
- a: 10(W)
  b: 
  c: cl↑
  d: PI_SelectAd_BC\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR\PI_SelectAd_BC\PI_SelectDt_Dt\PA_Select_B_high\PA_Select_0x1_low\PA_SUB\PR_Write_B
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *OTIR (X2/M5/T21)/(X2/M4/T16) [M1\M1+1+R+O+5/0]{#in-OTIR}

B - 1 == 0のときはT16

Ad_high←B\
Ad_low←C\
Dout←(HL)\
B←B-1\
HL←HL+1\
B != 0 ⇒ PC←PC-2

**命令**\
11 101 101\
10 110 011

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: B-1 == 0
    c: "?"
    d: "?"
    e: 1
    f: "?"
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: O
  c: cl↑
  d: PI_SelectAd_BC\PI_SelectDt_Dt\PA_Select_B_high\PA_Select_0x1_low\PA_SUB\PF_Write_Z\PF_Select_Z_bit24\PF_Write_N\PF_Select_N_bit17
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: PI_SelectAd_BC\PI_SelectDt_Dt\PA_Select_HL_high\PA_Select_0x1_low\PA_ADD\PR_Write_H\PR_Write_L
- a: 
  b: 
  c: cl↓
  d: 
- a: 10(W)
  b: 
  c: cl↑
  d: PI_SelectAd_BC\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PI_SelectAd_BC\PI_SelectDt_Dt\PA_Select_B_high\PA_Select_0x1_low\PA_SUB\PR_Write_B\if(Flag_Z)→PR_Reset_XPT\　　　　　P2_Set_CM1\　　　　　P2_Reset_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: if(Flag_Z)→Pa_Ophd
{{</table4R>}}

!Flag_Zのとき

{{<table4R>}}
- a: 12
  b: 5
  c: cl↑
  d: PA_Select_PC_high\PA_Select_0x1_low\PA_SUB\PR_Write_PC_high\PR_Write_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 13
  b: 
  c: cl↑
  d: PA_Select_PC_high\PA_Select_0x1_low\PA_SUB\PR_Write_PC_high\PR_Write_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 14
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 15
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 16
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *OUTD (X2/M4/T16) [M1\M1+1+R+O]{#in-OUTD}

Ad_high←B\
Ad_low←C\
Dout←(HL)\
B←B-1\
HL←HL-1

**命令**\
11 101 101\
10 101 011

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: B-1 == 0
    c: "?"
    d: "?"
    e: 1
    f: "?"
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: O
  c: cl↑
  d: PI_SelectAd_BC\PI_SelectDt_Dt\PA_Select_B_high\PA_Select_0x1_low\PA_SUB\PF_Write_Z\PF_Select_Z_bit24\PF_Write_N\PF_Select_N_bit17
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: PI_SelectAd_BC\PI_SelectDt_Dt\PA_Select_HL_high\PA_Select_0x1_low\PA_SUB\PR_Write_H\PR_Write_L
- a: 
  b: 
  c: cl↓
  d: 
- a: 10(W)
  b: 
  c: cl↑
  d: PI_SelectAd_BC\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR\PI_SelectAd_BC\PI_SelectDt_Dt\PA_Select_B_high\PA_Select_0x1_low\PA_SUB\PR_Write_B
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

### *OTDR (X2/M5/T21)/(X2/M4/T16) [M1\M1+1+R+O+5/0]{#in-OTDR}

B - 1 == 0のときはT16

Ad_high←B\
Ad_low←C\
Dout←(HL)\
B←B-1\
HL←HL-1\
B != 0 ⇒ PC←PC-2

**命令**\
11 101 101\
10 111 011

**フラグ変化**
{{<table6HM>}}
A: C
B: Z
C: P/V
D: S
E: "N"
F: H
items:
  - a: 
    b: B-1 == 0
    c: "?"
    d: "?"
    e: 1
    f: "?"
{{</table6HM>}}
<br>
{{<table4R>}}
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Set_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: 0
  b: M1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 1(W)
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 2
  b: 
  c: cl↑
  d: PR_Inc_PC
- a: 
  b: 
  c: cl↓
  d: 
- a: 3
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 4
  b: 1
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 5
  b: R
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 6(W)
  b: 
  c: cl↑
  d: PI_SelectAd_HL
- a: 
  b: 
  c: cl↓
  d: 
- a: 7
  b: 
  c: cl↑
  d: PI_SelectAd_HL\PR_Write_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 8
  b: O
  c: cl↑
  d: PI_SelectAd_BC\PI_SelectDt_Dt\PA_Select_B_high\PA_Select_0x1_low\PA_SUB\PF_Write_Z\PF_Select_Z_bit24\PF_Write_N\PF_Select_N_bit17
- a: 
  b: 
  c: cl↓
  d: 
- a: 9
  b: 
  c: cl↑
  d: PI_SelectAd_BC\PI_SelectDt_Dt\PA_Select_HL_high\PA_Select_0x1_low\PA_SUB\PR_Write_H\PR_Write_L
- a: 
  b: 
  c: cl↓
  d: 
- a: 10(W)
  b: 
  c: cl↑
  d: PI_SelectAd_BC\PI_SelectDt_Dt
- a: 
  b: 
  c: cl↓
  d: 
- a: 11
  b: 
  c: cl↑
  d: PI_SelectAd_BC\PI_SelectDt_Dt\PA_Select_B_high\PA_Select_0x1_low\PA_SUB\PR_Write_B\if(Flag_Z)→PR_Reset_XPT\　　　　　P2_Set_CM1\　　　　　P2_Reset_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: if(Flag_Z)→Pa_Ophd
{{</table4R>}}

!Flag_Zのとき

{{<table4R>}}
- a: 12
  b: 5
  c: cl↑
  d: PA_Select_PC_high\PA_Select_0x1_low\PA_SUB\PR_Write_PC_high\PR_Write_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 13
  b: 
  c: cl↑
  d: PA_Select_PC_high\PA_Select_0x1_low\PA_SUB\PR_Write_PC_high\PR_Write_PC_low
- a: 
  b: 
  c: cl↓
  d: 
- a: 14
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 15
  b: 
  c: cl↑
  d: 
- a: 
  b: 
  c: cl↓
  d: 
- a: 16
  b: 
  c: cl↑
  d: PR_Reset_XPT\P2_Set_CM1\P2_Reset_XOTR
- a: 
  b: 
  c: cl↓
  d: 
- a: (E)
  b: 
  c: 
  d: Pa_Ophd
{{</table4R>}}

<br>
{{<line>}}

## 命令分布{#instuructiontable}

### X1{#it-x1}

![X1](https://media.yamanekovillage.com/norz_3_x1.webp)

### XIX{#it-xix}

11 011 101⇨

![XIX](https://media.yamanekovillage.com/norz_3_xix.webp)

### XIX4{#it-xix4}

11 011 101⇨11 001 011⇨dd ddd ddd⇨

![XIX4](https://media.yamanekovillage.com/norz_3_xix4.webp)

### XIY{#it-xiy}

11 111 101⇨

![XIY](https://media.yamanekovillage.com/norz_3_xiy.webp)

### XIY4{#it-xiy4}

11 111 101⇨11 001 011⇨dd ddd ddd⇨

![XIY4](https://media.yamanekovillage.com/norz_3_xiy4.webp)

### XOTR{#it-xotr}

11 101 101⇨

![XOTR](https://media.yamanekovillage.com/norz_3_xotr.webp)

### XBIT{#it-xbit}

11 001 011⇨

![XBIT](https://media.yamanekovillage.com/norz_3_xbit.webp)

{{<line>}}

<br>
{{<box-frame>}}
まえ↓
{{< link-blog norz_2 >}}
<p>つぎ↓</p>
{{< link-blog norz_4 >}}
{{</box-frame>}}

<br>
{{<push>}}