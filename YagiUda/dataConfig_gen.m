close all
clc
clear all

% Parameter of generated config
%   **Actual length = len * (lambda / 2)
%   **Actual space  = spa * lambda
num_data = 1000;
e_len = [0.8, 1.2];
d_num = [3, 7];
d_len = [0.3, 1];
d_spa = [0.1, 0.5];
r_len = [1, 1.6];
r_spa = [0.1, 0.5];

% Generate 
config = config_generator(num_data, e_len, d_num, d_len, d_spa, r_len, r_spa);

% Write data as .dat file
dir_ = 'D:\Research_USA\matlab_project\YagiUda\Data\yagiUda_02\';
csvwrite(strcat(dir_, 'data_config_02.csv'), config);


