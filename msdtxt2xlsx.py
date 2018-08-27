import io
import pandas as pd
import numpy as np


import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

msdfilename = '095_AgO_msd_ag_rdf.txt'

tmp_frame = pd.read_csv(msdfilename, delimiter=' ', skiprows=3, header=None)


timestep_column = tmp_frame[ tmp_frame.index %5 == 0 ][0].values



msd_frame = pd.DataFrame( index = timestep_column)

msd_frame['msd_x'] = tmp_frame[tmp_frame.index %5 == 1][1].values
msd_frame['msd_y'] = tmp_frame[tmp_frame.index %5 == 2][1].values
msd_frame['msd_z'] = tmp_frame[tmp_frame.index %5 == 3][1].values
msd_frame['msd_r'] = tmp_frame[tmp_frame.index %5 == 4][1].values


output_filename = msdfilename+'.xlsx'
writer = pd.ExcelWriter(output_filename)
msd_frame.to_excel(writer, 'Sheet1')
writer.save()

fig, ax = plt.subplots(figsize=(6,4.5))
ax.plot(msd_frame.index, msd_frame['msd_r'], 'b-')
ax.set_ylabel('MSD/A^2')
ax.set_xlabel('Timestep')
#fig.tight_layout()
fig.savefig(msdfilename+'.png')

