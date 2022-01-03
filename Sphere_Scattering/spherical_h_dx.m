function D = spherical_h_dx(n, x)
    % spherical_h_d = d(spherical_h(n, x)) / dx
    % 
    % Derivative of 2nd kind spherical Hankel function:
    %   dH2(n, x) / dx = (1/2) * (H2(n-1, x) - (H2(n, x) + H2(n+1, x)) / x)
    
%     D = (spherical_h(n-1, x) - (spherical_h(n, x) + spherical_h(n+1, x)) ./ x) ./ 2;
    D = spherical_h(n-1, x) - (n + 1)' ./ x .* spherical_h(n, x);
    