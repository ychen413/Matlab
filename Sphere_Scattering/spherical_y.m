function Y = spherical_y(n, x)
%
% Y_{nu}(x) = \sqrt{\frac{\pi}{2x}} Y_{nu+1/2}(x)
% 
% Input:
%   nu  order of the Bessel's function. Must be a column vector.
%   x   a row of complex vectors
%
    n = reshape(n, length(n), 1);
    x  = reshape(x, 1, length(x));
    a = zeros(length(n), length(x));
    for iNu = 1:length(n)
        a(iNu, :) = bessely(n(iNu)+0.5, x);
    end
    Y = sqrt(pi / 2 ./ (ones(length(n), 1) * x)) .* a;
    
%     if (sum(find(x==0))~=0)
%         disp('ric_bessely evaluated at x=0. Return -inf');
%     end
%     
%     temp2 = ones(length(n),1)*x;
%     Y(temp2==0) = -inf;
%     
%     temp1 = n*ones(1, length(x));
%     Y(temp1==0 & temp2==0) = -1;