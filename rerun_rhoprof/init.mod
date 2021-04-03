# This is LAMMPS input script specifies a simple DPD simulation.
boundary        p p p # periodic

units		lj # lennard-jones : unitless
atom_style	full
bond_style      harmonic
angle_style     cosine/delta
variable        T equal  1.0
pair_style	dpd ${T} 1.0 9438752   #pair_style dpd (define the bond potential) T cutoff(rc) seed, run DPD simulation 

# read data file or restart
#read_restart    restart.*
read_data	../comp_box/PPOPS25_H20_DPD.data

# define masses and interaction coefficient
mass		* 1

##--------- Neighbor and communication settings ----------
neighbor	2.0 bin
neigh_modify	delay 0 every 1 # default is every 10 steps
comm_modify     vel yes cutoff 5.0 #velocites are stored by ghost atoms for dpd style.


##--------- Bond and angle coeff -------------------------
bond_coeff      1  800.0  0.65 # PPO-PPO #between any particles   kb*(r-r0)^2 
bond_coeff      2  240.0  0.6  # PPO-PA
bond_coeff      3  150.0  1.4  # 1-3 PPO
bond_coeff      4  30.0   0.7 # Bs-Bs
bond_coeff      5  30.0   0.7 # Bs-Ph
bond_coeff      6  30.0   0.7 # Ph-A2
bond_coeff      7  100.0  0.6 # Ph-A1
#
angle_coeff     1  15.0  150.  # Bs-Bs-Bs #ka*(1-cos(theta-theta0))
angle_coeff     2  10.0  150.  # Bs-Ph-A2
angle_coeff     3  25.0  135.  # Bs-Ph-A1

special_bonds   lj 1.0 1.0 1.0   #default is 0 0 0. 

##---------- non bonded parameters (DPD) ----------
#variable        gamma equal 3.67^2/2./${T}    
variable        gamma equal 4.5

pair_coeff	 1 1  38.73 ${gamma} #  PPO PPO
pair_coeff	 1 2  32.13 ${gamma} #  PPO PA
pair_coeff	 1 3  35.12 ${gamma} #  PPO Bs
pair_coeff	 1 4  36.45 ${gamma} #  PPO Ph
pair_coeff	 1 5  37.03 ${gamma} #  PPO A2
pair_coeff	 1 6  37.03 ${gamma} #  PPO A1
pair_coeff	 1 7  33.23 ${gamma} #  PPO W
#
pair_coeff	 2 2  25.80 ${gamma} #  PA PA
pair_coeff	 2 3  27.59 ${gamma} #  PA Bs
pair_coeff	 2 4  26.33 ${gamma} #  PA Ph
pair_coeff	 2 5  27.27 ${gamma} #  PA A2
pair_coeff	 2 6  27.27 ${gamma} #  PA A1
pair_coeff	 2 7  27.42 ${gamma} #  PA W
#
pair_coeff	 3 3  30.28 ${gamma} # Bs Bs
pair_coeff	 3 4  35.02 ${gamma} # Bs Ph
pair_coeff	 3 5  29.03 ${gamma} # Bs A2
pair_coeff	 3 6  29.03 ${gamma} # Bs A1
pair_coeff	 3 7  35.57 ${gamma} # Bs W
#
pair_coeff	 4 4  30.53 ${gamma} # Ph Ph
pair_coeff	 4 5  28.25 ${gamma} # Ph A2
pair_coeff	 4 6  28.25 ${gamma} # Ph A1
pair_coeff	 4 7  33.44 ${gamma} # Ph W
#
pair_coeff	 5 5  29.10 ${gamma} # A2 A2
pair_coeff	 5 6  29.10 ${gamma} # A2 A1
pair_coeff	 5 7  26.70 ${gamma} # A2 W
#
pair_coeff	 6 6  29.10 ${gamma} # A1 A1
pair_coeff	 6 7  27.31 ${gamma} # A1 W
#
pair_coeff	 7 7  25.0  ${gamma} #  W W


