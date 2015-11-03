# vhdl files
PROJECT = LFSR_TSA
TESTBENCH = codeur_tb
TESTBENCHDIR = testbench
FILES = $(wildcard src/*.vhd)
FILES_CELL=src/lsfr_cell.vhd
TESTBENCH_CELL=lsfr_cell_tb
VHDLEX = .vhd

 
#GHDL CONFIG
GHDL_CMD = ghdl
GHDL_FLAGS  = --ieee=synopsys --warn-no-vital-generic
 
SIMDIR = sim
# Simulation break condition
#GHDL_SIM_OPT = --assert-level=error
GHDL_SIM_OPT = --stop-time=5us
 
WAVEFORM_VIEWER = gtkwave
 
all: 
	@echo "Usage: make cell (for LFSR cell) or make compile (for LFSR)"
	@echo "       make runcell (for LFSR cell) or make run (for LFSR)" 
	@echo "       make viewcell (for LFSR cell) or make view (for LFSR)"

compile :
	mkdir -p sim
	$(GHDL_CMD) -i $(GHDL_FLAGS) --workdir=sim --work=work $(FILES) $(TESTBENCHDIR)/codeur_tb.vhd 
	$(GHDL_CMD) -m  $(GHDL_FLAGS) --workdir=sim --work=work codeur_tb
	mv codeur_tb  sim/codeur_tb                                        

cell :
	mkdir -p sim
	$(GHDL_CMD) -i $(GHDL_FLAGS) --workdir=sim --work=work testbench/lsfr_cell_tb.vhd src/lsfr_cell.vhd
	$(GHDL_CMD) -m  $(GHDL_FLAGS) --workdir=sim --work=work lsfr_cell_tb
	mv lsfr_cell_tb sim/ 

runcell :
	$(SIMDIR)/lsfr_cell_tb  $(GHDL_SIM_OPT) --vcd=$(SIMDIR)/lsfr_cell_tb.vcd

run :
	$(SIMDIR)/codeur_tb $(GHDL_SIM_OPT) --vcd=$(SIMDIR)/codeur_tb.vcd

view :
	$(WAVEFORM_VIEWER) $(SIMDIR)/codeur_tb.vcd                           

viewcell :
	$(WAVEFORM_VIEWER) $(SIMDIR)/lsfr_cell_tb.vcd                                               

clean :
	$(GHDL_CMD) --clean --workdir=sim

distclean: clean
	 \rm -rf *~ $(SIMDIR)/* $(SIMDIR)/work-obj93.cf src/*.o src/*~ src/work-obj93.cf testbench/*~ 

tar: 	distclean
	cd ..; tar cvf LFSR-TSA-INIT.tar  LFSR-TSA-INIT; cd  LFSR-TSA-INIT
