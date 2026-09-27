

clc

Folder = "Result_LCR_01";

% Filename = "2026_09_25_06_20_36.mat"; % 0.025
% Filename = "2026_09_27_01_11_24.mat"; % 71
Filename = "2026_09_27_15_44_41.mat"; % 103
% Filename = "2026_09_27_10_05_14.mat"; % 257


% Filename = "1.mat";


tic
[Result, Extra] = data_operation.open_result_file(Filename, Folder);
toc

tic
Result = data_operation.open_result_file(Filename, Folder);
toc


%%
x = [257 103 71 0.025];
y = [80 37 15 0.5];

plot(x, y, 'x')

fitres = fit(x', y', 'a*x');
xm = 0:1:300;
ym = feval(fitres, xm);
hold on
plot(xm, ym)

