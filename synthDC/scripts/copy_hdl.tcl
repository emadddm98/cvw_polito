set cfg "../config"
set hdl_src "../src"

eval file copy -force [glob ${cfg}/shared/*.vh] {runs/hdls/}
#in the future I could make it more paramterized
eval file copy -force [glob ${cfg}/rv64gc/*.vh] {runs/hdls/}

eval file copy -force [glob ${hdl_src}/cvw.sv] {runs/hdls/}
eval file copy -force [glob ${hdl_src}/*/*.sv] {runs/hdls/}
eval file copy -force [glob ${hdl_src}/*/*/*.sv] {runs/hdls/}
