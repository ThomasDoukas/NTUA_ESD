#!/bin/bash

./execute.sh phods
./execute.sh opt_phods
./execute.sh dse_phods
./execute.sh dse_rect_phods
python3 boxplot.py
