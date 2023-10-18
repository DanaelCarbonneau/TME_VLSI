PROJ = Shifter

GHDL = ghdl
GHDLOPTS = 


all : simul 

simul : 
	$(GHDL) -a  -v $(PROJ).vhdl
	$(GHDL) -a  -v $(PROJ)_tb.vhdl
	$(GHDL) -e  -v $(PROJ)_tb
	$(GHDL) -r  $(PROJ)_tb --vcd=$(PROJ).vcd

clean :
	rm -f *.vcd *.o alu_tb adder_tb
