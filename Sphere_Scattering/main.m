close all
clc
clear all

% Path to save file
dir_ = 'E:\Sphere_Scattering\Data\10\';

% Generate configs of data
% num_data = 100;
% eps_min = 1;    eps_max = 20;
% mu_min = 1;     mu_max = 10;
% ra_min = 0.01;   ra_max = 2;
% fn_min = 0.1;   fn_max = 3;
% 
% input_config = config_generator(num_data, ...
%                                 eps_min, eps_max, ...
%                                 mu_min, mu_max, ...
%                                 ra_min, ra_max, ...
%                                 fn_min, fn_max);
% 
% csvwrite(strcat(dir_, 'data_config.csv'), input_config);

% input_config = [10, 1, 0.1, 0.5; ...
%                 10, 1, 0.1, 2.8; ...
%                  5, 2, 0.5, 0.5];
% num_data = length(input_config(:, 1));

dir2 = strcat(dir_, 'data_config_10.csv');
input_config_ = readtable(dir2);
input_config = table2array(input_config_);
num_data = length(input_config(:, 1));
start = 1;

% Measuring & Plotting contour using each config
figC = figure;
% drawnow
t_start = tic;
for ind = start:num_data

    [E_te, E_tm] = spherical_scattering(input_config(ind, 1), ...
                              input_config(ind, 2), ...
                              input_config(ind, 3), ...
                              input_config(ind, 4));

    Es = E_te;
    Es(:, 3:5) = E_te(:, 3:5) + E_tm(:, 3:5);
    normEs = real(Es(:, 3)).^2 + imag(Es(:, 3)).^2 ...
            + real(Es(:, 4)).^2 + imag(Es(:, 4)).^2 ...
            + real(Es(:, 5)).^2 + imag(Es(:, 5)).^2;
    
    % Write data as .dat file
    dir1 = strcat(dir_, num2str(ind), '.dat');
    dlmwrite(dir1, Es, ' ');
        
    % Plot contour
    num_theta = length(unique(Es(:, 1)));
    num_phi = length(unique(Es(:, 2)));
        
    X = reshape(Es(:, 1), num_phi, num_theta);
    Y = reshape(Es(:, 2), num_phi, num_theta);
    Z = reshape(normEs, num_phi, num_theta);
    
%     contour(X, Y, Z, 50);
    surf(X, Y, Z);
    xlabel('\theta');
    ylabel('\phi');
    axis([0, pi, 0, 2*pi]);
    view(2)
    drawnow
    dir = strcat(dir_, num2str(ind));
    saveas(figC, dir, 'jpg');
end
t_end = toc(t_start);
[D, H, M, S] = time_converse(t_end);
fprintf('Total execution time is: %d D %d hr %d min %.4f sec\n', D, H, M, S);
close(figC)
