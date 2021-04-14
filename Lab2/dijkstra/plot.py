import matplotlib.pyplot as plt

#Filenames
files = ["sll", "dll", "dynarr"]

#Read accesses and footprints
accesses = [] 
footprints = []
for filename in files:

    #Accesses
    file_acc = open("results/" + filename + "_accesses.txt", "r")
    line = file_acc.readline()
    mes = float(line) / 1000000
    accesses.append(mes)
    file_acc.close()

    #Footprints
    file_fp = file_fp = open("results/" + filename + "_footprint.txt", "r")
    mul = 1
    line = file_fp.readline()
    if(line[4:6]=="MB"):
        mul = 1000
    line = file_fp.readline()
    footprints.append(float(line[:5]) * mul)
    file_fp.close()

#Full accesses plot
plt.title("Memory Accesses")
plt.plot(accesses, files, "bo" )
plt.ylabel("Data structures client_packet")
plt.xlabel("Num of accesses (millions)")
plt.tight_layout()
plt.grid()
plt.savefig('Images/accesses.png')

#Footprin plot
plt.figure()
plt.title("Memory Footprints")
plt.plot(footprints, files, "ro" )
plt.ylabel("Data structures client_packet")
plt.xlabel("Footprints (KB)")
plt.tight_layout()
plt.grid()
plt.savefig('Images/footprints.png')
