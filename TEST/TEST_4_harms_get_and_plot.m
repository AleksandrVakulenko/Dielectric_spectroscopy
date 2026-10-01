

Folder = 'TEST_data';


Filename = 'test_data_CAP_100n_harms.mat';


Result = data_operation.open_result_file(Filename, Folder);


clc


Harm_res = [];
Harm_res_err = [];
Harm_phi = [];
Freq = [];
Res_abs_main = [];
Res_abs_err_main = [];


for i = 1:numel(Result)

    Harms = Result(i).harm;
    Freq(i) = Result(i).freq;
    Res_abs_main(i) = Result(i).res_abs;
    Res_abs_err_main(i) = Result(i).res_abs_err;


    for j = 1:numel(Harms)

        N = Harms(j).n;
        Res = Harms(j).res;
        Res_err = Harms(j).res_err;
        Phi = Harms(j).phi;

        if ~isempty(Res)
            Harm_res(N, i) = Res;
        else
            Harm_res(N, i) = NaN;
        end

        if ~isempty(Res_err)
            Harm_res_err(N, i) = Res_err;
        else
            Harm_res_err(N, i) = NaN;
        end

        if ~isempty(Phi)
            Harm_phi(N, i) = Phi;
        else
            Harm_phi(N, i) = NaN;
        end



    end

end



%


figure('position', [380 305 753 492])
hold on

errorbar(Freq, Res_abs_main, Res_abs_err_main, '-k', 'LineWidth', 2, ...
    'DisplayName', 'main')

for i = 2:9
    Harm_inv_rel_amp = Res_abs_main./Harm_res(i, :);
%     plot(Freq, Harm_rel_amp, "DisplayName", [num2str(i)])
    errorbar(Freq, Harm_res(i, :), Harm_res_err(i, :), ...
        "DisplayName", [num2str(i)])

end
set(gca, 'xscale', 'log')
set(gca, 'yscale', 'log')



xlabel('f, Hz')


legend()


%%



figure('position', [380 305 753 492])
hold on



for i = 2:9

%     errorbar(Freq, Harm_res(i, :), Harm_res_err(i, :), ...
%         "DisplayName", [num2str(i)])
    plot(Freq, Harm_phi)

end
set(gca, 'xscale', 'log')
% set(gca, 'yscale', 'log')



xlabel('f, Hz')


legend()









