#!/usr/bin/env bash

for d in $(cat *.txt)
do
   xenon -vvv scheduler slurm --location local:// submit --inherit-env --max-run-time 30 --working-directory . --stderr siga.stderr-%j.log --stdout siga.stdout-%j.log siga.sh $d
done

