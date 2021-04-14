import seaborn as sns
import matplotlib.pyplot as plt

#This will be a list of lists of ints
meas = []

#Read data
for filename in ["phods", "opt_phods", "dse_phods", "dse_rect_phods"]:
    file = open("Boxplot/" + filename + ".data")
    #From str to int
    line = list(map(int, file.readline().split()))
    meas.append(line)
    file.close()

# Thank you guy at stack overflow
#Only phods boxplot
fig, ax = plt.subplots()
ax.boxplot(meas[0])
ax.set_xticklabels(["phods"])
plt.grid()
plt.savefig('Images/phods_boxplot.png')

#All runs
fig, ax = plt.subplots()
ax.boxplot(meas)
ax.set_xticklabels(["phods", "opt_phods", "dse_phods", "dse_rect_phods"])
plt.grid()
plt.savefig('Images/all_boxplot.png')

#Readable boxplot
del(meas[0])
fig, ax = plt.subplots()
ax.boxplot(meas)
ax.set_xticklabels(["opt_phods", "dse_phods", "dse_rect_phods"])
plt.grid()
plt.savefig('Images/final_boxplot.png')
