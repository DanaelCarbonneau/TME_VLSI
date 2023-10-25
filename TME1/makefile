PROJ = EXec

GHDL = ghdl
GHDLOPTS = 


all : simul 

simul : 
	$(GHDL) -a  -v mux_2to1.vhdl
	$(GHDL) -a  -v Alu.vhdl
	$(GHDL) -a  -v Shifter.vhdl
	$(GHDL) -a  -v fifo_72b.vhdl
	$(GHDL) -a  -v $(PROJ).vhdl
	$(GHDL) -a  -v $(PROJ)_tb.vhdl
	$(GHDL) -e  -v $(PROJ)_tb 
	$(GHDL) -r  $(PROJ)_tb --vcd=$(PROJ).vcd --stop-time=500ns

clean :
	rm -f *.vcd *.o alu_tb adder_tb shifter_tb
