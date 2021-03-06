function [E_te, E_tm] = spherical_scattering(eps1, mu1, r_a, fn, f0)
    % Measuring the scattering electrical field of a ball (sphere)
    % Input:
    %   eps1: Permittivity of the sphere
    %   mu1 : Permeability of the sphere
    %   r_a : Radius of the sphere (a = r_a * c / f0 [m])
    %   fn  : Center frequency     (f = fn * f0 [Hz])
    %   f0  : Frequency scale unit (Default: [GHz] -> 1e9)
    %
    % Output form:
    %   E_xx: Scattering electrical field; te -> TE mode; tm -> TM mode
    %   E_t{e/m} (length(theta) *length(phi), 5): 
    %       E_t{e/m}(:, 1): theta
    %       E_t{e/m}(:, 2): phi
    %       E_t{e/m}(:, 3): E_r
    %       E_t{e/m}(:, 4): E_theta = sum_{n=1}^{num_mode} E_theta(n)
    %       E_t{e/m}(:, 5): E_phi = sum_{n=1}^{num_mode} E_phi(n)
    %
    % Configuration:
    %   Can change inside the function
    %   Default:
    %       E0 = 1         : Intensity of the incident electrical field
    %       r = 100        : Distance from the object sphere
    %
    %       The angles can be defined as:
    %          d_theta = 0.05 : Step of Polar angle (angle with +z-axis) (rad)
    %          d_phi = 0.1    : Step of Azimuth angle (angle with +x-axis) (rad)
    %                          (Plot 3,869 points under this steps)
    %       Or: (new, in order to let the input be 64 X 64 array -> image)
    %          num_theta = 64
    %          num_phi = 64
    %
    %       num_mode = 40  : Number of mode in the model (n = 1:num_mode)
    %
    % Constant
    %   c = 3e8;           : Light speed in free space (m)
    %   eps0 = 8.854e-12;  : Permittivity in free space
    %   mu0 = pi * 4e-7;   : Permeability in free space

    %% Configuration
    if nargin == 4
        f0 = 1e9;
    else
        error('Not enough input arguments.')        
    end

    E0 = 1;             % Intensity of the incident electrical field
    r = 100;            % Distance from the object sphere
%     d_theta = 0.05;     % Step of Polar angle (angle with +z-axis) (rad)
%     d_phi = 0.1;        % Step of Azimuth angle (angle with +x-axis) (rad)
    num_theta = 64;
    num_phi = 64;

    num_mode = 40;      % Number of mode in the model

    % Define constant
    c = 3e8;            % Light speed in free space (m)
    eps0 = 8.854e-12;   % Permittivity in free space
    mu0 = pi * 4e-7;    % Permeability in free space

    a = c / f0 * r_a;   % Radius of the sphere (m)
    f = fn * f0;        % Center frequency of the wave (Hz)
    w = 2 * pi * f;     % Angular frequency (rad / sec)

%     theta = 1e-4:d_theta:pi;  % Measuring Polar angle (angle with +z-axis) (rad)
%     phi = 0:d_phi:2*pi;       % Measuring Azimuth angle (angle with +x-axis) (rad)
    theta = linspace(1e-4, pi-1e-4, num_theta);
    phi = linspace(0, 2*pi, num_phi);

    n = 1:num_mode;     % mode (from 1 to num_mode)

    %% Calculation process
    % Bessel functions in the equation of Cte & Ctm
    bsj_p12_0 = besselj(n+1/2, a*sqrt(eps0 * mu0) * w);
    bsj_n12_0 = besselj(n-1/2, a*sqrt(eps0 * mu0) * w);

    bsj_p12_1 = besselj(n+1/2, a*sqrt(eps0 * eps1 * mu0 * mu1) * w);
    bsj_n12_1 = besselj(n-1/2, a*sqrt(eps0 * eps1 * mu0 * mu1) * w);

    bsj_p32_0 = besselj(n+3/2, a*sqrt(eps0 * mu0) * w);
    bsj_p32_1 = besselj(n+3/2, a*sqrt(eps0 * eps1 * mu0 * mu1) * w);
    % bsj_n32_1 = besselj(n-3/2, a*sqrt(eps0 * eps1 * mu0 * mu1) * w);

    bsy_p12_0 = bessely(n+1/2, a*sqrt(eps0 * mu0) * w);
    bsy_n12_0 = bessely(n-1/2, a*sqrt(eps0 * mu0) * w);

    bsy_p12_1 = bessely(n+1/2, a*sqrt(eps0 * eps1 * mu0 * mu1) * w);
    bsy_n12_1 = bessely(n-1/2, a*sqrt(eps0 * eps1 * mu0 * mu1) * w);

    bsy_p32_0 = bessely(n+3/2, a*sqrt(eps0 * mu0) * w);
    bsy_p32_1 = bessely(n+3/2, a*sqrt(eps0 * eps1 * mu0 * mu1) * w);

    tic
    % TE mode
    % Scalar coefficient
    ct1 = a * eps0 * eps1 * mu0 * mu1 * (eps1 * mu1)^(1/4) * w;
    ct2 = -a * eps0 * mu0 * mu1 * (eps1 * mu1)^(3/4) * w;
    ct3 = -sqrt(eps0 * mu0) * mu1 * (eps1 * mu1)^(3/4);
    ct4 = (eps1 * mu1)^(1/4) * sqrt(eps0 * eps1 * mu0 * mu1);
    ct5 = a * eps0 * mu0 * mu1 * (eps1 * mu1)^(3/4) * w;
    ct6 = -a * eps0 * eps1 * mu0 * mu1 * (eps1 * mu1)^(1/4) * w;

    % Real part
    At1 = ct1 .* bsj_n12_1 .* bsj_p12_0;
    At2 = ct2 .* bsj_n12_0 .* bsj_p12_1;
    At3 = ct3 .* bsj_p12_0 .* bsj_p12_1;
    At4 = ct4 .* bsj_p12_0 .* bsj_p12_1;
    At5 = ct5 .* bsj_p12_1 .* bsj_p32_0;
    At6 = ct6 .* bsj_p12_0 .* bsj_p32_1;

    % Imaginary part
    Bt1 = ct2 .* bsj_p12_1 .* bsy_n12_0;
    Bt2 = ct1 .* bsj_n12_1 .* bsy_p12_0;
    Bt3 = ct3 .* bsj_p12_1 .* bsy_p12_0;
    Bt4 = ct4 .* bsj_p12_1 .* bsy_p12_0;
    Bt5 = ct6 .* bsj_p32_1 .* bsy_p12_0;
    Bt6 = ct5 .* bsj_p12_1 .* bsy_p32_0;

    % Cte
    Nominator = At1 + At2 + At3 + At4 + At5 + At6;
    Denominator = -Nominator + 1i*(Bt1 + Bt2 + Bt3 + Bt4 + Bt5 + Bt6);
    Cte = Nominator ./ Denominator;

    % TM mode
    % Scalar coefficient
    cm1 = a * eps0 * eps1 * mu0 * mu1 * (eps1 * mu1)^(3/4) * w;
    cm2 = -a * eps0 * eps1^2 * mu0 * mu1 * (eps1 * mu1)^(1/4) * w;
    cm3 = -eps1^2 * sqrt(eps0 * mu0) * mu1 * (eps1 * mu1)^(1/4);
    cm4 = (eps1 * mu1)^(3/4) * sqrt(eps0 * eps1 * mu0 * mu1);
    cm5 = a * eps0 * eps1^2 * mu0 * mu1 * (eps1 * mu1)^(1/4) * w;
    cm6 = -a * eps0 * eps1 * mu0 * mu1 * (eps1 * mu1)^(3/4) * w;

    % Real part
    Am1 = cm1 .* bsj_n12_1 .* bsj_p12_0;
    Am2 = cm2 .* bsj_n12_0 .* bsj_p12_1;
    Am3 = cm3 .* bsj_p12_0 .* bsj_p12_1;
    Am4 = cm4 .* bsj_p12_0 .* bsj_p12_1;
    Am5 = cm5 .* bsj_p12_1 .* bsj_p32_0;
    Am6 = cm6 .* bsj_p12_0 .* bsj_p32_1;

    % Imaginary part
    Bm1 = cm2 .* bsj_p12_1 .* bsy_n12_0;
    Bm2 = cm1 .* bsj_n12_1 .* bsy_p12_0;
    Bm3 = cm3 .* bsj_p12_1 .* bsy_p12_0;
    Bm4 = cm4 .* bsj_p12_1 .* bsy_p12_0;
    Bm5 = cm6 .* bsj_p32_1 .* bsy_p12_0;
    Bm6 = cm5 .* bsj_p12_1 .* bsy_p32_0;

    % Ctm
    Nominator = Am1 + Am2 + Am3 + Am4 + Am5 + Am6;
    Denominator = -Nominator + 1i*(Bm1 + Bm2 + Bm3 + Bm4 + Bm5 + Bm6);
    Ctm = Nominator ./ Denominator;

    % Total scatter cross section (TotSCS)
    % TotSCS = 10 * log10(2*pi / abs(w * sqrt(eps0 * mu0))^2 ...
    %         * sum((2*n + 1) .* (abs(Ctm).^2 + abs(Cte).^2)));

    %% Scattering field 
    % mode (n) can be calculated by element-wise array calculation
    % theta & phi -> put into loop
    % Time complexity: O(n^2)

    % Functions used:
    %   Spherical Bessel functions in the equation:
    %       Spherical_J = sqrt(pi/2/z) .* besselj(n+1/2, z);
    %       Spherical_Y = sqrt(pi/2/z) .* bessely(n+1/2, z);
    %       Spherical_H = sqrt(pi/2/z) .* (besselj(n+1/2, z) - bessely(n+1/2, z));

    %   Spherical Legendre functions in the equation:
    %       Ye = assoc_legendre(n, 1, cos(theta)) .* sin(phi);
    %       Ym = assoc_legendre(n, 1, cos(theta)) .* cos(phi);
    %       legendre(n, x) in Matlab will return a (n+1, le)matrix  

    % Output form: (E_xx: Scattering electrical field; te -> TE mode; tm -> TM mode)
    %   E_t{e/m} (length(theta) *length(phi), 5): 
    %       E_t{e/m}(:, 1): theta
    %       E_t{e/m}(:, 2): phi
    %       E_t{e/m}(:, 3): E_r
    %       E_t{e/m}(:, 4): E_theta = sum_{n=1}^{num_mode} E_theta(n)
    %       E_t{e/m}(:, 5): E_phi = sum_{n=1}^{num_mode} E_phi(n)

    % Evaluate the number of measuring points
%     num_point = length(theta) * length(phi);
%     fprintf('Plot %d point with (d_theta, d_phi) = (%.3f, %.3f) (rad)\n', num_point, d_theta, d_phi)
    num_point = num_theta * num_phi;
    fprintf('Plot %d points with (num_theta, num_phi) = (%d, %d)\n', num_point, num_theta, num_phi)

    % Initialize output array
    E_te = zeros(num_point, 5);
    E_tm = zeros(num_point, 5);

    % Scalar coefficient (of each mode) 
    z = w * sqrt(eps0 * mu0) * r;
    cn1 = 1i.^(-n) .* (2*n+1) ./ n ./ (n+1);
    cn2 = E0 / (1i * w * sqrt(eps0 * mu0));

    % Calculate scattering electrical field of each cross section (angle)
    for i_theta = 1:length(theta)
        fprintf('Measuring cross section at Theta = %.3f\n', theta(i_theta));
        fprintf('Measuring phi = 0 ~ 2pi...\n');
        for i_phi = 1:length(phi)
%             fprintf('Measuring cross section at (Theta, Phi) = (%.3f, %.3f)\n', theta(i_theta), phi(i_phi));
            index = (i_theta-1) * length(phi) + i_phi;

            % TE mode
            E_te(index, 1) = theta(i_theta);
            E_te(index, 2) = phi(i_phi);
            E_te(index, 3) = 0;

            E_te(index, 4) = sum(-E0 / sin(theta(i_theta)) .* cn1 .* dye(n, theta(i_theta), phi(i_phi), 'phi') ...
                            .* Cte .* spherical_h(n, w * sqrt(eps0 * mu0) * r)');

            E_te(index, 5) = sum(E0 .* cn1 .* dye(n, theta(i_theta), phi(i_phi), 'theta') ...
                            .* Cte .* spherical_h(n, w * sqrt(eps0 * mu0) * r)');

            % TM mode
            ym = associate_legendre(n, 1, cos(theta(i_theta))) .* cos(phi(i_phi));
            xx = w * sqrt(eps0 * mu0) * r;
            dxsph_h = spherical_h(n, xx)' + xx * spherical_h_dx(n, xx)';

            E_tm(index, 1) = theta(i_theta);
            E_tm(index, 2) = phi(i_phi);

            E_tm(index, 3) = sum(cn2 .* n .* (n+1) .* cn1 .* ym ./ r .* Ctm ...
                            .* spherical_h(n, xx)');

            E_tm(index, 4) = sum(cn2 .* cn1 .* dym(n, theta(i_theta), phi(i_phi), 'theta') ...
                            ./ r .* Ctm .* dxsph_h);

            E_tm(index, 5) = sum(cn2 ./ sin(theta(i_theta)) .* cn1 .* dym(n, theta(i_theta), phi(i_phi), 'phi') ./ r .* Ctm ...
                            .* dxsph_h);

        end
    end
    toc
end



