import io
import pandas as pd
import numpy as np


import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

#------------------------
filename = 'histo_W.dat'

#------------------------

f = open(filename , 'r')

raw = f.readlines()

num_headline = 3

num_bins = int(raw[3].split()[1])

num_atoms_per_snapshot = int(raw[3].split()[2])

num_timestep =  int( (len(raw)-3) / (num_bins+1) )

print(num_timestep)

print("number_of_bins:"+str(num_bins))

print("number_of_atoms_per_snapshot:"+str(num_atoms_per_snapshot))


snapshot_counter = 0

dist_frame =pd.DataFrame(np.zeros(num_bins),index=np.arange(1,num_bins+1), columns=['n_cluster'],dtype=int)

while snapshot_counter < num_timestep:
    start_row = num_headline + snapshot_counter *  ( num_bins+1) + 1  # first +1 is the headline
    stop_row  = num_headline + (snapshot_counter +1)  *  (  num_bins+1)
    tmp_raw = raw[start_row: stop_row]
    for i in range(0,num_bins):
        tmp_raw[i] = tmp_raw[i].split()[1:3]
    tmp_nparray = np.array(tmp_raw).astype(float) # use float here to convert sci format, int does not work.
    cluster_id_frame = pd.DataFrame( tmp_nparray, columns = ['cluster_id', 'count']).astype(int)
    #print(cluster_id_frame)

    sizes, bins = np.histogram(cluster_id_frame['count'], bins = np.arange(1, num_bins+2) )
    """
    print(bins)
    print(sizes)
    print(len(bins))
    print(len(sizes))
    """
    # ids of largest 5 clusters 
    largest5 = cluster_id_frame.sort_values(by=['count', 'cluster_id']).iloc[-5:]
    #print(largest5)

    dist_frame['n_cluster'] +=   sizes
    snapshot_counter +=1
    print(snapshot_counter)

del raw

f.close()

dist_frame['total_atoms'] = dist_frame.index * dist_frame['n_cluster']

dist_frame['prob'] = dist_frame['total_atoms']/dist_frame['total_atoms'].sum()

#print(dist_frame['total_atoms'].sum())

#--- save to xlsx ---
output_filename = filename+'.xlsx'
writer = pd.ExcelWriter(output_filename)
dist_frame.to_excel(writer, 'Sheet1')
writer.save()

print( 'saved to xlsx')

#--- save the largest 5 ---

largest5_filename = 'largest.xlsx'
writer_largest_id = pd.ExcelWriter(largest5_filename)
largest5.to_excel(writer_largest_id, 'LastSnapshot')
writer_largest_id.save()

#--- save graph ---

fig, ax = plt.subplots(figsize=(6,4.5))
ax.plot(dist_frame.index, dist_frame['prob'], 'ro', mfc=None)
ax.set_ylabel('prob')
ax.set_xlabel('size')
ax.set_yscale('log')
ax.set_xscale('log')
#ax.set_xlim([1,10000])
#fig.tight_layout()
fig.savefig(filename+'.png')

print('graph generated')

"""
msd_frame['msd_r'] = tmp_frame[tmp_frame.index %5 == 4][1].values
"""
