

function Result = Measure_LCR(LCR_dev_class_name, Settings, Fig_FRA)
arguments
    LCR_dev_class_name string
    Settings % FIXME: (0) type
    Fig_FRA = []
end

if isempty(LCR_dev_class_name) || LCR_dev_class_name == ""
    LCR_type = Aster_FRA_helper.LCR_device_name_type.empty;
elseif LCR_dev_class_name == "LCR_8230_dev"
    LCR_type = Aster_FRA_helper.LCR_device_name_type(LCR_dev_class_name, []);
else
    error('LCR_dev_class_name: wrong value.');
end


Gen_Voltage_level = Settings.gen_amp;
DC_bias = Settings.dc_bias; % FIXME: unused
Freq_arr = Settings.freq_list;
Harm_num = Settings.harm_num; % FIXME: unused
Time_profile = Settings.time_profile;
Noisy_env = Settings.noise_env_flag; % FIXME: unused



LCR_lowest_freq = 20; % FIXME: (0) get from instrument

F_range_LCR = Freq_arr >= LCR_lowest_freq; 

Freq_arr_LCR = Freq_arr(F_range_LCR);


if isempty(Freq_arr_LCR)
    Result = Aster_FRA.LCR_result_type.empty;
    return;
end


LCR_avilable = Aster_FRA_helper.check_LCR_avilable(LCR_type);
if ~LCR_avilable
    warning('LCR dev unavailable'); % FIXME: disp
    Result = Aster_FRA.LCR_result_type.empty;
    return;
end


% FIXME: (0) init LCR here and do loop whitout reconnect

Result = Aster_FRA.LCR_result_type.empty;
N = numel(Freq_arr_LCR);
for i = 1:N
    disp([newline 'LCR freq list: ' num2str(i) '/' num2str(N)]); % FIXME: disp

    Gen_freq = Freq_arr_LCR(i);
    LCR_Result = Aster_FRA.LCR_measure(LCR_type, Gen_freq, ...
        Gen_Voltage_level, Time_profile);
    LCR_Result.freq = Gen_freq;
    Result = [Result LCR_Result];
    plot_fra_data(Fig_FRA, Result);
end


Aster_FRA_helper.LCR_terminate(LCR_type);


end