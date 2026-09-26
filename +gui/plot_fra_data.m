


function plot_fra_data(Fig_FRA, Result)

if isempty(Fig_FRA) || ~isvalid(Fig_FRA)
    return
end

Ax_arr = Fig_FRA.UserData.ax_arr;
Ax1 = Ax_arr(1);
Ax2 = Ax_arr(2);

if isempty(Ax1) || ~isvalid(Ax1) || isempty(Ax2) || ~isvalid(Ax2)
    return
end



Line_spec_Aster = '.r';
Line_spec_LCR = '.b';
Line_spec_Other = '.b';


Freq_arr = [Result.freq];
Res_arr = [Result.res_abs];
Res_err_arr = [Result.res_abs_err];
Phi_arr = [Result.phi];
Phi_err_arr = [Result.phi_err];
Source_arr = [Result.source];

Aster_range = Source_arr == "Aster_FRA";
LCR_range = Source_arr == "LCR";
Other_range = ~(Aster_range | LCR_range);

% NOTE: calc cap
Cap_arr = 1./(2*pi*Res_arr.*Freq_arr);
Cap_arr_err = -1./(2*pi*Res_arr.^2.*Freq_arr).*Res_err_arr;


cla(Ax1);
cla(Ax2);

% PLOT 1

Y_plot_v = Cap_arr*1e12; % Res_Aster
Y_plot_err = Cap_arr_err*1e12; % Res_err_Aster

errorbar(Freq_arr(Aster_range), Y_plot_v(Aster_range), ...
    Y_plot_err(Aster_range), Line_spec_Aster, 'Parent', Ax1);
errorbar(Freq_arr(LCR_range), Y_plot_v(LCR_range), ...
    Y_plot_err(LCR_range), Line_spec_LCR, 'Parent', Ax1);
errorbar(Freq_arr(Other_range), Y_plot_v(Other_range), ...
    Y_plot_err(Other_range), Line_spec_Other, 'Parent', Ax1);

ylabel('|Cap|, pF', 'Parent', Ax1)
% ylabel('|R|, Ohm', 'Parent', Ax1) % FIXME: COMMENT

set(Ax1, 'xscale', 'log')
% set(Ax1, 'yscale', 'log') % FIXME: COMMENT


% PLOT 2

Y_plot_v = Phi_arr; % abs(tan((Phi_Aster+90)/180*pi))
Y_plot_err = Phi_err_arr; % ---

errorbar(Freq_arr(Aster_range), Y_plot_v(Aster_range), ...
    Y_plot_err(Aster_range), Line_spec_Aster, 'Parent', Ax2);
errorbar(Freq_arr(LCR_range), Y_plot_v(LCR_range), ...
    Y_plot_err(LCR_range), Line_spec_LCR, 'Parent', Ax2);
errorbar(Freq_arr(Other_range), Y_plot_v(Other_range), ...
    Y_plot_err(Other_range), Line_spec_Other, 'Parent', Ax2);

ylabel('Phi, deg', 'Parent', Ax2);
% ylabel('tan(Phi)', 'Parent', Ax2) % FIXME: COMMENT

set(Ax2, 'xscale', 'log')
% set(Ax2, 'yscale', 'log') % FIXME: COMMENT


set_x_lim(Freq_arr, Ax1);
set_x_lim(Freq_arr, Ax2);
drawnow

end



function set_x_lim(Freq_arr, Ax)

f_min = min(Freq_arr);
f_max = max(Freq_arr);

f_lim_min = f_min*0.85;
f_lim_max = f_max*1.15;

xlim(Ax, [f_lim_min f_lim_max]);

end




