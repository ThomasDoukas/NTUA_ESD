import numpy as np
import sys

def bp_data(array):
    #Boxplot data
    file = open("Boxplot/" + sys.argv[1] + ".data", "w")
    for num in array:
        file.write(str(num) + " ")
    file.close()

if(len(sys.argv) == 2):
    #Open file
    try:
        file = open(sys.argv[1] + ".out")
    except:
        print("Error! File does not exist") 
        exit(1)

    if(sys.argv[1]=="phods" or sys.argv[1]=="opt_phods"):
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

        bp_data(arr)
    
    elif(sys.argv[1]=="dse_phods" or sys.argv[1]=="dse_rect_phods"):
        #Read data
        line = file.readline().split()

        index = [] #Block size
        data = [] #Times
        avg_times = []

        while line:
            if (len(line) == 1):
                #Append size for dse_phods
                index.append(int(line[0]))
            elif (len(line) == 2):
                #Append size for dse_opt_phods
                index.append(line[0]+"x"+line[1])
            else:
                #Append times. List of lists of int
                data.append( list(map(int, line)) )
            line = file.readline().split()
        file.close()
        
        #Calculate avg times for each block
        for block in data:
            avg_times.append(np.average(block))
        
        #Print minum average and block size
        min_avg_time = min(avg_times)
        block_size = index[avg_times.index(min_avg_time)]
        print("Minimum average time =", min_avg_time, "for block size =", block_size)
        bp_data(block)


else:
    print("Usage: python3 measures.py <measures_file>")