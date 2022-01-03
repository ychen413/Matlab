close all
clc
clear all

% Show result

dir_result = 'D:\PhD_Research\Code_matlab\Sphere_Scattering\SphScatter_Result\';
f_path = strcat(dir_result, 'results_normalize_01\', 'epoch1000_best1.dat');

% dir_data = 'D:\PhD_Research\Code_matlab\Sphere_Scattering\Data\Es_64array\';
% f_path = strcat(dir_data, '04\238.dat');

delimiter = '\t';
normEs = dlmread(f_path, delimiter);

num_theta = 64; num_phi = 64;
theta = linspace(1e-4, pi-1e-4, num_theta);
phi = linspace(0, 2*pi, num_phi);

[X, Y] = meshgrid(theta, phi);
% Z = reshape(normEs, num_phi, num_theta);

figure()
% contour(X, Y, normEs, 30);
surf(X, Y, normEs);
xlabel('\theta');
ylabel('\phi');
axis([0, pi, 0, 2*pi]);
view(2)
drawnow

figure()
contour(X, Y, normEs, 30);
% surf(X, Y, normEs);
xlabel('\theta');
ylabel('\phi');
axis([0, pi, 0, 2*pi]);
view(2)
drawnow

% Es_n = (normEs - mean(normEs(:))) ./ std(normEs(:));
% figure()
% % contour(X, Y, normEs, 50);
% surf(X, Y, Es_n);
% xlabel('\theta');
% ylabel('\phi');
% view(2)
% drawnow