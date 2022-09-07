#!/usr/bin/env bash

monthnames=(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)

for m in ${monthnames[@]}; do
  for d in `seq -f "%02g" 0 30`; do
    for i in `seq 100`; do
      IP=$(printf "%d.%d.%d.%d\n" "$((RANDOM % 256 ))" "$((RANDOM % 256 ))" "$((RANDOM % 256 ))" "$((RANDOM % 256 ))")
      line="[$d/$m/2021:$(printf "%02d" $((RANDOM % 24))):$(printf "%02d" $((RANDOM % 59))):$(printf "%02d" $((RANDOM % 59)))+0100] $IP /healthz GET Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)"
      echo $line | tee -a ips.txt
    done
  done
done
