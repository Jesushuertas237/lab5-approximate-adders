#!/bin/bash
# Script 03: parse_reports.sh
# Lee los .log en logs/ y extrae Slice LUTs y Slice Registers
# Genera un archivo results.csv con esa información

log_dir="./logs"
output_file="./results.csv"

# Escribir encabezado del CSV
echo "Modulo,Slice_LUTs,Slice_Registers" > "$output_file"

# Iterar sobre cada .log
for log in "$log_dir"/*.log; do
    nombre=$(basename "$log" .log)

    # Extraer Slice LUTs (columna Used)
    luts=$(grep "Slice LUTs" "$log" | head -1 | awk -F'|' '{gsub(/ /, "", $3); print $3}')

    # Extraer Slice Registers (columna Used)
    regs=$(grep "Slice Registers" "$log" | head -1 | awk -F'|' '{gsub(/ /, "", $3); print $3}')

    # Si no encontró valor, poner N/A
    luts=${luts:-N/A}
    regs=${regs:-N/A}

    echo "$nombre,$luts,$regs" >> "$output_file"
    echo "  $nombre -> LUTs: $luts | Registers: $regs"
done

echo ""
echo "CSV generado en: $output_file"
