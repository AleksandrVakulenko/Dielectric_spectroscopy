


clc


if ispc
    % NOTE: case for full test
    Aster_addr = 6;
    LCR_dev_class_name = "LCR_8230_dev";
elseif isunix
    % NOTE: case for home test
    % FIXME: (1) delete this code in release version
    Aster_addr = "/dev/ttyACM0";
    LCR_dev_class_name = "";
end




Harm_num = [3]; % NOTE: set max harm number you want to find
Time_profile = "fine"; % "ultra_fast", "common", "fine", "most_accurate"
Noisy_env = false; % NOTE: set if noise level is high

Gen_Voltage_level = 1; % [V]
DC_bias = 0.0; % [V] % NOTE: do not use
F_min = 2.5;
F_max = 200;
F_num = 5;

% F_min = 0.02;
% F_max = 0.02;
% F_num = 1;

% F_min = 0.005;
% F_max = 200;
% F_num = 80;

Freq_arr = freq_gen.td_fra(F_min, F_max, F_num);


Time_prediction_m = Aster_FRA_helper.time_prediction(Freq_arr, Time_profile);
disp(['Time prediction: ' num2str(Time_prediction_m, '%0.1f') ' min']);


Settings.gen_amp = Gen_Voltage_level;
Settings.dc_bias = DC_bias; % NOTE: do not use
Settings.freq_list = Freq_arr;
Settings.harm_num = Harm_num;
Settings.time_profile = Time_profile;
Settings.noise_env_flag = Noisy_env;




%%


Result = Measure_LCR(LCR_dev_class_name, Settings);

%%

Fig_FRA = init_FRA_figure();

Result1 = Measure_Aster(LCR_dev_class_name, Aster_addr, Settings, Fig_FRA);
Result2 = Measure_Aster(LCR_dev_class_name, Aster_addr, Settings, Fig_FRA);

save_result_file(Result1);
save_result_file(Result2);



















