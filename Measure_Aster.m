
% FIXME: (0) rename to single_sweep()
% FIXME: (0) use single array for all measurments
% FIXME: (0) add source of result to LCR_result class
% FIXME: (0) use this source for plot line_spec

% TODO:
% 1) add master figure
% 2) give this figure slots to Aster_FRA_gui
% 3) init Aster frames on start and does not create them on second start
% 4) add a slots to every device used in experiment


function Result = Measure_Aster(LCR_dev_class_name, Aster_addr, ...
    Settings, Fig_FRA)
arguments
    LCR_dev_class_name
    Aster_addr
    Settings
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
DC_bias = Settings.dc_bias;
Freq_arr = Settings.freq_list;
Harm_num = Settings.harm_num;
Time_profile = Settings.time_profile;
Noisy_env = Settings.noise_env_flag;

% --------------------------------------------------------------




% FIXME: make it static and abstract:
% Limits = LCR_dev.get_max_amp_and_freq();
Aster_highest_freq = 200; % FIXME: get from instrument
LCR_lowest_freq = 20; % FIXME: get from instrument

F_range_Aster = Freq_arr <= Aster_highest_freq; 
F_range_LCR = Freq_arr >= LCR_lowest_freq; 

Freq_arr_Aster = Freq_arr(F_range_Aster);
Freq_arr_LCR = Freq_arr(F_range_LCR);

if ~isempty(Freq_arr_LCR)
    LCR_avilable = Aster_FRA_helper.check_LCR_avilable(LCR_type);
    if ~LCR_avilable
        warning('LCR dev unavailable'); % FIXME: disp
    end
else
    % USED is flag what we dont need an LCR measurments
    LCR_avilable = false; 
end


% NOTE: run LCR first if possible
Result_arr_LCR = Aster_FRA.LCR_result_type.empty;
if LCR_avilable
    Aster_FRA.switch_to_LCR(Aster_addr);
   
    N = numel(Freq_arr_LCR);
    for i = 1:N
        disp([newline 'LCR freq list: ' num2str(i) '/' num2str(N)]); % FIXME: disp

        Gen_freq = Freq_arr_LCR(i);
        LCR_Result = Aster_FRA.LCR_measure(LCR_type, Gen_freq, Gen_Voltage_level, Time_profile);
        LCR_Result.freq = Gen_freq;
        Result_arr_LCR = [Result_arr_LCR LCR_Result];
        % FIXME: (0) add plot
    end
end

% NOTE: terminate LCR
if LCR_avilable
    Aster_FRA_helper.LCR_terminate(LCR_type);
end




% NOTE: run GUI
Fig = TDFRA_fit_gui.init_Aster_FRA_gui();
Ax_arr = [Fig.UserData.axes_top Fig.UserData.axes_bot];
Stop_button = Fig.UserData.stop_button;
Resources.stop_button = Stop_button;
Resources.underrange_ind = Fig.UserData.underrange_ind;
Resources.range_ind = Fig.UserData.range_ind;
% FIXME: (1) place Ax_arr to Resourses


% NOTE: do not do pre measurments if LCR results avilable in freq range
%   in range from 20 Hz to 200 Hz
flag = Aster_FRA_helper.is_LCR_results_valid_as_pre(Result_arr_LCR);
if ~flag
    disp(['RUN PRE MEASURMENTS' newline]) % FIXME: disp
    Results_arr_PRE = Aster_FRA.pre_measurment(Resources, Aster_addr, ...
        Gen_Voltage_level, Ax_arr);
    disp(['PRE MEASURMENTS FINISH' newline]) % FIXME: disp
else
    Results_arr_PRE = Result_arr_LCR;
end



Time_prediction_m = Aster_FRA_helper.time_prediction(Freq_arr, Time_profile);
disp(['Time prediction: ' num2str(Time_prediction_m, '%0.1f') ' min']); % FIXME: disp

Timer_Aster_Part = tic;
Result_arr_Aster = Aster_FRA.LCR_result_type.empty;
Extra_data_arr = Aster_FRA.LCR_extra_data_type.empty;
N = numel(Freq_arr_Aster);
for i = 1:N
    disp([newline 'Aster freq list: ' num2str(i) '/' num2str(N)]); % FIXME: disp

    Gen_freq = Freq_arr_Aster(i);
%     Gen_Voltage_level = Voltage_amp_arr(i);

    Zmodel = Aster_FRA.LCR_res_to_Zmodel(Result_arr_Aster, Results_arr_PRE);
    Z_est = struct('type', 'res', 'value', Zmodel(Gen_freq));

    Fixed_range = [];
    [Fit_Result, Extra_data] = Aster_FRA.single_freq_measurment(Resources, Aster_addr, ...
        Gen_freq, Gen_Voltage_level, DC_bias, Harm_num, Z_est, Time_profile, ...
        Ax_arr, Fixed_range, false, Noisy_env);
    if ~isempty(Fit_Result) && Aster_FRA.FRA_results_check_valid(Fit_Result)
        Fit_Result.freq = Gen_freq;
        Result_arr_Aster = [Result_arr_Aster Fit_Result];
        Extra_data_arr = [Extra_data_arr Extra_data];
        plot_fra_data(Fig_FRA, Result_arr_Aster);
    end

    % FIXME: it is bad in shuffled freq array
end

% FIXME: debug section
Full_time = toc(Timer_Aster_Part);
Time_to_compare = 2./Freq_arr_Aster;
Time_to_compare(Time_to_compare < 1) = 1;
Time_to_compare = sum(Time_to_compare);
disp(['Full time: ' num2str(Full_time/60, '%0.1f') ' min | NC_time ~ ' ...
    num2str(Time_to_compare/60, '%0.1f') ' min | ratio = ' ...
    num2str(Full_time/Time_to_compare, '%0.1f') ])
disp(['Time prediction: ' num2str(Time_prediction_m, '%0.1f') ' min']);



disp('Finish')

close(Fig);
% --------------------------------------------------------------

Result = [Result_arr_LCR Result_arr_Aster];
% FIXME: (0) return Extra_data_arr

end

