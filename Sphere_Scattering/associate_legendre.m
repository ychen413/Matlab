function P = associate_legendre(n, m, x)
    % legendre(n, x) will return a (n+1, length(x)) matrix contains all
    % values with different m
    %
    % Input:
    %   n -> mode (degree), can be a vector
    %   m -> the order of legendre
    %   x -> input values, -1 <= x <= 1, can be a vector 
    %
    % Output:
    %   P -> (length(x), length(n)) associate_legendre of each n of each x
    %   (if x is a vector)
    
    P = zeros(length(x), length(n));
    for iter = 1:length(n)
        a = legendre(n(iter), x);
        P(:, iter) = a(m+1, :);
    end
end