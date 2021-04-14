#!/bin/sh

if [ ! $# -eq 1 ]
then
    echo "Usage: ./execute <data_structures_combination>"
    echo "sll_sll, sll_dll, sll_dynarr, dll_sll, dll_sll, dll_dynarr, dynarr_sll, dynarr_dll, dynarr_dynarr"
else
    #Compile
    gcc drr.c -o drr_$1 -pthread -lcdsl -L./../synch_implementations -I./../synch_implementations

    #Memory access
    valgrind --log-file="$1_accesses_log.txt" --tool=lackey --trace-mem=yes ./drr_$1
    cat $1_accesses_log.txt | grep 'I\| L' | wc -l >> ./results/$1_accesses.txt
    rm $1_accesses_log.txt

    #Memory footprint
    valgrind --tool=massif --massif-out-file="$1_massif.out" ./drr_$1
    ms_print $1_massif.out > $1_footprint_log.txt
    cat $1_footprint_log.txt | sed '8!d' >> ./results/$1_footprint.txt
    cat $1_footprint_log.txt | sed '9!d' >> ./results/$1_footprint.txt
    rm $1_massif.out $1_footprint_log.txt
fi