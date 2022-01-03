function D = associate_legendre_dx(n, m, x)
    %
    % Input:
    %   n -> mode (degree), can be a vector
    %   m -> the order of legendre
    %   x -> input values, -1 <= x <= 1, can be a vector 
    %
    % Output:
    %   D -> (length(x), length(n)) derivative of associate_legendre of
    %   each n of each x (if x is a vector)
    
    D = zeros(length(x), length(n));
    for iter = 1:length(n)
        a = legendre_derivative(n(iter), x);
        a = reshape(a, [n(iter)+1, length(x)]);
        D(:, iter) = a(m+1, :);
    end
end