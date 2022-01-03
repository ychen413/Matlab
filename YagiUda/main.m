close all
clc
clear all

%% Load Config
dir_ = 'D:\Research_USA\matlab_project\YagiUda\Data\yagiUda_02\';
dir2 = strcat(dir_, 'data_config_02.csv');
input_config_ = readtable(dir2);
input_config = table2array(input_config_);
num_data = length(input_config(:, 1));
start = 1;

%% Parameters
% Generate 2D radiation pattern plot of Yagi-Uda antennas
%
% Config:
%   General:
%      fc: Central frequency (Hz)
%      wirediameter: Calculate the width of the exciter
%
%   Antenna: y -> yagiUda
%   Exciter: y.exciter -> e
%      default -> dipole
%      e.Length = const_el * (lambda / 2)
%           const_el >~ const_dl
%   Directors:
%      y.NumDirectors = num_d;
%      y.DirectorLength = const_dl * (lambda / 2);
%           const_dl(num_d, ) <~ 1
%      y.DirectorSpacing = const_ds * lambda;
%           [1 : (num_d - 1)]: Spacing between directors
%           [num_d]: Exciter to the last dipole spacing
%           const_ds(num_d, ) <~ 0.5
%   Reflector:
%      y.ReflectorLength = const_rl * (lambda / 2)
%           const_rl >~ 1
%      y.ReflectorSpacing = const_rs * lambda
%           Reflector to exciter spacing
%           const_rs <~ 0.5
wirediameter = 12e-3;        % (m)
c = physconst('lightspeed'); % (m)

fc = 300e6;                  % Center frequency (Hz)
lambda = c / fc;             % Wavelength (m)

e = dipole;
e.Width = cylinder2strip(wirediameter / 2);
e.Tilt = 90; % deg
e.TiltAxis = 'Y';

figC = figure;
t_start = tic;
for ind = start:num_data

    const_el = input_config(ind, 1);
    num_d    = input_config(ind, 2);
    const_dl = input_config(ind, 3);
    const_ds = input_config(ind, 4);
    const_rl = input_config(ind, 5);
    const_rs = input_config(ind, 6);

    %% Antenna Design
    % Exciter
    e.Length = const_el * lambda / 2;
 
    % Antenna
    y = yagiUda;
    y.Exciter = e;
    y.NumDirectors = num_d;
    y.ReflectorLength = const_rl * lambda / 2;
    y.DirectorLength = const_dl * lambda / 2;
    y.ReflectorSpacing = const_rs * lambda;
    y.DirectorSpacing = const_ds * lambda;
    % show(y)

    % fig1 = figure;
    % pattern(yagidesign,fc);

    %% Radiation Pattern Plot
%     pattern(y, fc, 'Type', 'efield')
    [efield, az, el] = pattern(y, fc, 'Type', 'efield');
    phi = az';
    theta = (90-el);
    MagE = efield';
    % patternCustom(MagE, theta, phi)

    % [X, Y] = meshgrid(theta, phi);
    % Plot Contour
    % figure;
    % contour(X, Y, MagE, 50);
    % xlabel('\theta (polar angle)');
    % ylabel('\phi (Azimuth angle)');
    % axis([0, 180, -180, 180]);

    % Plot Intensity
    % figure;
    % surf(X, Y, MagE);
    % xlabel('\theta (polar angle)');
    % ylabel('\phi (Azimuth angle)');
    % axis([0, 180, -180, 180]);
    % view(2)
    % drawnow

    % Resize MagE(73, 37) to MagE_(64, 64)
    out_size = [64, 64];
    MagE_ = imresize(MagE, out_size);

    % Plot MagE_
    [X_, Y_] = meshgrid(linspace(180, 0, out_size(1)), ...
                        linspace(180, -180, out_size(2)));

%     figure;
    surf(X_, Y_, MagE_);
    title(num2str(ind));
    xlabel('\theta (polar angle)');
    ylabel('\phi (Azimuth angle)');
    axis([0, 180, -180, 180]);
    xticks([0 45 90 135 180]);
    xticklabels({'0', '\pi/4', '\pi/2', '3\pi/4', '\pi'});
    yticks([-180 -90 0 90 180]);
    yticklabels({'-\pi', '-\pi/2', '0', '\pi/2', '\pi'});
    view(2)
    drawnow

    %% Write data as .dat file
    dir1 = strcat(dir_, num2str(ind), '.dat');
    dlmwrite(dir1, MagE_, 'delimiter', ' ', 'precision', '%.4e');
end
t_end = toc(t_start);
[D, H, M, S] = time_converse(t_end);
fprintf('Total execution time is: %d D %d hr %d min %.4f sec\n', D, H, M, S);
close(figC)
