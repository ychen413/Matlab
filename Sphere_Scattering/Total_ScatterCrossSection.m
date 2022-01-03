close all
clc
clear all

% Set constant
c = 3e8;
eps0 = 8.85e-12;
mu0 = pi * 4e-7;

% Set parameters
f0 = 1e9;
eps1 = 10;
mu1 = 1;
a = c / f0 / 10;

n = 1:6; % #mode
% fn = 3;

fn = linspace(0.5, 3, 100);
TotSCS = zeros(1, length(fn));
for iter = 1:length(fn)
    f = fn(iter) * f0;
    w = 2 * pi * f;
    
    % Simplify unit
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


    % Cte
    ct1 = a * eps0 * eps1 * mu0 * mu1 * (eps1 * mu1)^(1/4) * w;
    ct2 = -a * eps0 * mu0 * mu1 * (eps1 * mu1)^(3/4) * w;
    ct3 = -sqrt(eps0 * mu0) * mu1 * (eps1 * mu1)^(3/4);
    ct4 = (eps1 * mu1)^(1/4) * sqrt(eps0 * eps1 * mu0 * mu1);
    ct5 = a * eps0 * mu0 * mu1 * (eps1 * mu1)^(3/4) * w;
    ct6 = -a * eps0 * eps1 * mu0 * mu1 * (eps1 * mu1)^(1/4) * w;

    % real part
    At1 = ct1 .* bsj_n12_1 .* bsj_p12_0;
    At2 = ct2 .* bsj_n12_0 .* bsj_p12_1;
    At3 = ct3 .* bsj_p12_0 .* bsj_p12_1;
    At4 = ct4 .* bsj_p12_0 .* bsj_p12_1;
    At5 = ct5 .* bsj_p12_1 .* bsj_p32_0;
    At6 = ct6 .* bsj_p12_0 .* bsj_p32_1;

    % imaginary part
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

    % Ctm
    cm1 = a * eps0 * eps1 * mu0 * mu1 * (eps1 * mu1)^(3/4) * w;
    cm2 = -a * eps0 * eps1^2 * mu0 * mu1 * (eps1 * mu1)^(1/4) * w;
    cm3 = -eps1^2 * sqrt(eps0 * mu0) * mu1 * (eps1 * mu1)^(1/4);
    cm4 = (eps1 * mu1)^(3/4) * sqrt(eps0 * eps1 * mu0 * mu1);
    cm5 = a * eps0 * eps1^2 * mu0 * mu1 * (eps1 * mu1)^(1/4) * w;
    cm6 = -a * eps0 * eps1 * mu0 * mu1 * (eps1 * mu1)^(3/4) * w;

    % real part
    Am1 = cm1 .* bsj_n12_1 .* bsj_p12_0;
    Am2 = cm2 .* bsj_n12_0 .* bsj_p12_1;
    Am3 = cm3 .* bsj_p12_0 .* bsj_p12_1;
    Am4 = cm4 .* bsj_p12_0 .* bsj_p12_1;
    Am5 = cm5 .* bsj_p12_1 .* bsj_p32_0;
    Am6 = cm6 .* bsj_p12_0 .* bsj_p32_1;

    % imaginary part
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

    %
    term = sum((2*n + 1) .* (abs(Ctm).^2 + abs(Cte).^2));
    
    TotSCS(iter) = 10 * log10(2*pi / abs(w * sqrt(eps0 * mu0))^2 ...
        .* sum((2*n + 1) .* (abs(Ctm).^2 + abs(Cte).^2)));
end

figure(1)
plot(fn, TotSCS);

%% Scattering field 
% Set parameters
E0 = 1;
r = 100;
theta = 0:0.01:pi;
phi = 0:0.01:2*pi;

z = w * sqrt(eps0 * mu0) * r;

% Simplify unit
% Spherical_J = sqrt(pi/2/z) .* besselj(n+1/2, z);
% Spherical_Y = sqrt(pi/2/z) .* bessely(n+1/2, z);
Spherical_H = sqrt(pi/2/z) .* (besselj(n+1/2, z) - bessely(n+1/2, z));

% theta & phi -> put into loop
% Ye = assoc_legendre(n, 1, cos(theta)) .* sin(phi);
% Ym = assoc_legendre(n, 1, cos(theta)) .* cos(phi);
% legendre(n, x) in Matlab will return a (n+1, le)matrix  


