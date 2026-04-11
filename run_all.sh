#!/bin/bash
# Script maestro: run_all.sh
# Ejecuta el flujo completo



set -euo pipefail

#Fncion de utilidad

log()     { echo "[MASTER] $(date '+%H:%M:%S') $*"; }
success() { echo "[  OK  ] $(date '+%H:%M:%S') $*"; }
err()     { echo "[ERROR ] $(date '+%H:%M:%S') $*" >&2; exit 1; }


# Verificar que los scripts existen
for script in setup_hdl.sh synthesize.sh parse_reports.sh; do
    [[ -f "$script" ]] || err "Script no encontrado: $script"
    chmod +x "$script"
done


# Encabezado
echo "  Laboratorio 5 EL3313: Taller de Diseño Digital"
echo "  Síntesis de Sumadores Aproximados"
echo ""
log "Inicio: $(date)"

INICIO=$(date +%s)

# Paso 1: Descargar y preparar archivos .v

echo ""
log "PASO 1: Descarga y preparacion de archivos .v"
bash setup_hdl.sh || err "Paso 1 fallo."
success "Paso 1 completado."


# Paso 2: Sintetizar con Vivado
echo ""

log "PASO 2: Sintesis con Vivado"
bash synthesize.sh || err "Paso 2 fallo."
success "Paso 2 completado."


# Paso 3: Parsear reportes y generar CSV

echo ""

log "PASO 3: Parseo de reportes y generacion de CSV"

bash parse_reports.sh || err "Paso 3 fallo."
success "Paso 3 completado."


# Resumen final

FIN=$(date +%s)
TOTAL=$((FIN - INICIO))

echo ""
success "FLUJO COMPLETADO en ${TOTAL} segundos."
log "Resultado final: results.csv"

