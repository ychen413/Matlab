close all
clc
clear all

% Save Path
dir_ = 'D:\Research_USA\matlab_project\YagiUda\Data\dipole\reflector_grid\';
start = 1;

% Config
fc = 300e6;                   % Center frequency (Hz)

el_const = 0.25;             % lambda / 4 dipole antenna  
rcl_const = 3;               % Plane's length ( * lambda)
rcw_const = 3;               % Plane's width ( * lambda)
rcs_const = 1:20;              % Spacing between the plane and the antenna ( * lambda)

c = physconst('lightspeed'); % (m)
lambda = c / fc;             % Wavelength (m)
wirediameter = 12e-3;        % (m)

e = dipole;
rc = reflectorGrid;
tilt_angle = 90;

figC = figure;
t_start = tic;
for ind = start:length(rcs_const)
    % Exciter (dipole)
    e.Length = el_const * lambda;
    e.Width = cylinder2strip(wirediameter / 2);
    e.Tilt = tilt_angle;
    e.TiltAxis = [1 0 0];
    % show(e)
    % pattern(e, fc, 'Type', 'efield')

    % Reflector
    rc.Exciter = e;
    rc.GroundPlaneLength = rcl_const * lambda;
    rc.GroundPlaneWidth = rcw_const * lambda;
    rc.Spacing = rcs_const(ind) * lambda;
    rc.Tilt = 0;
    rc.TiltAxis = [1 0 0];
    % show(rc)
    % view(0, 0)

    % Radiation Pattern Plot
    [efield, az, el] = pattern(rc, fc, 'Type', 'efield');
    phi = az';
    theta = (90-el);
    MagE = efield';
    % patternCustom(MagE, theta, phi)

    % Resize MagE(73, 37) to MagE_(64, 64)
    out_size = [64, 64];
    MagE_ = imresize(MagE, out_size);

    % Plot MagE_
    [X_, Y_] = meshgrid(linspace(180, 0, out_size(1)), ...
                        linspace(180, -180, out_size(2)));

    surf(X_, Y_, MagE_);
    xlabel('\theta (polar angle)');
    ylabel('\phi (Azimuth angle)');
    axis([0, 180, -180, 180]);
    view(2)
    drawnow

    % Write data as .dat file
    dir1 = strcat(dir_, 'tilt_', num2str(tilt_angle),'_d_', num2str(rcs_const(ind)), 'lambda.dat');
    dlmwrite(dir1, MagE_, 'delimiter', ' ', 'precision', '%.4e');
end
t_end = toc(t_start);
[D, H, M, S] = time_converse(t_end);
fprintf('Total execution time is: %d D %d hr %d min %.4f sec\n', D, H, M, S);
close(figC)
