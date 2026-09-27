


clc


if ispc
    % NOTE: case for full test
    Aster_addr = 6;
    LCR_dev_class_name = "LCR_8230_dev";
    LCR_dev_GPIB_num = 7;
elseif isunix
    % NOTE: case for home linux test
    Aster_addr = "/dev/ttyACM0";
    LCR_dev_class_name = "";
    LCR_dev_GPIB_num = [];
end




Harm_num = [1]; % NOTE: set max harm number you want to find
Time_profile = "common"; % "ultra_fast", "common", "fine", "most_accurate"
Noisy_env = false; % NOTE: set if noise level is high

Gen_Voltage_level = 1; % [V]
DC_bias = 0.0; % [V] % NOTE: do not use
F_min = 0.005;
F_max = 200;
F_num = 160;

% F_min = 0.2;
% F_max = 0.2;
% F_num = 1;

% F_min = 0.005;
% F_max = 200;
% F_num = 80;

Freq_arr = freq_gen.td_fra(F_min, F_max, F_num);
numel(Freq_arr)

Scale = 1.13;
Time_prediction_m = Scale * Aster_FRA_helper.time_prediction(Freq_arr, Time_profile);
disp(['Time prediction: ' num2str(Time_prediction_m, '%0.1f') ' min']);


Settings.gen_amp = Gen_Voltage_level;
Settings.dc_bias = DC_bias; % NOTE: do not use
Settings.freq_list = Freq_arr;
Settings.harm_num = Harm_num;
Settings.time_profile = Time_profile;
Settings.noise_env_flag = Noisy_env;


Always_save_extra_data = true;

%% LCR only


Fig_FRA = gui.init_FRA_figure();
Result = Measure.LCR_alone(LCR_dev_class_name, Settings, LCR_dev_GPIB_num, Fig_FRA);

%%

full_timer = tic;
Fig_FRA = gui.init_FRA_figure();

[Result1, Extra_data_1] = Measure.single_sweep(LCR_dev_class_name, ...
    Aster_addr, Settings, Fig_FRA, Always_save_extra_data);

data_operation.save_result_file(Result1, Extra_data_1);

Full_time = toc(full_timer);
disp([newline num2str(Full_time/60, '%.1f') ' min']);
disp(['Time prediction: ' num2str(Time_prediction_m, '%.1f') ' min'])

%%

s = whos("Extra_data_1");
Size = s.bytes/1024/1024;
disp(['Size = ' num2str(Size, '%0.2f'), ' Mb'])












