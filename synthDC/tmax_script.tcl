read_netlist /data/libraries/NangateOpenCellLibrary_15_45_nm/45nm/NangateOpenCellLibrary.v
read_netlist wallypipelinedcore.sv

run_build_model 
run_drc

add_faults -all
report_faults -level {5 500}

set_patterns -external 

run_fault-sm\
