#!/bin/sh

## Sanitization 
#[ -z ${1} ] && echo "Techlib not specified! Usage $0 NangateOpenCellLibrary|LIB065|pdt2002" && exit 1
#[ "${1}" != "NangateOpenCellLibrary"   ]                  &&
#    [ "${1}}" != "LIB065"              ]                  &&
#    [ "${1}}" != "pdt2002"             ]                  &&
#    echo "Invalid/Unsupported Techlib"                    &&
#    echo "Usage $0 NangateOpenCellLibrary|LIB065|pdt2002" && 
#    exit 1
#
#export TECHLIB=${1}

dc_shell-xg-t -f custom_tcl.tcl | tee runs/syn_nangate_$(date '+%Y-%m-%d_%H-%M-%S').log
