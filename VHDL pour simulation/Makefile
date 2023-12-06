GHDL=ghdl
#GHDL=/usr/bin/ghdl
GHDL_OP = -v
C_MOD_DIR = C_model/
all : main_tb

ram.o : ram.vhdl
	${GHDL} -a ${GHDL_OP} ram.vhdl

icache.o : icache.vhdl ram.o
	${GHDL} -a ${GHDL_OP} icache.vhdl

dcache.o : dcache.vhdl ram.o
	${GHDL} -a ${GHDL_OP} dcache.vhdl

main_tb.o : main_tb.vhdl icache.o dcache.o ram.o 
	${GHDL} -a ${GHDL_OP} main_tb.vhdl

arm_core.o : arm_core.vhdl ifetch.o decod.o exec.o mem.o
	${GHDL} -a ${GHDL_OP} arm_core.vhdl
	
ifetch.o : ifetch.vhdl fifo_generic.o
	${GHDL} -a ${GHDL_OP} ifetch.vhdl

decod.o : Decod.vhdl fifo_32b.o fifo_127b.o reg.o
	${GHDL} -a ${GHDL_OP} Decod.vhdl

reg.o : Reg.vhdl 
	${GHDL} -a ${GHDL_OP} Reg.vhdl

mux_2to1.o : mux_2to1.vhdl
	${GHDL} -a ${GHDL_OP} mux_2to1.vhdl


exec.o : EXec.vhdl fifo_72b.o alu.o shifter.o mux_2to1.o 
	${GHDL} -a ${GHDL_OP} EXec.vhdl

fifo_72b.o : fifo_72b.vhdl
	${GHDL} -a ${GHDL_OP} fifo_72b.vhdl

fifo_32b.o : fifo_32b.vhdl
	${GHDL} -a ${GHDL_OP} fifo_32b.vhdl

fifo_127b.o : fifo_127b.vhdl
	${GHDL} -a ${GHDL_OP} fifo_127b.vhdl

alu.o : Alu.vhdl
	${GHDL} -a ${GHDL_OP} Alu.vhdl

shifter.o : Shifter.vhdl
	${GHDL} -a ${GHDL_OP} Shifter.vhdl

mem.o : mem.vhdl
	${GHDL} -a ${GHDL_OP} mem.vhdl

fifo_generic.o : fifo_generic.vhdl
	${GHDL} -a ${GHDL_OP} fifo_generic.vhdl

main_tb : main_tb.o ram.o icache.o dcache.o arm_core.o ${C_MOD_DIR}/lib/arm_ghdl.o
	${GHDL} -e ${GHDL_OP} -Wl,${C_MOD_DIR}/lib/mem.o -Wl,${C_MOD_DIR}/lib/arm_ghdl.o -Wl,${C_MOD_DIR}/ReadElf/lib/ElfObj.o main_tb

clean :
	rm *.o main_tb work-obj93.cf *.vcd
