function H = spherical_h(n, x)
% 2nd Hankel function
% H_{nu}(x) = \sqrt{\frac{\pi}{2x}} (J_{nu+1/2}(x) - iY_{nu+1/2}{x})
%
% Input:
%   nu  order of the spherical Bessel's function. Must be a column vector.
%    x   Must be a row vector.
%
    H = spherical_j(n, x) - 1i * spherical_y(n, x);
   
    