close all
clc
clear all

% Show result

dir_ = 'D:\Research_USA\matlab_project\YagiUda\results_YagiUda\';
epoch = 100;
best = 1;

%% Plot Antenna Structure
% c_path = strcat(dir_, 'data_config_01.csv');
% input_config_ = readtable(c_path);
% input_config = table2array(input_config_);
% const_el = input_config(ind, 1);
% num_d    = input_config(ind, 2);
% const_dl = input_config(ind, 3);
% const_ds = input_config(ind, 4);
% const_rl = input_config(ind, 5);
% const_rs = input_config(ind, 6);
% 
% wirediameter = 12e-3;        % (m)
% c = physconst('lightspeed'); % (m)
% fc = 300e6;                  % Center frequency (Hz)
% lambda = c / fc;             % Wavelength (m)
% 
% e = dipole;
% e.Length = const_el * lambda / 2;
% e.Width = cylinder2strip(wirediameter / 2);
% e.Tilt = 90; % deg
% e.TiltAxis = 'Y';
% 
% y = yagiUda;
% y.Exciter = e;
% y.NumDirectors = num_d;
% y.ReflectorLength = const_rl * lambda / 2;
% y.DirectorLength = const_dl * lambda / 2;
% y.ReflectorSpacing = const_rs * lambda;
% y.DirectorSpacing = const_ds * lambda;
% figure();
% show(y);

%% Plot Radiation Pattern
% f_path = strcat(dir_, num2str(ind), '.dat');
f_path = strcat(dir_, 'epoch', num2str(epoch), '_best', num2str(best), '.dat');

delimiter = '\t';
MagE = dlmread(f_path, delimiter);

fg = filter2_Gaussian(7, 0.8);
MagE_ = conv2(MagE, fg, 'same'); 

num_theta = 64; num_phi = 64;
theta = linspace(180, 0, num_theta);
phi = linspace(180, -180, num_phi);

figure()
% subplot(2, 2, 1), patternCustom(MagE, theta, phi);

[X, Y] = meshgrid(theta, phi);
% Z = reshape(normEs, num_phi, num_theta);

% figure()
subplot(2, 2, 1), surf(X, Y, MagE);
xlabel('\theta');
ylabel('\phi');
axis([0, 180, -180, 180]);
xticks([0 45 90 135 180])
xticklabels({'0', '\pi/4', '\pi/2', '3\pi/4', '\pi'})
yticks([-180 -90 0 90 180])
yticklabels({'-\pi', '-\pi/2', '0', '\pi/2', '\pi'})
view(2)
drawnow

% figure()
subplot(2, 2, 2), contour(X, Y, MagE, 30);
xlabel('\theta');
ylabel('\phi');
axis([0, 180, -180, 180]);
xticks([0 45 90 135 180])
xticklabels({'0', '\pi/4', '\pi/2', '3\pi/4', '\pi'})
yticks([-180 -90 0 90 180])
yticklabels({'-\pi', '-\pi/2', '0', '\pi/2', '\pi'})
view(2)
drawnow

% figure()
subplot(2, 2, 3), surf(X, Y, MagE_);
xlabel('\theta');
ylabel('\phi');
axis([0, 180, -180, 180]);
xticks([0 45 90 135 180])
xticklabels({'0', '\pi/4', '\pi/2', '3\pi/4', '\pi'})
yticks([-180 -90 0 90 180])
yticklabels({'-\pi', '-\pi/2', '0', '\pi/2', '\pi'})
view(2)
drawnow

% figure()
subplot(2, 2, 4), contour(X, Y, MagE_, 30);
xlabel('\theta');
ylabel('\phi');
axis([0, 180, -180, 180]);
xticks([0 45 90 135 180])
xticklabels({'0', '\pi/4', '\pi/2', '3\pi/4', '\pi'})
yticks([-180 -90 0 90 180])
yticklabels({'-\pi', '-\pi/2', '0', '\pi/2', '\pi'})
view(2)
drawnow
