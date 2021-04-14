#!/bin/bash

#Execute code 10 times

if [ -e $1 ] && [ $1 == "tables" ]
then
    for t in {1..10}
    do
        ./$1
    done
fi