###------check time step size------###
#
#
# compute statements to normalize the pe and ke
compute pe1 all pe/atom
compute ke1 all ke/atom

# cacluate avg values over atoms
compute per all reduce ave c_pe1
compute ker all reduce ave c_ke1

# variable statements for total energy and squares of energy
variable etotalr   equal c_per+c_ker
variable etotalr_2 equal v_etotalr*v_etotalr
variable ker_2     equal c_ker*c_ker
variable per_2     equal c_per*c_per

variable thermo_P equal press
variable thermo_P_2 equal v_thermo_P*v_thermo_P

variable thermo_T equal temp
variable thermo_T_2 equal v_thermo_T*v_thermo_T

variable boxvol equal lx*ly*lz #Angstrom^3
variable boxvol_2 equal v_boxvol*v_boxvol

variable boxden equal density #Angstrom^3
variable boxden_2 equal v_boxden*v_boxden

variable thermo_H equal enthalpy
variable thermo_H_2 equal v_thermo_H*v_thermo_H

fix   etotalr_avt all ave/time ${nevery} ${nrepeat} ${nfreq}  v_etotalr ave window ${Nblock}
fix etotalr_2_avt all ave/time ${nevery} ${nrepeat} ${nfreq}  v_etotalr_2 ave window ${Nblock}
fix      ker_avt  all ave/time ${nevery} ${nrepeat} ${nfreq}  c_ker ave window ${Nblock}
fix    ker_2_avt  all ave/time ${nevery} ${nrepeat} ${nfreq}  v_ker_2 ave window ${Nblock}
fix      per_avt  all ave/time ${nevery} ${nrepeat} ${nfreq}  c_per ave window ${Nblock}
fix    per_2_avt  all ave/time ${nevery} ${nrepeat} ${nfreq}  v_per_2 ave window ${Nblock}
fix thermo_P_avt  all ave/time ${nevery} ${nrepeat} ${nfreq}  v_thermo_P ave window ${Nblock}
fix thermo_P_2_avt  all ave/time ${nevery} ${nrepeat} ${nfreq}  v_thermo_P_2 ave window ${Nblock}
fix thermo_T_avt  all ave/time ${nevery} ${nrepeat} ${nfreq}  v_thermo_T ave window ${Nblock}
fix thermo_T_2_avt  all ave/time ${nevery} ${nrepeat} ${nfreq}  v_thermo_T_2 ave window ${Nblock}

fix box_v_avt  all ave/time ${nevery} ${nrepeat} ${nfreq}  v_boxvol ave window ${Nblock}
fix box_v_2_avt  all ave/time ${nevery} ${nrepeat} ${nfreq}  v_boxvol_2 ave window ${Nblock}

fix box_den_avt  all ave/time ${nevery} ${nrepeat} ${nfreq}  v_boxden ave window ${Nblock}
fix box_den_2_avt  all ave/time ${nevery} ${nrepeat} ${nfreq}  v_boxden_2 ave window ${Nblock}

fix thermo_H_avt  all ave/time ${nevery} ${nrepeat} ${nfreq}  v_thermo_H ave window ${Nblock}
fix thermo_H_2_avt  all ave/time ${nevery} ${nrepeat} ${nfreq}  v_thermo_H_2 ave window ${Nblock}

run ${nrun}


###------post-processing------###

print "  "
print "Duration: ${nrun} steps."

variable Natom_total equal count(all)

print "Atoms: ${Natom_total}"
print "#"

variable ker_avt    equal f_ker_avt
variable ker_2_avt  equal f_ker_2_avt
variable ker_stddev equal sqrt(${ker_2_avt}-${ker_avt}*${ker_avt})

variable ker_stderr equal ${ker_stddev}/sqrt(${Nblock})

print "ker_avt ${ker_avt} +/- ${ker_stddev} (${ker_stderr}) " 

variable      per_avt equal f_per_avt
variable    per_2_avt equal f_per_2_avt
variable  per_stddev  equal sqrt(${per_2_avt}-${per_avt}*${per_avt})
variable per_stderr equal ${per_stddev}/sqrt(${Nblock})

print "per_avt ${per_avt} +/- ${per_stddev} (${per_stderr}) " 

variable   etotalr_avt equal f_etotalr_avt
variable etotalr_2_avt equal f_etotalr_2_avt
variable etotalr_stddev equal sqrt(${etotalr_2_avt}-${etotalr_avt}*${etotalr_avt})


variable etotalr_stderr equal ${etotalr_stddev}/sqrt(${Nblock})

print "etotalr_avt ${etotalr_avt} +/- ${etotalr_stddev} (${etotalr_stderr}) " 

variable thermo_P_avt equal f_thermo_P_avt
variable thermo_P_2_avt equal f_thermo_P_2_avt
variable thermo_P_stddev equal sqrt(${thermo_P_2_avt}-${thermo_P_avt}*${thermo_P_avt})


variable thermo_P_stderr equal ${thermo_P_stddev}/sqrt(${Nblock})


print "thermo_P ${thermo_P_avt} +/- ${thermo_P_stddev} (${thermo_P_stderr})"

variable thermo_T_avt equal f_thermo_T_avt
variable thermo_T_2_avt equal f_thermo_T_2_avt
variable thermo_T_stddev equal sqrt(${thermo_T_2_avt}-${thermo_T_avt}*${thermo_T_avt})

variable thermo_T_stderr equal ${thermo_T_stddev}/sqrt(${Nblock})

print "thermo_T ${thermo_T_avt} +/- ${thermo_T_stddev} (${thermo_T_stderr})"

variable box_v_avt   equal f_box_v_avt
variable box_v_2_avt  equal f_box_v_2_avt
variable box_v_stddev equal sqrt(abs(${box_v_2_avt}-${box_v_avt}*${box_v_avt}))
# use abs() to prevent negative values when running in nvt
variable box_v_stderr equal ${box_v_stddev}/sqrt(${Nblock})

print "box_v_avt ${box_v_avt} +/- ${box_v_stddev} (${box_v_stderr}) " 

variable box_den_avt   equal f_box_den_avt
variable box_den_2_avt  equal f_box_den_2_avt
variable box_den_stddev equal sqrt(abs(${box_den_2_avt}-${box_den_avt}*${box_den_avt}))

variable box_den_stderr equal ${box_den_stddev}/sqrt(${Nblock})

print "box_den_avt ${box_den_avt} +/- ${box_den_stddev} (${box_den_stderr}) " 

variable thermo_H_avt   equal f_thermo_H_avt
variable thermo_H_2_avt  equal f_thermo_H_2_avt
variable thermo_H_stddev equal sqrt(${thermo_H_2_avt}-${thermo_H_avt}*${thermo_H_avt})

variable thermo_H_stderr equal ${thermo_H_stddev}/sqrt(${Nblock})

print "thermo_H_avt ${thermo_H_avt} +/- ${thermo_H_stddev} (${thermo_H_stderr}) " 


print " "
print "#######"
print " "
print " "

###--- clean variables ---

variable ker_avt    delete
variable ker_2_avt  delete
variable ker_stddev delete
variable ker_stderr delete

variable    per_avt delete
variable  per_2_avt delete
variable per_stddev delete
variable per_stderr delete

variable    etotalr_avt delete
variable  etotalr_2_avt delete
variable etotalr_stddev delete
variable etotalr_stderr delete

variable thermo_P_avt    delete
variable thermo_P_2_avt  delete
variable thermo_P_stddev delete
variable thermo_P_stderr delete

variable thermo_T_avt    delete
variable thermo_T_2_avt  delete
variable thermo_T_stddev delete
variable thermo_T_stderr delete

variable box_v_avt     delete
variable box_v_2_avt   delete
variable box_v_stddev  delete
variable box_v_stderr  delete

variable box_den_avt    delete
variable box_den_2_avt  delete
variable box_den_stddev delete
variable box_den_stderr delete

variable thermo_H_avt    delete
variable thermo_H_2_avt  delete
variable thermo_H_stddev delete
variable thermo_H_stderr delete

unfix  etotalr_avt
unfix  etotalr_2_avt
unfix  ker_avt
unfix  ker_2_avt
unfix  per_avt
unfix  per_2_avt
unfix  thermo_P_avt
unfix  thermo_P_2_avt
unfix  thermo_T_avt
unfix  thermo_T_2_avt
unfix  box_v_avt
unfix  box_v_2_avt
unfix  box_den_avt
unfix  box_den_2_avt
unfix  thermo_H_avt
unfix  thermo_H_2_avt

variable  etotalr        delete
variable  etotalr_2      delete
variable  ker_2          delete
variable  per_2          delete
variable  thermo_P       delete
variable  thermo_P_2     delete
variable  thermo_T       delete
variable  thermo_T_2     delete
variable  boxvol         delete
variable  boxvol_2       delete
variable  boxden         delete
variable  boxden_2       delete
variable  thermo_H       delete
variable  thermo_H_2     delete

uncompute  per 
uncompute  ker
uncompute  pe1
uncompute  ke1

