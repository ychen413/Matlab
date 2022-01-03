close all
clc
clear all

% Plot figure (if needed)

% Path to read file (.dat)
dir_ = 'D:\PhD_Research\Code_matlab\Sphere_Scattering\Data\03\';

f_path = strcat(dir_, '1', '.dat');
delimiter = ' ';
Es = dlmread(f_path, delimiter);

% Plot contour
    num_theta = length(unique(Es(:, 1)));
    num_phi = length(unique(Es(:, 2)));
    
    normEs = real(Es(:, 3)).^2 + imag(Es(:, 3)).^2 ...
            + real(Es(:, 4)).^2 + imag(Es(:, 4)).^2 ...
            + real(Es(:, 5)).^2 + imag(Es(:, 5)).^2;
    
    X = reshape(Es(:, 1), num_phi, num_theta);
    Y = reshape(Es(:, 2), num_phi, num_theta);
    Z = reshape(normEs, num_phi, num_theta);
    
    contour(X, Y, Z, 50);
    xlabel('\theta');
    ylabel('\phi');
    drawnow
%     dir = strcat(dir_, num2str(ind));
%     saveas(figC, dir, 'jpg');

