function J = spherical_j(n, x)
% 
% J_{nu}(x) = \sqrt{\frac{\pi }{2x}} J_{nu+1/2}(x)
% 
% Input:
%   nu  order of the Bessel function. Must be a column vector.
%   x   a row of complex vectors
%
    n = reshape(n, length(n), 1); % impose to be a column vector
    x  = reshape(x, 1, length(x)); % impose x to be a row vector
    
    a = zeros(length(n), length(x));
    for iNu = 1:length(n)
        a(iNu, :) = besselj(n(iNu)+0.5, x);
    end
    
    J = sqrt(pi / 2 ./ (ones(length(n), 1) * x)) .* a;
    