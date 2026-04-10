#!/usr/bin/env tclsh

set file [lindex $argv 0]
set top [file rootname [file tail $vfile]]

set_part "xc7a100tcsg324-1"
read_verilog $file
synth_design -top $top
report_utilization
exit
