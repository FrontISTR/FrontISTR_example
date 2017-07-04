#!/bin/bash

PROCS=$1

if [ $PROCS -gt 0 ] 2> /dev/null
then
  echo "${PROCS}PE OK"
else
  echo "Not N"
  exit
fi
PWD=`pwd`
DATE=`date '+%Y%m%d%H%M%S'`
cd $2
echo '!PARTITION,TYPE=NODE-BASED,METHOD=KMETIS,DOMAIN='$PROCS > hecmw_part_ctrl.dat
export OMP_NUM_THREADS=4
mpirun -np 1 -x OMP_NUM_THREADS=$OMP_NUM_THREADS hecmw_part1 2>&1 | tee $PWD/$DATEpart1.log
export OMP_NUM_THREADS=1
mpirun -np $PROCS -x OMP_NUM_THREADS=$OMP_NUM_THREADS fistr1 2>&1 | tee $PWD/$DATEfistr1.log
cd -
