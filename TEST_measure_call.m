


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
Time_profile = "ultra_fast"; % "ultra_fast", "common", "fine", "most_accurate"
Noisy_env = false; % NOTE: set if noise level is high

Gen_Voltage_level = 1; % [V]
DC_bias = 0.0; % [V] % NOTE: do not use
F_min = 0.01;
F_max = 200;
F_num = 60;

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


Always_save_extra_data = true;

%%


Result = Measure_LCR(LCR_dev_class_name, Settings);

%%

% FIMXE: (0) add flag to save all Extra_data
% FIXME: (0) add Extra data to save function
full_timer = tic;
Fig_FRA = init_FRA_figure();

[Result1, Extra_data_1] = Measure_Aster(LCR_dev_class_name, ...
    Aster_addr, Settings, Fig_FRA, Always_save_extra_data);
% [Result2, Extra_data_2] = Measure_Aster(LCR_dev_class_name, Aster_addr, ...
%     Settings, Fig_FRA);

save_result_file(Result1);
save("Extra_data.mat", "Extra_data_1"); % FIXME
% save_result_file(Result2);
Full_time = toc(full_timer);, Always_save_extra_data
disp([newline num2str(Full_time/60, '%.1f') ' min']);
disp('Time prediction: 202.9 min')

%%

s = whos("Extra_data_1");
Size = s.bytes/1024/1024;
disp(['Size = ' num2str(Size, '%0.2f'), ' Mb'])












