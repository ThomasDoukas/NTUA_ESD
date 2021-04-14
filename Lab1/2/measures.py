import numpy as np
import sys

if(len(sys.argv) == 2):
    #Open file
    try:
        file = open(sys.argv[1] + ".out")
    except:
        print("Error! File does not exist") 
        exit(1)

    if(sys.argv[1]=="tables"):
        #Read data
        line = file.readline()
        
        data = []

        while line:
            data.append(int(line))
            line = file.readline()
        file.close()

        #Convert to np array
        arr = np.array(data)
        
        #All times are in usec
        print("Min time: ", arr.min())
        print("Max time: ", arr.max())
        print("Median: ", np.median(arr))
        print("Average time: ", np.average(arr))

else:
    print("Usage: python3 measures.py <measures_file>")