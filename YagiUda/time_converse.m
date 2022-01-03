function [D, H, M, S] = time_converse(time)
    
    S = mod(time, 60);
    time = (time - S) / 60;
    M = mod(time, 60);
    time = (time - M) / 60;
    H = mod(time, 24);
    D = (time - H) / 24;
end
    