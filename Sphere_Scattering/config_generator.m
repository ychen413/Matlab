function conf = config_generator(num_input, ...
                              eps_min, eps_max, ...
                              mu_min, mu_max, ...
                              ra_min, ra_max, ...
                              fn_min, fn_max)
    % Generate the input configurations
    % Input:
    %   num_input       : Number of data we want to generate
    %   eps_min, eps_max: Permittivity of the sphere
    %   mu_min, mu_max  : Permeability of the sphere
    %   ra_min, ra_max  : Radius ratio of the sphere (a = ra * c / f0)
    %   fn_min, fn_max  : Center frequency (f = fn * f0, f0=1e9 as default)
    %
    % Output:
    %   conf (num_input, 4); [eps, mu, ra, fn]
    
    eps = eps_min + (eps_max - eps_min) * rand(num_input, 1);
    mu = mu_min + (mu_max - mu_min) * rand(num_input, 1);
    ra = ra_min + (ra_max - ra_min) * rand(num_input, 1);
    fn = fn_min + (fn_max - fn_min) * rand(num_input, 1);
    
    conf = [eps, mu, ra, fn];
end
    

