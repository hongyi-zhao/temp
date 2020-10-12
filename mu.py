#!/usr/bin/env python
#Calculate Fermi level as function of concentration
# Hartwin Peelaers

# TODO
# parallel computing with joblib
# https://joblib.readthedocs.io/en/latest/

import numpy as np

def fermi(E,mu,kT):
	return 1./(np.exp((E-mu)/kT)+1)

# fermi_array = vectorize(fermi)

data = np.genfromtxt("./dos/BiVO4.dos-202018-sm003")
energy=data[:,0] #in eV
DOS=data[:,1]    #states/unit cell/ eV

# cutoff some portion of DOS
index = np.argmax(energy > -11.0)
energy=energy[index:]
DOS = DOS[index:]
#print(energy, DOS)

#k=1.3806488E-23 #J/K
k=8.6173324e-5 #eV/K
T= 300 # K
volume = 314.65333308 # ang^3, BiVO4 tet, pbe
volume_cm = volume*1e-24
numelect = 136 # BiVO4, tet, pbe
kT=k*T #eV

res_size = 6000
# range of mus
mu_init=10.3 #eV
mu_step=0.0001 #eV
res = np.zeros(res_size)
mu_all = np.zeros(res_size)
for i in np.arange(0, res_size):
	mu=mu_init+i*mu_step
	mu_all[i]=mu
	integrand = DOS * fermi(energy, mu, kT)
	res[i]=(np.trapz(integrand,energy)-numelect)/volume_cm #in cm-3

allres=np.column_stack((mu_all,res))
#print(allres)
np.savetxt('mu_conc.dat', allres)



