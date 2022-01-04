# Matlab
  Matlab code
  Used to generate antenna radiation pattern data

# Sphere_Scattering
  Analytical solution for sphere scattering (with Bessel's funcation)
  "main.m" - data generator
  Can use "config_generator" or load .csv file for the input configuration:
    - num_data: Amount of data generated
    - eps_min, eps_max: range of epsilon (permittivity of the sphere)
    - mu_min, mu_max: range of mu (permeability of the sphere)
    - ra_min, ra_max: range of radius-wavelength ratio of the sphere (a = ra * c / f0)
    - fn_min, fn_max: range of center frequency (f = fn * f0, f0=1e9 or 1GHz as defauld)
  Part of generated data are attached in "Generated data" folder

# YagiUda
  Generating radiation pattern from different antenna object in Matlab
  Containing live code (.mlx) file to try the function
  Each antenna object has its own (geomety) configurations
  Part of generated data are attached in "Data" folder
