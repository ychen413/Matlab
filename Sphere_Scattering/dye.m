function D = dye(n, theta, phi, dterm)
    % ye = LegendreP(n, 1, cos(theta)) * sin(phi) 
    % 'theta': dye / d(theta)
    % 'phi'  : dye / d(phi)
    
    if strcmp(dterm, 'theta') == 1
        D = associate_legendre_dx(n, 1, cos(theta)) .* (-sin(theta)) * sin(phi);
    end
    
    if strcmp(dterm, 'phi') == 1
       D = associate_legendre(n, 1, cos(theta)) .* cos(phi); 
    end
        