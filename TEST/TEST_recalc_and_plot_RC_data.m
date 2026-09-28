
% LOAD

Folder = 'TEST_data';

% NOTE: uncomment any filename
Filename = 'test_data_RC.mat';
% Filename = 'test_data_CAP_10p.mat';
% Filename = 'test_data_CAP_100n.mat';

% NOTE: change limit value and look on result
Limit = 10; % [%]

Result = data_operation.open_result_file(Filename, Folder);


% CALC
Freq_arr = [Result.freq];
Res_arr = [Result.res_abs];
Res_err_arr = [Result.res_abs_err];
Phi_arr = [Result.phi];
Phi_err_arr = [Result.phi_err];
Source_arr = [Result.source];

Cap_par_arr = [];
Cap_par_err_arr = [];
Res_par_arr = [];
Res_par_err_arr = [];
for i = 1:numel(Freq_arr)

    [Cap_par, Res_par, Cap_par_err, Res_par_err] = ...
        data_conversion.RC_calc(Res_arr(i), Res_err_arr(i), ...
        Phi_arr(i), Phi_err_arr(i), Freq_arr(i), "parallel");

    Cap_par_arr = [Cap_par_arr Cap_par];
    Cap_par_err_arr = [Cap_par_err_arr Cap_par_err];
    Res_par_arr = [Res_par_arr Res_par];
    Res_par_err_arr = [Res_par_err_arr Res_par_err];

end


Cap_err_rel = abs(Cap_par_err_arr./Cap_par_arr)*100; % [%]
Res_err_rel = abs(Res_par_err_arr./Res_par_arr)*100; % [%]

Cap_par_err_arr(Cap_err_rel > Limit) = NaN;
Res_par_err_arr(Res_err_rel > Limit) = NaN;



% PLOT

Fig = gui.init_FRA_figure;
Ax_arr = Fig.UserData.ax_arr;
Ax1 = Ax_arr(1);
Ax2 = Ax_arr(2);

errorbar(Freq_arr, Cap_par_arr*1e9, Cap_par_err_arr*1e9, '-r', 'Parent', Ax1);
ylabel('C_p_a_r, nF', 'Parent', Ax1)
set(Ax1, 'xscale', 'log')

errorbar(Freq_arr, Res_par_arr/1e3, Res_par_err_arr/1e3, '-r', 'Parent', Ax2);
ylabel('R_p_a_r, kOhm', 'Parent', Ax2);
set(Ax2, 'xscale', 'log')



