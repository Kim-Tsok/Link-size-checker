#!/bin/bash

total_bytes=0

printf "\n%-50s %15s %15s\n" "File" "MB" "GB"
echo "--------------------------------------------------------------------------------"

while IFS= read -r url; do
  clean_url=$(echo "$url" | sed 's/^\[//; s/\]$//')
  [ -z "$clean_url" ] && continue
  
  size=$(curl -sI "$clean_url" | awk 'tolower($1)=="content-length:" {print $2}' | tr -d '\r')
  
  if [[ -n "$size" && "$size" -gt 0 ]]; then
    total_bytes=$((total_bytes + size))
    file=$(basename "$clean_url" | cut -d'?' -f1)
    awk -v s="$size" -v f="$file" 'BEGIN {
      mb = s / 1024 / 1024;
      gb = s / 1024 / 1024 / 1024;
      printf "%-50s %15.2f %15.2f\n", f, mb, gb;
    }'
  else
    file=$(basename "$clean_url" | cut -d'?' -f1)
    printf "%-50s %15s %15s\n" "$file" "???" "???"
  fi
done < links.txt

echo "--------------------------------------------------------------------------------"
awk -v total="$total_bytes" 'BEGIN {
  total_mb = total / 1024 / 1024;
  total_gb = total / 1024 / 1024 / 1024;
  printf "%-50s %15.2f %15.2f\n", "TOTAL", total_mb, total_gb;
}'

echo
read -p "Press Enter to exit..."

