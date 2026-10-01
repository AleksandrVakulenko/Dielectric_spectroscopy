
% NOTE: test for RC_calc and calc_reverse

% NOTE: set Freq to 1 or 10000 Hz to get NaN in errors

clc

Cap = 100e-9; % [F]
Res = 15e3; % [Ohm]
Freq = 10000; % [Hz]
Circuit = "parallel"; % "series" OR "parallel"

[Z_abs, Phi] = data_conversion.RC_calc_reverse(Cap, Res, Freq, Circuit)

Z_abs_err = 0.01*Z_abs;
Phi_err = 0.21; % [deg]

% Z_abs_err = 0.01*Z_abs;
% Phi_err = 0.2; % [deg]

[C, R, C_err, R_err] = data_conversion.RC_calc(Z_abs, Z_abs_err, Phi, ...
    Phi_err, Freq, Circuit);

Cap_err_rel = abs(C_err/C)*100; % [%]
Res_err_rel = abs(R_err/R)*100; % [%]

Limit = 20;

if ~isnan(Cap_err_rel) && Cap_err_rel > Limit
    Cap_err_rel = NaN;
end

if ~isnan(Res_err_rel) && Res_err_rel > Limit
    Res_err_rel = NaN;
end

disp(['C = ' num2str(C*1e9, '%.2f') ' nF'])
disp(['Ce = ' num2str(C_err*1e9, '%.2f') ' nF'])
disp(['Ce_rel = ' num2str(Cap_err_rel, '%.1f') ' %'])
disp(' ')
disp(['R = ' num2str(R, '%.2f') ' Ohm'])
disp(['Re = ' num2str(R_err, '%.2f') ' Ohm'])
disp(['Re_rel = ' num2str(Res_err_rel, '%.1f') ' %'])


