#!/bin/bash
#Used to specify output files

if [ ! $# -eq 1 ]
then
    echo "Usage: ./execute <executable_code>"
else
    if [ -e $1 ]
    then
        ./run.sh $1 1>$1.out 2>$1.err
        #cat $1.err
        #cat $1.out
        python3 measures.py $1
    else
        echo "File does not exist!"
        echo "Check if code is compiled."
    fi
fi
