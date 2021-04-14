#!/bin/bash
#Execute code 10 times

if [ -e $1 ] && [ $1 == "phods" ]
then
    for t in {1..10}
    do
        ./$1
    done
elif [ -e $1 ] && [ $1 == "opt_phods" ]
then
    for t in {1..10}
    do
        ./$1
    done
elif [ -e $1 ] && [ $1 == "dse_phods" ]
then
    for B in 1 2 4 8 16
    do
        echo "$B"
        for t in {1..10}
        do
            ./$1 $B
        done
        echo
    done 
elif [ -e $1 ] && [ $1 == "dse_rect_phods" ]
then
    for Bx in 1 2 3 4 6 8 9 12 16 18 24 36 48 72 144
    do
        for By in 1 2 4 8 11 16 22 44 88 176
        do
            echo "$Bx $By"
            for t in {1..10}
            do
                ./$1 $Bx $By
            done
            echo
        done
    done
fi