
ADC_frame_pos = [0.403 0.0065 0.59 0.987];


%%
clc

Fig = figure('position', [354 238 711 679]);
 
Control_Frame_1 = uipanel('parent', Fig, 'position', [0.02 0.22 0.96 0.66]);
Control_Frame_2 = uipanel('parent', Fig, 'position', [0.05 0.20 0.90 0.66]);
Control_Frame_1.Visible = true;
Control_Frame_2.Visible = false;

x = 0:0.01:2;
y = sin(x);
Ax1 = axes('Parent', Control_Frame_1, 'Position', [0.105 0.57 0.83 0.38]);
plot(x, y, 'Parent', Ax1);


% FIXME: (3) default demo callback of button
CB = @(a, b) ButtonCB(a, b, Control_Frame_1, Control_Frame_2);

Control_Frame_3 = uipanel('parent', Fig, 'position', [0.01 0.01 0.80 0.15]);

Stop_button = uicontrol('parent', Control_Frame_3, ...
                   'Style', 'pushbutton', ...
                   'units', 'normalized', ...
                   'position', [0.05 0.65 0.15 0.15], ...
                   'string', 'Stop', ...
                   'Callback', CB, ... % FIXME: (3) demo function?
                   'BackgroundColor', [0.95 0.73 0.73]);



function ButtonCB(src, ~, Control_Frame_1, Control_Frame_2)

Control_Frame_1.Visible = ~Control_Frame_1.Visible;
Control_Frame_2.Visible = ~Control_Frame_2.Visible;
disp('Stop button is pressed');

end

