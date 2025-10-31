# set synthetic_library dw_foundation.sldb
source NangateOpenCell.setup.tcl

set search_path [ join "$TECHLIB_PATH $search_path" ]

set link_library [list $target_library]

set my_verilog_files [glob runs/hdls/cvw.sv runs/hdls/*.sv]

analyze -f sverilog -work work $my_verilog_files

elaborate wallypipelinedcorewrapper

set_dont_touch [get_cells -hierarchical *ram*]

link
uniquify

set_dont_touch [get_cells -hierarchical *ram*]

compile

report_timing > runs/report_timing-16ott.log

change_names -hierarchy -rules verilog

write -hierarchy -format verilog -output "runs/outputs/wallypipelinedcore-16ott.v"

write -hierarchy -format ddc -output "runs/wallypipelinedcore-16ott.ddc"

write_sdf -version 3.0 "runs/wallypipelinedcore-16ott.sdf"

write_sdc "runs/wallypipelinedcore-16ott.sdc"
