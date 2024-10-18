import re
import cocotb
from cocotb.triggers import Timer

# define
DURATION_TIME = 1000
WAIT = True
PROGRAM_PATH = "/Users/Pepper/verilog/norz_verilog/_test/tests_txt/_INTERRUPT/INT - 0CALL.txt"

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

async def interrupt_cycle(_dut,memory,isINT,intop):
    isOphd = 0
    read = 0
    cycle = 0
    while(True):
        if(isOphd == 2):
            break
        if(WAIT and cycle == 2):
            _dut.WAIT.value = 0
        if(WAIT and cycle == 5):
            _dut.WAIT.value = 1
        if(((_dut.interfaceMREQ.value == 0) and (_dut.interfaceRD.value == 0)) or _dut.interfaceIORQ.value == 0):
            if(read == 0):
                _dut.interfaceDt_in[0].value = 0
                _dut.interfaceDt_in[1].value = 0
                _dut.interfaceDt_in[2].value = 0
                _dut.interfaceDt_in[3].value = 0
                _dut.interfaceDt_in[4].value = 0
                _dut.interfaceDt_in[5].value = 0
                _dut.interfaceDt_in[6].value = 0
                _dut.interfaceDt_in[7].value = 0
            # CINT 0/2
            if(read == 1):
                i = 7
                for d in intop:
                    dtbit = 0
                    if(d == "1"):
                        dtbit = 1
                    _dut.interfaceDt_in[i].value = dtbit
                    i-=1
            # CINT 0 CALL
            if(read == 2 or read == 3):
                # high
                _dut.interfaceDt_in[0].value = 0
                _dut.interfaceDt_in[1].value = 0
                _dut.interfaceDt_in[2].value = 0
                _dut.interfaceDt_in[3].value = 0
                _dut.interfaceDt_in[4].value = 0
                _dut.interfaceDt_in[5].value = 0
                _dut.interfaceDt_in[6].value = 0
                _dut.interfaceDt_in[7].value = 1
            if(read == 4 or read == 5):
                # high
                _dut.interfaceDt_in[0].value = 0
                _dut.interfaceDt_in[1].value = 0
                _dut.interfaceDt_in[2].value = 1
                _dut.interfaceDt_in[3].value = 1
                _dut.interfaceDt_in[4].value = 0
                _dut.interfaceDt_in[5].value = 1
                _dut.interfaceDt_in[6].value = 1
                _dut.interfaceDt_in[7].value = 1
            if(_dut.WAIT.value != 0):
                read += 1

        if((_dut.interfaceMREQ.value == 0 or _dut.interfaceIORQ.value == 0) and (_dut.interfaceWR.value == 0)):
            memory.write(str(_dut.interfaceAd.value),str(_dut.interfaceDt_out.value))

        await Timer(DURATION_TIME, units="ns")
        _dut.Clk.value = 0
        if(isOphd == 0 and cycle == 1):
            if(isINT):
                _dut.INT.value = 0
            else:
                _dut.NMI.value = 0
        await Timer(DURATION_TIME, units="ns")
        if(_dut.debugPa_Ophd.value == 1):
            cycle = 0
            isOphd += 1
        _dut.Clk.value = 1
        if(isOphd == 0 and cycle == 1):
            if(isINT):
                _dut.INT.value = 1
            else:
                _dut.NMI.value = 1
        await Timer(DURATION_TIME, units="ns")

        cycle+=1

async def retn_cycle(_dut,memory):
    isOphd = 0
    while(True):
        if(isOphd == 1):
            break;
        if((_dut.interfaceMREQ.value == 0 or _dut.interfaceIORQ.value == 0) and (_dut.interfaceRD.value == 0)):
            if (str(_dut.interfaceAd.value) == "0000000001100110"):
                _dut.interfaceDt_in[0].value = 1
                _dut.interfaceDt_in[1].value = 0
                _dut.interfaceDt_in[2].value = 1
                _dut.interfaceDt_in[3].value = 1
                _dut.interfaceDt_in[4].value = 0
                _dut.interfaceDt_in[5].value = 1
                _dut.interfaceDt_in[6].value = 1
                _dut.interfaceDt_in[7].value = 1
            elif (str(_dut.interfaceAd.value) == "0000000001100111"):
                _dut.interfaceDt_in[0].value = 1
                _dut.interfaceDt_in[1].value = 0
                _dut.interfaceDt_in[2].value = 1
                _dut.interfaceDt_in[3].value = 0
                _dut.interfaceDt_in[4].value = 0
                _dut.interfaceDt_in[5].value = 0
                _dut.interfaceDt_in[6].value = 1
                _dut.interfaceDt_in[7].value = 0
            else:
                dt = memory.read(str(_dut.interfaceAd.value))
                print(dt)
                i = 7
                for d in dt:
                    dtbit = 0
                    if(d == "1"):
                        dtbit = 1
                    _dut.interfaceDt_in[i].value = dtbit
                    i-=1

        if((_dut.interfaceMREQ.value == 0 or _dut.interfaceIORQ.value == 0) and (_dut.interfaceWR.value == 0)):
            memory.write(str(_dut.interfaceAd.value),str(_dut.interfaceDt_out.value))

        await Timer(DURATION_TIME, units="ns")
        _dut.Clk.value = 0
        await Timer(DURATION_TIME, units="ns")
        isOphd = _dut.debugPa_Ophd.value
        _dut.Clk.value = 1
        await Timer(DURATION_TIME, units="ns")

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

    interrupt = 0

    while(True):
        if(isOphd == 1):
            memory.runtest(_dut)

        if((_dut.interfaceMREQ.value == 0 or _dut.interfaceIORQ.value == 0) and (_dut.interfaceRD.value == 0)):
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
            if (dt == "bbbbbbbb"):
                print("")
                print("BUSRQ in")
                print("")
                interrupt = 1
                break;
            if (dt == "nnnnnnnn"):
                print("")
                print("NMI in")
                print("")
                interrupt = 2
                break;
            if (dt == "i0rrrrrr"):
                print("")
                print("INT 0 RST in")
                print("")
                interrupt = 3
                break;
            if (dt == "i0cccccc"):
                print("")
                print("INT 0 CALL in")
                print("")
                interrupt = 4
                break;
            if (dt == "i1iiiiii"):
                print("")
                print("INT 1 in")
                print("")
                interrupt = 5
                break;
            if (dt == "i2iiiiii"):
                print("")
                print("INT 2 in")
                print("")
                interrupt = 6
                break;

            i = 7
            for d in dt:
                dtbit = 0
                if(d == "1"):
                    dtbit = 1
                _dut.interfaceDt_in[i].value = dtbit
                i-=1

        if((_dut.interfaceMREQ.value == 0 or _dut.interfaceIORQ.value == 0) and (_dut.interfaceWR.value == 0)):
            memory.write(str(_dut.interfaceAd.value),str(_dut.interfaceDt_out.value))

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

    if(interrupt == 1):
        # BUSRQ
        _dut.BUSRQ.value=0
        await Timer(DURATION_TIME, units="ns")
        _dut.Clk.value = 0
        await Timer(DURATION_TIME, units="ns")
        _dut.Clk.value = 1
        await Timer(DURATION_TIME, units="ns")
        _dut.Clk.value = 0
        await Timer(DURATION_TIME, units="ns")
        _dut.Clk.value = 1
        await Timer(DURATION_TIME, units="ns")
        _dut.Clk.value = 0
        await Timer(DURATION_TIME, units="ns")
        _dut.Clk.value = 1
        await Timer(DURATION_TIME, units="ns")
        _dut.Clk.value = 0
        await Timer(DURATION_TIME, units="ns")
        _dut.Clk.value = 1
        await Timer(DURATION_TIME, units="ns")
        _dut.Clk.value = 0
        await Timer(DURATION_TIME, units="ns")
        _dut.Clk.value = 1
        await Timer(DURATION_TIME, units="ns")
        _dut.BUSRQ.value=1
        await Timer(DURATION_TIME, units="ns")
        _dut.Clk.value = 0
        await Timer(DURATION_TIME, units="ns")
        _dut.Clk.value = 1
        await Timer(DURATION_TIME, units="ns")
        _dut.Clk.value = 0
        await Timer(DURATION_TIME, units="ns")
        _dut.Clk.value = 1
        await Timer(DURATION_TIME, units="ns")
    if(interrupt == 2):
        # NMI
        await interrupt_cycle(_dut,memory,False,"00000000")
        memory.regIsEq(_dut,"PC","0000000001100110")
        memory.regIsEq(_dut,"SP","1110111111111110")
        memory.regIsEq(_dut,"IFF1","0")
        # di
        print("pass when di")
        memory.regIsEq(_dut,"IFF2","0")
        # ei
        print("pass when ei")
        memory.regIsEq(_dut,"IFF2","1")
        #
        # RETN
        #
        await retn_cycle(_dut,memory)
        memory.regIsEq(_dut,"SP","1111000000000000")
        memory.regIsEq(_dut,"PC","0000000000000101")
        # di
        print("pass when di")
        memory.regIsEq(_dut,"IFF1","0")
        memory.regIsEq(_dut,"IFF2","0")
        # ei
        print("pass when ei")
        memory.regIsEq(_dut,"IFF1","1")
        memory.regIsEq(_dut,"IFF2","1")
    if(interrupt == 3):
        # INT 0 RST
        await interrupt_cycle(_dut,memory,True,"11001111")
        memory.regIsEq(_dut,"PC","0000000000001000")
        memory.regIsEq(_dut,"SP","1110111111111110")
        memory.regIsEq(_dut,"IFF1","0")
        memory.regIsEq(_dut,"IFF2","0")
    if(interrupt == 4):
        # INT 0 CALL
        await interrupt_cycle(_dut,memory,True,"11001101")
        memory.regIsEq(_dut,"PC","1110110010000000")
        memory.regIsEq(_dut,"SP","1110111111111110")
        memory.regIsEq(_dut,"IFF1","0")
        memory.regIsEq(_dut,"IFF2","0")
    if(interrupt == 5):
        # INT 1
        await interrupt_cycle(_dut,memory,True,"00000000")
        memory.regIsEq(_dut,"PC","0000000000111000")
        memory.regIsEq(_dut,"SP","1110111111111110")
        memory.regIsEq(_dut,"IFF1","0")
        memory.regIsEq(_dut,"IFF2","0")
    if(interrupt == 6):
        # INT 2
        await interrupt_cycle(_dut,memory,True,"01011010")
        memory.regIsEq(_dut,"PC","1111000001011010")
        memory.regIsEq(_dut,"SP","1110111111111110")
        memory.regIsEq(_dut,"IFF1","0")
        memory.regIsEq(_dut,"IFF2","0")

    printall(_dut)
    memory.print_virtual_memory()
    