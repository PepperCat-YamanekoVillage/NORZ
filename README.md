# NORZ

NORZ is a project to create a Z80-compatible CPU using only NOR gates.

</br>

The project is progressing according to the following roadmap:
- [x] Draft the CPU design based on the Z80 specifications
- [x] Write the Verilog code
- [x] Debug the Verilog code
- [ ] Implement the design on a board
- [ ] Debug the board

</br>

### My blogs (ja)

[Gates consisting of NOR](https://yamanekovillage.com/articles/norz_1/)

[Modules consisting of NOR](https://yamanekovillage.com/articles/norz_2/)

[NORZ(Z80)\'s architecture](https://yamanekovillage.com/articles/norz_3/)

[NORZ on Verilog](https://yamanekovillage.com/articles/norz_4/)

[Debuging NORZ on Verilog](https://yamanekovillage.com/articles/norz_5/)

</br>

## Confirmed instructions in Verilog

### 8-Bit Load Group
- [x] LD r,r’
- [x] LD r,n
- [x] LD r,(HL)
- [x] LD r,(IX+d)
- [x] LD r,(IY+d)
- [x] LD (HL),r
- [x] LD (IX+d),r
- [x] LD (IY+d),r
- [x] LD (HL),n
- [x] LD (IX+d),n
- [x] LD (IY+d),n
- [x] LD A,(BC)
- [x] LD A,(DE)
- [x] LD A,(nn)
- [x] LD (BC),A
- [x] LD (DE),A
- [x] LD (nn),A
- [x] LD A,I
- [x] LD A,R
- [x] LD I,A
- [x] LD R,A

### 16-Bit Load Group
- [x] LD dd,nn
- [x] LD IX,nn
- [x] LD IY,nn
- [x] LD HL,(nn)
- [x] LD dd,(nn)
- [x] LD IX,(nn)
- [x] LD IY,(nn)
- [x] LD (nn),HL
- [x] LD (nn),dd
- [x] LD (nn),IX
- [x] LD (nn),IY
- [x] LD SP,HL
- [x] LD SP,IX
- [x] LD SP,IY
- [x] PUSH qq
- [x] PUSH IX
- [x] PUSH IY
- [x] POP qq
- [x] POP IX
- [x] POP IY

### Exchange, Block Transfer, and Search Group
- [x] EX DE,HL
- [x] EX AF,AF
- [x] EXX
- [x] EX (SP),HL
- [x] EX (SP),IX
- [x] EX (SP),IY
- [x] LDI
- [x] LDIR
- [x] LDD
- [x] LDDR
- [x] CPI
- [x] CPIR
- [x] CPD
- [x] CPDR

### 8-Bit Arithmetic Group
- [x] ADD A,r
- [x] ADD A,n
- [x] ADD A,(HL)
- [x] ADD A,(IX+d)
- [x] ADD A,(IY+d)
- [x] ADC A,r
- [x] ADC A,n
- [x] ADC A,(HL)
- [x] ADC A,(IX+d)
- [x] ADC A,(IY+d)
- [x] SUB r
- [x] SUB n
- [x] SUB (HL)
- [x] SUB (IX+d)
- [x] SUB (IY+d)
- [x] SBC r
- [x] SBC n
- [x] SBC (HL)
- [x] SBC (IX+d)
- [x] SBC (IY+d)
- [x] AND r
- [x] AND n
- [x] AND (HL)
- [x] AND (IX+d)
- [x] AND (IY+d)
- [x] OR r
- [x] OR n
- [x] OR (HL)
- [x] OR (IX+d)
- [x] OR (IY+d)
- [x] XOR r
- [x] XOR n
- [x] XOR (HL)
- [x] XOR (IX+d)
- [x] XOR (IY+d)
- [x] CP r
- [x] CP n
- [x] CP (HL)
- [x] CP (IX+d)
- [x] CP (IY+d)
- [x] INC r
- [x] INC (HL)
- [x] INC (IX+d)
- [x] INC (IY+d)
- [x] DEC r
- [x] DEC (HL)
- [x] DEC (IX+d)
- [x] DEC (IY+d)

### General-Purpose Arithmetic and CPU Control Groups
- [x] DAA
- [x] CPL
- [x] NEG
- [x] CCF
- [x] SCF
- [x] NOP
- [x] HALT
- [x] DI
- [x] EI
- [x] IM 0
- [x] IM 1
- [x] IM 2

### 16-Bit Arithmetic Group
- [x] ADD HL,ss
- [x] ADC HL,ss
- [x] SBC HL,ss
- [x] ADD IX,pp
- [x] ADD IY,rr
- [x] INC ss
- [x] INC IX
- [x] INC IY
- [x] DEC ss
- [x] DEC IX
- [x] DEC IY

### Rotate and Shift Group
- [x] RLCA
- [x] RLA
- [x] RRCA
- [x] RRA
- [x] RLC r
- [x] RLC (HL)
- [x] RLC (IX+d)
- [x] RLC (IY+d)
- [x] RL r
- [x] RL (HL)
- [x] RL (IX+d)
- [x] RL (IY+d)
- [x] RRC r
- [x] RRC (HL)
- [x] RRC (IX+d)
- [x] RRC (IY+d)
- [x] RR r
- [x] RR (HL)
- [x] RR (IX+d)
- [x] RR (IY+d)
- [x] SLA r
- [x] SLA (HL)
- [x] SLA (IX+d)
- [x] SLA (IY+d)
- [x] SRA r
- [x] SRA (HL)
- [x] SRA (IX+d)
- [x] SRA (IY+d)
- [x] SRL r
- [x] SRL (HL)
- [x] SRL (IX+d)
- [x] SRL (IY+d)
- [x] RLD
- [x] RRD

### Bit Set, Reset, and Test Group
- [x] BIT b,r
- [x] BIT b,(HL)
- [x] BIT b,(IX+d)
- [x] BIT b,(IY+d)
- [x] SET b,r
- [x] SET b,(HL)
- [x] SET b,(IX+d)
- [x] SET b,(IY+d)
- [x] RES b,r
- [x] RES b,(HL)
- [x] RES b,(IX+d)
- [x] RES b,(IY+d)

### Jump Group
- [x] JP nn
- [x] JP cc,nn
- [x] JR e
- [x] JR C,e
- [x] JR NC,e
- [x] JR Z,e
- [x] JR NZ,e
- [x] JP (HL)
- [x] JP (IX)
- [x] JP (IY)
- [x] DJNZ e

### Call and Return Group
- [x] CALL nn
- [x] CALL cc,nn
- [x] RET
- [x] RET cc
- [x] RETI
- [x] RETN
- [x] RST p

### Input and Output Group
- [x] IN A,(n)
- [x] IN r,(C)
- [x] INI
- [x] INIR
- [x] IND
- [x] INDR
- [x] OUT (n),A
- [x] OUT (C),r
- [x] OUTI
- [x] OTIR
- [x] OUTD
- [x] OTDR