import re
import cocotb
from cocotb.triggers import Timer

# define
DURATION_TIME = 1000
WAIT = True

# M1(0000:0~3)/MR(0001:0~2)/RA(0008:4~6)
#PROGRAM_PATH = "/Users/Pepper/verilog/norz_verilog/_test/tests_txt/AR8/ADD A,(HL).txt"
# MA(0003:0~2)
#PROGRAM_PATH = "/Users/Pepper/verilog/norz_verilog/_test/tests_txt/AR8/ADD A,n.txt"
# W(0006:4~6)/R(0009:4~6)
#PROGRAM_PATH = "/Users/Pepper/verilog/norz_verilog/_test/tests_txt/LD8/LD r,(HL).txt"
# I(0029:4~7)
#PROGRAM_PATH = "/Users/Pepper/verilog/norz_verilog/_test/tests_txt/IO/IN r,(C).txt"
# O(000e:4~7)
PROGRAM_PATH = "/Users/Pepper/verilog/norz_verilog/_test/tests_txt/IO/OUT (C),r.txt"

async def init(_dut, duration_time):
    _dut.interfaceDt_in.value = 0
    _dut.BUSRQ.value = 1
    _dut.RESET.value = 1
    _dut.WAIT.value = 1
    _dut.NMI.value = 1
    _dut.INT.value = 1
    _dut.Clk.value = 1
    await Timer(duration_time, units="ns")

async def reset(_dut,duration_time):
    _dut.RESET.value = 0
    _dut.Clk.value = 0
    await Timer(duration_time, units="ns")
    _dut.Clk.value = 1
    await Timer(duration_time, units="ns")
    _dut.Clk.value = 0
    await Timer(duration_time, units="ns")
    _dut.Clk.value = 1
    await Timer(duration_time, units="ns")
    _dut.Clk.value = 0
    await Timer(duration_time, units="ns")
    _dut.Clk.value = 1
    await Timer(duration_time, units="ns")
    _dut.RESET.value = 1
    _dut.Clk.value = 0
    await Timer(duration_time, units="ns")
    _dut.Clk.value = 1
    await Timer(duration_time, units="ns")
    _dut.Clk.value = 0
    await Timer(duration_time, units="ns")
    _dut.Clk.value = 1
    await Timer(duration_time, units="ns")

def printlist(name,list):
    if('x' in str(list)):
        print(name + ":    BIN "+ str(list))
        return

    if('z' in str(list)):
        print(name + ":    BIN "+ str(list))
        return

    print(name + ":    BIN "+ str(list) + "    DEC:" + str(list.integer))

def printall(_dut):
    print("")
    print("----------------------------------------")
    printlist("intAd  ",_dut.interfaceAd.value)
    printlist("intDt  ",_dut.interfaceDt_out.value)
    printlist("intBSK ",_dut.interfaceBUSAK.value)
    printlist("intMRQ ",_dut.interfaceMREQ.value)
    printlist("intRD  ",_dut.interfaceRD.value)
    printlist("intWR  ",_dut.interfaceWR.value)
    printlist("intRFH ",_dut.interfaceRFSH.value)
    printlist("intIOQ ",_dut.interfaceIORQ.value)
    printlist("intM1  ",_dut.interfaceM1.value)
    printlist("intHLT ",_dut.interfaceHALT.value)
    print("")
    printlist("regA    ",_dut.debugA.value)
    printlist("regF    ",_dut.debugF.value)
    printlist("regB    ",_dut.debugB.value)
    printlist("regC    ",_dut.debugC.value)
    printlist("regD    ",_dut.debugD.value)
    printlist("regE    ",_dut.debugE.value)
    printlist("regH    ",_dut.debugH.value)
    printlist("regL    ",_dut.debugL.value)
    printlist("regPC   ",_dut.debugPC.value)
    printlist("regSP   ",_dut.debugSP.value)
    printlist("regIX   ",_dut.debugIX.value)
    printlist("regIY   ",_dut.debugIY.value)
    printlist("regI    ",_dut.debugI.value)
    printlist("regR    ",_dut.debugR.value)
    printlist("regDt   ",_dut.debugDt.value)
    printlist("regDex  ",_dut.debugDtex.value)
    printlist("regDcs  ",_dut.debugDtcs.value)
    printlist("regOP   ",_dut.debugOP.value)
    printlist("regOPo  ",_dut.debugOPold.value)
    printlist("regXPT  ",_dut.debugXPT.value)
    printlist("regITB  ",_dut.debugITABLE.value)
    printlist("ALU     ",_dut.debugALU.value)
    print("")
    printlist("IFF1    ",_dut.debugIFF1.value)
    printlist("IFF2    ",_dut.debugIFF2.value)
    printlist("IMFa    ",_dut.debugIMFa.value)
    printlist("IMFb    ",_dut.debugIMFb.value)
    printlist("TINT    ",_dut.debugTINT.value)
    printlist("TNMI    ",_dut.debugTNMI.value)
    printlist("TWAIT   ",_dut.debugTWAIT.value)
    printlist("TRESET  ",_dut.debugTRESET.value)
    printlist("XIX     ",_dut.debugXIX.value)
    printlist("XIX40   ",_dut.debugXIX4_0.value)
    printlist("XIX41   ",_dut.debugXIX4_1.value)
    printlist("XIY     ",_dut.debugXIY.value)
    printlist("XIY40   ",_dut.debugXIY4_0.value)
    printlist("XIY41   ",_dut.debugXIY4_1.value)
    printlist("XOTR    ",_dut.debugXOTR.value)
    printlist("XBIT    ",_dut.debugXBIT.value)
    printlist("CM1     ",_dut.debugCM1.value)
    printlist("CMR     ",_dut.debugCMR.value)
    printlist("CMA     ",_dut.debugCMA.value)
    printlist("CBSRQ   ",_dut.debugCBUSRQ.value)
    printlist("CRST    ",_dut.debugCRESET.value)
    printlist("CNMI    ",_dut.debugCNMI.value)
    printlist("CINT0   ",_dut.debugCINT0.value)
    printlist("CINT0R  ",_dut.debugCINT0_RST.value)
    printlist("CINT0C  ",_dut.debugCINT0_CALL.value)
    printlist("CINT1   ",_dut.debugCINT1.value)
    printlist("CINT2   ",_dut.debugCINT2.value)
    print("----------------------------------------")
    print("")

class Memory:
    def __init__(self, path):
        # (op,test[],comment)
        # test is X=ZZ ZZZ ZZZの形式
        self.instruction_memory_list = []
        # (address,data)
        self.virtual_memory_dict = {}
        self.test = 0

        with open(path, 'r') as file:
            lines = file.readlines()
            for line in lines:
                optest = 0
                comment = 0
                line = line.replace("\n","")
                if re.search("//", line):
                    splitted = line.split("//")
                    optest = splitted[0]
                    comment = "//" + splitted[1]
                else:
                    optest = line

                optest = optest.replace(" ","")

                op = 0
                test = 0
                if re.search(r"\[", optest):
                    splitted = optest.split("[")
                    op = splitted[0]
                    test = splitted[1].replace("]","")
                else:
                    op = optest
                
                if(op!=0 and op!=""):
                    self.instruction_memory_list.append((op,test,comment))

        # 読み込んだ命令列の表示
        print("")
        print("")
        print("----------------------------------------")
        print("BINARY CODES")
        print("")
        for op in self.instruction_memory_list:
            print(op)
        print("----------------------------------------")
        print("")

    def print_virtual_memory(self):
        print("VMEM")
        for key in self.virtual_memory_dict:
            print("(" + key + ") " + self.virtual_memory_dict[key])
        print("----------------------------------------")
        print("")
        print("")

    def write(self,ad:str,dt:str):
        self.virtual_memory_dict[ad] = dt
        print()

    def read(self,ad:str)->str:
        i = 15
        address = 0
        for char in ad:
            if(char=="1"):
                address += 2**i
            i-=1
        
        # 実メモリからの読み込み
        if(address<len(self.instruction_memory_list)):
            i_mem = self.instruction_memory_list[address]
            if(i_mem[2]!=0):
                print(i_mem[2])
            self.test = i_mem[1]
            return i_mem[0]

        # 仮想メモリからの読み込み
        if(ad in self.virtual_memory_dict):
            return self.virtual_memory_dict[ad]

        print(ad)
        # エラー
        return "eeeeeeee"

    def runtest(self,_dut):
        if(self.test == 0):
            return
        testList = self.test.split(",")
        for tst in testList:
            a = tst.split("=")
            reg = a[0]
            val = a[1]
            self.regIsEq(_dut,reg,val)

    def regIsEq(self,_dut,reg,val):
        tval = val
        rval = 0
        if (reg == "A"):
            rval = str(_dut.debugA.value)
        if (reg == "F"):
            rval = str(_dut.debugF.value)
        if (reg == "B"):
            rval = str(_dut.debugB.value)
        if (reg == "C"):
            rval = str(_dut.debugC.value)
        if (reg == "D"):
            rval = str(_dut.debugD.value)
        if (reg == "E"):
            rval = str(_dut.debugE.value)
        if (reg == "H"):
            rval = str(_dut.debugH.value)
        if (reg == "L"):
            rval = str(_dut.debugL.value)
        if (reg == "PC"):
            rval = str(_dut.debugPC.value)
        if (reg == "SP"):
            rval = str(_dut.debugSP.value)
        if (reg == "IX"):
            rval = str(_dut.debugIX.value)
        if (reg == "IY"):
            rval = str(_dut.debugIY.value)
        if (reg == "I"):
            rval = str(_dut.debugI.value)
        if (reg == "R"):
            rval = str(_dut.debugR.value)
        if (reg == "Dt"):
            rval = str(_dut.debugDt.value)
        if (reg == "Dtex"):
            rval = str(_dut.debugDtex.value)
        if (reg == "Dtcs"):
            rval = str(_dut.debugDtcs.value)
        if (reg == "OP"):
            rval = str(_dut.debugOP.value)
        if (reg == "OPold"):
            rval = str(_dut.debugOPold.value)
        if (reg == "XPT"):
            rval = str(_dut.debugXPT.value)
        if (reg == "ITBLE"):
            rval = str(_dut.debugITBLE.value)
        if (reg == "ALU"):
            rval = str(_dut.debugALU.value)
        if (reg == "IFF1"):
            rval = str(_dut.debugIFF1.value)
        if (reg == "IFF2"):
            rval = str(_dut.debugIFF2.value)
        if (reg == "IMFa"):
            rval = str(_dut.debugIMFa.value)
        if (reg == "IMFb"):
            rval = str(_dut.debugIMFb.value)
        if (reg == "TINT"):
            rval = str(_dut.debugTINT.value)
        if (reg == "TNMI"):
            rval = str(_dut.debugTNMI.value)
        if (reg == "TWAIT"):
            rval = str(_dut.debugTWAIT.value)
        if (reg == "TRESET"):
            rval = str(_dut.debugTRESET.value)
        if (reg == "XIX"):
            rval = str(_dut.debugXIX.value)
        if (reg == "XIX40"):
            rval = str(_dut.debugXIX4_0.value)
        if (reg == "XIX41"):
            rval = str(_dut.debugXIX4_1.value)
        if (reg == "XIY"):
            rval = str(_dut.debugXIY.value)
        if (reg == "XIY40"):
            rval = str(_dut.debugXIY4_0.value)
        if (reg == "XIY41"):
            rval = str(_dut.debugXIY4_1.value)
        if (reg == "XOTR"):
            rval = str(_dut.debugXOTR.value)
        if (reg == "XBIT"):
            rval = str(_dut.debugXBIT.value)
        if (reg == "CM1"):
            rval = str(_dut.debugCM1.value)
        if (reg == "CMR"):
            rval = str(_dut.debugCMR.value)
        if (reg == "CMA"):
            rval = str(_dut.debugCMA.value)
        if (reg == "CBUSRQ"):
            rval = str(_dut.debugCBUSRQ.value)
        if (reg == "CRESET"):
            rval = str(_dut.debugCRESET.value)
        if (reg == "CNMI"):
            rval = str(_dut.debugCNMI.value)
        if (reg == "CINT0"):
            rval = str(_dut.debugCINT0.value)
        if (reg == "CINT0R"):
            rval = str(_dut.debugCINT0_RST.value)
        if (reg == "CINT0C"):
            rval = str(_dut.debugCINT0_CALL.value)
        if (reg == "CINT1"):
            rval = str(_dut.debugCINT1.value)
        if (reg == "CINT2"):
            rval = str(_dut.debugCINT2.value)
        if (reg == "LHALT"):
            rval = str(_dut.interfaceHALT.value)
        if (reg == "FlagS"):
            rval = str(_dut.debugF[7].value)
        if (reg == "FlagZ"):
            rval = str(_dut.debugF[6].value)
        if (reg == "FlagH"):
            rval = str(_dut.debugF[4].value)
        if (reg == "FlagPV"):
            rval = str(_dut.debugF[2].value)
        if (reg == "FlagN"):
            rval = str(_dut.debugF[1].value)
        if (reg == "FlagC"):
            rval = str(_dut.debugF[0].value)
        if (reg[0] == "("):
            rval = self.virtual_memory_dict[(reg[1:-1])]

        if(rval == tval):
            print("✅ Test( " + reg + "=" + tval + " ) is passed.")
        else:
            print("🟥 Test( " + reg + "==" + tval + " ) is not passed. " + reg + " is " + rval + " !")

# TestBench
@cocotb.test()
async def tb_instruction(dut):
    _dut = dut
    # Init wait
    await init(_dut, DURATION_TIME)

    # Reset
    await reset(_dut,DURATION_TIME)

    memory = Memory(PROGRAM_PATH)

    isOphd = 0
    halt = 0
    rwait = 0
    iwait = 0
    wwait = 0
    owait = 0

    while(True):
        if(isOphd == 1):
            memory.runtest(_dut)

        if((_dut.interfaceMREQ.value == 0) and (_dut.interfaceRD.value == 0)):
            dt = memory.read(str(_dut.interfaceAd.value))
            print(dt)
            if (dt == "ffffffff"):
                print("")
                print("END")
                print("")
                break;
            if (dt == "eeeeeeee"):
                print("")
                print("ERROR")
                print("")
                break;
            
            i = 7
            for d in dt:
                dtbit = 0
                if(d == "1"):
                    dtbit = 1
                _dut.interfaceDt_in[i].value = dtbit
                i-=1

            if(WAIT):
                if(rwait==0):
                    _dut.WAIT.value=0
                    rwait=1
                elif(rwait==1):
                    _dut.WAIT.value=1
                    rwait=2
        else:
            rwait=0

        if((_dut.interfaceIORQ.value == 0) and (_dut.interfaceRD.value == 0)):
            dt = memory.read(str(_dut.interfaceAd.value))
            print(dt)
            if (dt == "ffffffff"):
                print("")
                print("END")
                print("")
                break;
            if (dt == "eeeeeeee"):
                print("")
                print("ERROR")
                print("")
                break;
            
            i = 7
            for d in dt:
                dtbit = 0
                if(d == "1"):
                    dtbit = 1
                _dut.interfaceDt_in[i].value = dtbit
                i-=1

            if(WAIT):
                if(iwait==0):
                    iwait=1
                elif(iwait==1):
                    _dut.WAIT.value=0
                    iwait=2
                elif(iwait==2):
                    _dut.WAIT.value=1
                    iwait=3
        else:
            iwait=0
        
        if((_dut.interfaceMREQ.value == 0) and (_dut.interfaceWR.value == 0)):
            memory.write(str(_dut.interfaceAd.value),str(_dut.interfaceDt_out.value))

        if((_dut.interfaceMREQ.value == 0) and (_dut.interfaceRD.value == 1)):
            if(WAIT):
                if(wwait==0):
                    _dut.WAIT.value=0
                    wwait=1
                elif(wwait==1):
                    _dut.WAIT.value=1
                    wwait=2
        else:
            wwait=0

        if((_dut.interfaceIORQ.value == 0) and (_dut.interfaceWR.value == 0)):
            memory.write(str(_dut.interfaceAd.value),str(_dut.interfaceDt_out.value))

        if((_dut.interfaceIORQ.value == 0) and (_dut.interfaceRD.value == 1)):
            if(WAIT):
                if(owait==0):
                    owait=1
                elif(owait==1):
                    _dut.WAIT.value=0
                    owait=2
                elif(owait==2):
                    _dut.WAIT.value=1
                    owait=3
        else:
            owait=0

        await Timer(DURATION_TIME, units="ns")
        _dut.Clk.value = 0
        await Timer(DURATION_TIME, units="ns")
        isOphd = _dut.debugPa_Ophd.value
        if(_dut.interfaceHALT.value==0):
            halt += 1
            if(halt>21):
                print("HALT LOOP")
                break;
        _dut.Clk.value = 1
        await Timer(DURATION_TIME, units="ns")

    printall(_dut)
    memory.print_virtual_memory()
    