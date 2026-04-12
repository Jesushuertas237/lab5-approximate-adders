#!/bin/bash

repo_url="https://github.com/ehw-fit/evoapproxlib"
target_path="adders/8_unsigned/pareto_pwr_ep"
hdl_dir="./hdl"
temp_dir="./tmp_repo"

echo "Clonando repositorio..."
git clone --no-checkout --depth=1 "$repo_url" "$temp_dir"
cd "$temp_dir"
git sparse-checkout init --cone
git sparse-checkout set "$target_path"
git checkout
cd ..

echo "Creando directorio hdl/..."
mkdir -p "$hdl_dir"

echo "Copiando archivos .v..."
find "$temp_dir/$target_path" -name "*.v" -exec cp {} "$hdl_dir/" \;

count=$(ls "$hdl_dir"/*.v 2>/dev/null | wc -l)
echo "$count archivos .v copiados a $hhdl_dir/"

echo "Limpiando archivos temporales..."
rm -rf "$temp_dir"

echo "Los archivos estan en: $hdl_dir/"
