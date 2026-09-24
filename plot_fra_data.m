


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



Line_spec = '.r';


Freq_arr = [Result.freq];
Res_arr = [Result.res_abs];
Res_err_arr = [Result.res_abs_err];
Phi_arr = [Result.phi];
Phi_err_arr = [Result.phi_err];

% NOTE: calc cap
Cap_arr = 1./(2*pi*Res_arr.*Freq_arr);
Cap_arr_err = -1./(2*pi*Res_arr.^2.*Freq_arr).*Res_err_arr;




errorbar(Freq_arr, Cap_arr*1e12, Cap_arr_err*1e12, ...
    Line_spec, 'Parent', Ax1);
% errorbar(Freq_arr_plot_Aster, Res_Aster, Res_err_Aster, ...
%     Line_spec, 'Parent', Ax1) % FIXME: COMMENT

ylabel('|Cap|, pF', 'Parent', Ax1)
% ylabel('|R|, Ohm', 'Parent', Ax1) % FIXME: COMMENT

set(Ax1, 'xscale', 'log')
% set(Ax1, 'yscale', 'log') % FIXME: COMMENT



errorbar(Freq_arr, Phi_arr, Phi_err_arr, ...
    Line_spec, 'Parent', Ax2)
% plot(Freq_arr_plot_Aster, abs(tan((Phi_Aster+90)/180*pi)), ...
%     Line_spec, 'Parent', Ax2) % FIXME: COMMENT

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




