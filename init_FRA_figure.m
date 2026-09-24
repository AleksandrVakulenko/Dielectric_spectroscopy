
% FIXME: (1) add type for Fig_FRA

function Fig_FRA = init_FRA_figure()

Figure_pos = [468 218 686 783];
Fig_name = "Data plot";

Fig_FRA = figure('Position', Figure_pos, ...
             'Name', Fig_name, 'NumberTitle', 'off', ...
             'MenuBar', 'figure', 'Resize', 'on');

Ax1 = axes('Parent', Fig_FRA, 'Position', [0.105 0.57 0.83 0.38]);
hold(Ax1, "on"); % FIXME: (1) myabe not
xlabel('f, Hz', 'Parent', Ax1);
grid(Ax1, 'on')
grid(Ax1, 'minor')
box(Ax1, 'on')
hold(Ax1, 'on')
cla(Ax1)

Ax2 = axes('Parent', Fig_FRA, 'Position', [0.105 0.09 0.83 0.38]);
hold(Ax1, "on"); % FIXME: (1) myabe not
xlabel('f, Hz', 'Parent', Ax2);
grid(Ax2, 'on')
grid(Ax2, 'minor')
box(Ax2, 'on')
hold(Ax2, 'on')
cla(Ax2)

Ax_arr = [Ax1, Ax2];

Fig_FRA.UserData = struct('ax_arr', Ax_arr);

end