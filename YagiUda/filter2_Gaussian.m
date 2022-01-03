function fg = filter2_Gaussian(m, sigma)
    fg = zeros(m);
    k = (m - 1) / 2; 
    for x = 1:m
        for y = 1:m
            fg(y, x) = exp(-((x-k-1)^2 + (y-k-1)^2) / 2 / sigma^2) / 2 / pi / sigma^2;
        end
    end
    fg = fg / sum(fg, 'all');
end