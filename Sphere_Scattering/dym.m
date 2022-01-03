function D = dym(n, theta, phi, dterm)
    % ym = LegendreP(n, 1, cos(theta)) * cos(phi) 
    % 'theta': dym / d(theta)
    % 'phi'  : dym / d(phi)
    
    if strcmp(dterm, 'theta') == 1
        D = associate_legendre_dx(n, 1, cos(theta)) .* (-sin(theta)) * cos(phi);
    end
    
    if strcmp(dterm, 'phi') == 1
       D = -associate_legendre(n, 1, cos(theta)) .* sin(phi); 
    end