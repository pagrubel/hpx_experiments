#!/bin/bash

for i in 1 2 4 8 16 32 64 128 256 512 768 1024 2048 4096 5462
do
    echo $i
cat >run_hello_world_hpx_${i}.job<<EOF
#PBS -q regular
#PBS -l mppwidth=$((i * 24))
#PBS -l walltime=00:10:00
#PBS -N hello_world_${i}

module load gcc boost
#cd /global/homes/s/sithhell/project/hpx/edison/nbody_demo-release


PERFCTRS=""
#PERFCTRS="\$PERFCTRS --hpx:print-counter /agas{locality#*/total}/component/count"
PERFCTRS="\$PERFCTRS --hpx:print-counter /agas{locality#*/total}/count/allocate"
PERFCTRS="\$PERFCTRS --hpx:print-counter /agas{locality#*/total}/count/bind"
PERFCTRS="\$PERFCTRS --hpx:print-counter /agas{locality#*/total}/count/bind_gid"
PERFCTRS="\$PERFCTRS --hpx:print-counter /agas{locality#*/total}/count/cache/evictions"
PERFCTRS="\$PERFCTRS --hpx:print-counter /agas{locality#*/total}/count/cache/hits"
PERFCTRS="\$PERFCTRS --hpx:print-counter /agas{locality#*/total}/count/cache/insertions"
PERFCTRS="\$PERFCTRS --hpx:print-counter /agas{locality#*/total}/count/cache/misses"
PERFCTRS="\$PERFCTRS --hpx:print-counter /agas{locality#*/total}/count/cache/erase_entry"
PERFCTRS="\$PERFCTRS --hpx:print-counter /agas{locality#*/total}/count/cache/get_entry"
PERFCTRS="\$PERFCTRS --hpx:print-counter /agas{locality#*/total}/count/cache/insert_entry"
PERFCTRS="\$PERFCTRS --hpx:print-counter /agas{locality#*/total}/count/cache/update_entry"
PERFCTRS="\$PERFCTRS --hpx:print-counter /agas{locality#*/total}/count/decrement_credit"
PERFCTRS="\$PERFCTRS --hpx:print-counter /agas{locality#*/total}/count/increment_credit"
PERFCTRS="\$PERFCTRS --hpx:print-counter /agas{locality#*/total}/count/route"
PERFCTRS="\$PERFCTRS --hpx:print-counter /agas{locality#*/total}/count/resolve"
PERFCTRS="\$PERFCTRS --hpx:print-counter /agas{locality#*/total}/count/resolve_gid"
#PERFCTRS="\$PERFCTRS --hpx:print-counter /agas{locality#*/total}/count/resolve_id"
PERFCTRS="\$PERFCTRS --hpx:print-counter /agas{locality#*/total}/primary/count"
PERFCTRS="\$PERFCTRS --hpx:print-counter /data{locality#*/total}/count/mpi/received"
PERFCTRS="\$PERFCTRS --hpx:print-counter /data{locality#*/total}/count/mpi/sent"
PERFCTRS="\$PERFCTRS --hpx:print-counter /data{locality#*/total}/time/mpi/received"
PERFCTRS="\$PERFCTRS --hpx:print-counter /data{locality#*/total}/time/mpi/sent"
PERFCTRS="\$PERFCTRS --hpx:print-counter /messages{locality#*/total}/count/mpi/received"
PERFCTRS="\$PERFCTRS --hpx:print-counter /messages{locality#*/total}/count/mpi/sent"
PERFCTRS="\$PERFCTRS --hpx:print-counter /parcels{locality#*/total}/count/mpi/received"
PERFCTRS="\$PERFCTRS --hpx:print-counter /parcels{locality#*/total}/count/mpi/sent"
PERFCTRS="\$PERFCTRS --hpx:print-counter /serialize{locality#*/total}/count/mpi/received"
PERFCTRS="\$PERFCTRS --hpx:print-counter /serialize{locality#*/total}/count/mpi/sent"
PERFCTRS="\$PERFCTRS --hpx:print-counter /serialize{locality#*/total}/time/mpi/received"
PERFCTRS="\$PERFCTRS --hpx:print-counter /serialize{locality#*/total}/time/mpi/sent"
PERFCTRS="\$PERFCTRS --hpx:print-counter /threads{locality#*/total}/count/objects"
PERFCTRS="\$PERFCTRS --hpx:print-counter /threads{locality#*/total}/count/cumulative"
PERFCTRS="\$PERFCTRS --hpx:print-counter /threads{locality#*/total}/count/cumulative-phases"
PERFCTRS="\$PERFCTRS --hpx:print-counter /threads{locality#*/total}/time/average"
PERFCTRS="\$PERFCTRS --hpx:print-counter /threads{locality#*/total}/time/average-overhead"
PERFCTRS="\$PERFCTRS --hpx:print-counter /threads{locality#*/total}/time/average-phase"
PERFCTRS="\$PERFCTRS --hpx:print-counter /threads{locality#*/total}/time/average-phase-overhead"
PERFCTRS="\$PERFCTRS --hpx:print-counter /threads{locality#*/total}/idle-rate"

for ((i=0; i<10; i++))
do
    echo "run \$i"

    aprun -n$i -N1 -d24 -cc none \\
         $HOME/hpx_idle/build/bin/hello_world \\
         \$PERFCTRS

done
EOF

done

