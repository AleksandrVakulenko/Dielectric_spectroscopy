
% NOTE: run once after every Matlab startup
Fern.load('Aster_FRA');


%%
clc

LCR_dev_GPIB_num = 7;
LCR_dev_class_name = "LCR_8230_dev";

% NOTE: try different options
Time_profile = "common"; % "ultra_fast", "common", "fine", "most_accurate"

Gen_Voltage_level = 1; % [V]
F_min = 10; % [Hz]
F_max = 1e6;
F_num = 50;


Freq_arr = freq_gen.td_fra(F_min, F_max, F_num);



Settings.gen_amp = Gen_Voltage_level;
Settings.time_profile = Time_profile;
Settings.freq_list = Freq_arr;
Settings.dc_bias = 0; % NOTE: do not use
Settings.harm_num = 1; % NOTE: do not use
Settings.noise_env_flag = false; % NOTE: do not use


Fig_FRA = init_FRA_figure();
Result = Measure_LCR(LCR_dev_class_name, Settings, LCR_dev_GPIB_num);

save_result_file(Result);











