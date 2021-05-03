# StressInversions
Matlab scripts and functions for inverting focal mechanisms
README for stress inversions

Codes adapted from Vavryčuk [2014, GJI] by Will Levandowski. 
WL funded by USGS Mendenhall Postdoctoral Fellowship (2014–2018). 
First used in: Levandowski, W., Herrmann, R.B.., Boyd, O.S., Briggs, R., and Gold, R. (2018) An updated stress map of the continental United States reveals heterogeneous intraplate stress: Nature Geoscience, v. 11, pp. 433-437. https://doi.org/10.1038/s41561-018-0120-x

Contact: Will Levandowski, now at Tetra Tech, Inc.
Will.Levandowski@tetratech.com
Permanent email addresses: BoulderGeophysics@gmail.com; wlevando@gmail.com
I’m generally more than happy to help, to help troubleshoot, or to collaborate on projects if I can contribute something! 

The main script is "StressInversion_single.m".
Simply run StressInversion_single, and a figure should pop up in a few seconds.

 

Note that this bundle of scripts has been heavily modified by Will Levandowski, but the real meat of the inversions is from Vavryčuk [2014, GJI 2014]. Please be sure to cite that work in any publications that use this code. (If you also cite Levandowski et al. [2018, Nature Geoscience], I won’t argue!)

The process of StressInversion_single is as follows:
•	Read in focal mechanisms. Here, they are stored as a five-column matrix: 
[Longitude Latitude Strike Dip Rake].
Only one nodal plane is needed. The other will be computed automatically.
•	Set parameters. Results of the inversions (hopefully!) are typically robust with respect to the values of these parameters: 
o	The amplitude of noise added to mechanisms in each realization of the inversion, 
o	The mean value and range of frictional coefficients sampled.
o	The number of realizations of the inversions used (needed for uncertainty metrics)
o	 The number of iterations of nodal plane selection
o	The number of random plane choices used to initialize each inversion.

•	Run the inversions “jackknife_StressInversion” 
•	Assemble and plot a stereonet of results
•	
The name StressInversion_single is chosen because this script only inverts one set of focal mechanisms. It is straightforward to call this script multiple times to invert multiple sets of mechanisms for different seismic zones, before and after a mainshock, over different depth ranges, et cetera.

The script conducts N_noise_realizations inversions of the same suite of focal mechanisms in order to compute N_noise_realizations independent best-fitting normalized stress tensors. The range of results of these inversions is used to compute uncertainties. 

The details of each inversion are laid out in jackknife_StressInversions.m
•	Initialize output variables
•	Call noisy_mechanisms_DistWeighted
o	Calculate the auxiliary planes for each mechanism 
o	Add noise to the slip vectors described by each mechanism
o	Jackknife-resample the full suite of n focal mechanisms, discarding n0.5 mechanisms. (example/ 52 of 59 events used in each inversion)
o	Choose a random friction from the range defined earlier
•	Run the inversion in statistics_stress_inversion
o	Randomly choose one of the two nodal planes for each of the (n-n0.5) mechanisms
o	Run the inversion with this random choice of planes, finding the best-fit normalized tensor
o	Revisit each mechanism. Compute the instability factor for each planes given the current estimate of the stress tensor. Choose the less stable. Conduct the inversion with these planes. 
o	Repeat this step N_iterations times. Stack these results. 
o	Repeat the entire process N_realizations times. Stack these results.
•	The outputs are a normalized stress tensor. 
Compute the principal stress directions, the style of faulting (normal, strike-slip, oblique; following Zoback [1992 JGR]), and then the stress ratio Aɸ [Simpson, 1997 JGR].

Repeat jackknife_StressInversion N_noise_realizations times. 
Each will jackknife the mechanisms, choose a random friction, add noise, and conduct the set of iterative inversions on these resampled, noisy mechanisms.

In the end, there will be N_noise_realizations best-fitting normalized tensors. Each will be described by the principal stress directions and stress ratio.

StressStereonet plots the results, oriented with north at the top, east at the right, and vertical in the center.




