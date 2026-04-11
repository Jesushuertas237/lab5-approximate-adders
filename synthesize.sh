#!/bin/bash

hdl_dir="./hdl"
log_dir="./logs"
tcl_script="./synth.tcl"

mkdir -p "$log_dir"

for file in "$hdl_dir"/*.v
do
    nombre=$(basename "$file" .v)
    echo "Sintetizando $nombre..."
    vivado -mode batch -source "$tcl_script" -tclargs "$file" > "$log_dir/${nombre}.log" 2>&1
    echo "Reporte guardado en $log_dir/${nombre}.log"
done

echo "Sintesis completada. Reportes en $log_dir/"
