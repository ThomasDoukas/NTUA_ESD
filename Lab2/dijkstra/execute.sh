#!/bin/sh

if [ ! $# -eq 1 ]
then
    echo "Usage: ./execute <data_structures>"
    echo "sll, dll, dynarr"
else
    #Compile
    gcc opt_dijkstra.c -o opt_dijkstra_$1 -pthread -lcdsl -L./../synch_implementations -I./../synch_implementations

    # #Memory access
    valgrind --log-file="$1_accesses_log.txt" --tool=lackey --trace-mem=yes ./opt_dijkstra_$1 input.dat
    cat $1_accesses_log.txt | grep 'I\| L' | wc -l >> ./results/$1_accesses.txt
    rm $1_accesses_log.txt

    # #Memory footprint
    valgrind --tool=massif --massif-out-file="$1_massif.out" ./opt_dijkstra_$1 input.dat
    ms_print $1_massif.out > $1_footprint_log.txt
    cat $1_footprint_log.txt | sed '8!d' >> ./results/$1_footprint.txt
    cat $1_footprint_log.txt | sed '9!d' >> ./results/$1_footprint.txt
    rm $1_massif.out $1_footprint_log.txt
fi
