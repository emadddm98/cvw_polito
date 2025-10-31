# Minimal Design Compiler flow using Nangate library (no timing constraints)

puts "Starting simple Nangate synthesis script..."

# Top-level from environment (Makefile exports DESIGN)
set top [getenv "DESIGN"]
if {$top == ""} {
    puts "ENV DESIGN not set, using default 'wallypipelinedcore'"
    set top "wallypipelinedcore"
}
puts "Top cell: $top"

# Library / search path setup (adjust /home/e.rodriguez/tech_lib/ as needed)
set search_path [list . /home/e.rodriguez/tech_lib/ [getenv "SYNOPSYS"]]
puts "Search path: $search_path"
set synthetic_library dw_foundation.sldb
set target_library NangateOpenCellLibrary.db
set link_library [list $target_library $synthetic_library]
puts "Target library: $target_library"
puts "Synthetic library: $synthetic_library"
puts "Link library: $link_library"

# Inform DC of libraries (Design Compiler commands)
set_target_library $target_library
set_link_library $link_library
set_synthetic_library $synthetic_library
set_common_search_path $search_path

# Gather design source files from ../src (recursive)
puts "Collecting source files from ../src ..."
set filelist [split [exec find ../src -type f \( -name "*.sv" -o -name "*.v" -o -name "*.svh" -o -name "*.vh" \) 2>/dev/null] "\n"]

foreach f $filelist {
    if {[string trim $f] != ""} {
        puts "Analyzing $f"
        analyze -format sverilog $f
    }
}

# Elaborate top-level
puts "Elaborating $top ..."
elaborate $top -library WORK

# Simple wire-load model (no timing constraints)
set_wire_load_model -name 5k_hvratio_1_4

# Compile (synthesis)
puts "Compiling ..."
compile -map_effort high

# Reports and outputs
puts "Generating reports and outputs ..."
report_power > ${top}_power_report.rpt
report_area > ${top}_area_report.rpt
report_timing > ${top}_timing_report.rpt

write -hierarchy -format verilog -output ${top}_PostSyn.v
write_sdc ${top}.sdc

puts "Synthesis finished."
quit -f
