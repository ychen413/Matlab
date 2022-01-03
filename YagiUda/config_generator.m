function conf = config_generator(num_input, e_len, ...
                                 d_num, d_len, d_spa, ...
                                 r_len, r_spa)
    % Generate random input configurations (within a range [min, max])
    % Input:
    %   num_input                     : Number of data generated
    %   e_len = [el_min, el_max]      : Range of the exciter's length
    %   d_num = [num_d_min, num_d_max]: Range of directors' amount
    %   d_len = [dl_min, dl_max]      : Range of directors' length
    %   d_spa = [ds_min, ds_max]      : Range of spacing between directors
    %   r_len = [rl_min, rl_max]      : Range of the reflector's length
    %   r_spa = [rs_min, rs_max]      : Range of spacing between the exciter and the reflector
    %   **Actual length = len * (lambda / 2)
    %   **Actual space  = spa * lambda
    %
    % Output:
    %   conf = [el, num_d, dl, ds, rl, rs] (num_data, 6)
    %     
    % Example:
    %   num_data = 4;
    %   e_len = [0.95, 1.01];
    %   d_num = [3, 7];
    %   d_len = [0.5, 0.95];
    %   d_spa = [0.3, 0.6];
    %   r_len = [1, 1.2];
    %   r_spa = [0.2, 0.5];
    %   test0 = config_generator(num_data, e_len, d_num, d_len, d_spa, ...
    %                           r_len, r_spa)
    
    el = e_len(1) + (e_len(2) - e_len(1)) * rand(num_input, 1);
    num_d = randi(d_num, num_input, 1);
    dl = d_len(1) + (d_len(2) - d_len(1)) * rand(num_input, 1);
    ds = d_spa(1) + (d_spa(2) - d_spa(1)) * rand(num_input, 1);
    rl = r_len(1) + (r_len(2) - r_len(1)) * rand(num_input, 1);
    rs = r_spa(1) + (r_spa(2) - r_spa(1)) * rand(num_input, 1);
    
    conf = [el, num_d, dl, ds, rl, rs];
end

