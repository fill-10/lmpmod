# This is LAMMPS input script specifies a simple DPD simulation.
boundary        p p p # periodic

units		lj # lennard-jones : unitless
atom_style	full
bond_style      harmonic
angle_style     cosine/delta
variable        T equal  1.0
pair_style	dpd ${T} 1.0 3438752   #pair_style dpd (define the bond potential) T cutoff(rc) seed, run DPD simulation 
                                     #cutoff was taken as our standard unit of length

# read data file or restart
#read_restart    restart.*
read_data	../SEBS1TMA_Linker_End.data 


# define masses and interaction coefficient
mass		* 1
bond_coeff      1  15.0  0.7   #between any particles   kb*(r-r0)^2 
bond_coeff      2  15.0  0.7 
bond_coeff      3  15.0  0.7 
bond_coeff      4  10.0  0.7
bond_coeff      5  15.0  0.7
bond_coeff      6  10.0  0.7
bond_coeff      7  10.0  0.7
bond_coeff      8  10.0  0.7
angle_coeff     1  15.0  150.   # ka*(1-cos(theta-theta0))
angle_coeff     2  10.0  150.   # 
angle_coeff     3  1.0  90.   # 
angle_coeff     4  1.0  90.   # 
angle_coeff     5  1.0  90.   # 
angle_coeff     6  1.0  90.   #  
angle_coeff     7  1.0  90.
angle_coeff     8  1.0  90.

special_bonds   lj 1.0 1.0 1.0   #default is 0 0 0. 

#variable        gamma equal 3.67^2/2./${T}    
variable        gamma equal 4.5

pair_coeff	 1 1 30.28 ${gamma}
pair_coeff	 1 2 35.02 ${gamma}
pair_coeff	 1 3 30.28 ${gamma}
pair_coeff	 1 4 29.24 ${gamma}
pair_coeff	 1 5 27.52 ${gamma}
pair_coeff	 1 6 34.80 ${gamma}
pair_coeff	 1 7 35.57 ${gamma}
pair_coeff	 1 8 30.28 ${gamma}
pair_coeff	 1 9 30.28 ${gamma}
pair_coeff	 2 2 30.53 ${gamma}
pair_coeff	 2 3 35.02 ${gamma}
pair_coeff	 2 4 27.74 ${gamma}
pair_coeff	 2 5 27.31 ${gamma}
pair_coeff	 2 6 30.05 ${gamma}
pair_coeff	 2 7 33.44 ${gamma}
pair_coeff	 2 8 35.02 ${gamma}
pair_coeff	 2 9 35.02 ${gamma}
pair_coeff	 3 3 30.28 ${gamma}
pair_coeff	 3 4 29.24 ${gamma}
pair_coeff	 3 5 27.52 ${gamma}
pair_coeff	 3 6 34.80 ${gamma}
pair_coeff	 3 7 35.57 ${gamma}
pair_coeff	 3 8 30.28 ${gamma}
pair_coeff	 3 9 30.28 ${gamma}
pair_coeff	 4 4 26.03 ${gamma}
pair_coeff	 4 5 25.59 ${gamma}
pair_coeff	 4 6 27.88 ${gamma}
pair_coeff	 4 7 27.46 ${gamma}
pair_coeff	 4 8 29.24 ${gamma}
pair_coeff	 4 9 29.24 ${gamma}
pair_coeff	 5 5 65.79 ${gamma}
pair_coeff	 5 6 -15.02 ${gamma}
pair_coeff	 5 7 26.61 ${gamma}
pair_coeff	 5 8 30.28 ${gamma}
pair_coeff	 5 9 30.28 ${gamma}
pair_coeff	 6 6 65.68 ${gamma}
pair_coeff	 6 7 27.34 ${gamma}
pair_coeff	 6 8 34.80 ${gamma}
pair_coeff	 6 9 34.80 ${gamma}
pair_coeff	 7 7 25.01 ${gamma}
pair_coeff	 7 8 35.57 ${gamma}
pair_coeff	 7 9 35.57 ${gamma}
pair_coeff	 8 8 30.28 ${gamma}
pair_coeff	 8 9 30.28 ${gamma}
pair_coeff	 9 9 30.28 ${gamma}

comm_modify     vel yes cutoff 2.0 #velocites are stored by ghost atoms for dpd style.

##energy minimization
#minimize        1.0e-4 1.0e-6 100 1000

# create initial velocities
#velocity	all create ${T} 49863 dist uniform 

# change neighbor list parameters to avoid dangerous builds
neighbor	2.0 bin
neigh_modify	delay 0 every 1

