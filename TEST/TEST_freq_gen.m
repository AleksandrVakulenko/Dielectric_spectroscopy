
%% Novocontrol type

clc

f_min = 0.1;
f_max = 3e0;
Scale = 1.6;

Freq_list = freq_gen.novocontrol(f_min, f_max, Scale);

Freq_list = freq_gen.novocontrol(f_min, f_max, Scale, "order", "strait")'

Freq_list = freq_gen.novocontrol(f_min, f_max, Scale, "order", "reverse")'

Freq_list = freq_gen.novocontrol(f_min, f_max, Scale, "order", "shuffle")'


Freq_list = freq_gen.novocontrol(f_min, f_max, Scale, "order", ...
    "strait", 'repeat', 2)'

Freq_list = freq_gen.novocontrol(f_min, f_max, Scale, "order", ...
    "reverse", 'repeat', 2)'

Freq_list = freq_gen.novocontrol(f_min, f_max, Scale, "order", ...
    "shuffle", 'repeat', 2)'


%% TD-FRA built-in

clc

f_min = 0.1;
f_max = 3e0;
Count = 5;

Freq_list = freq_gen.td_fra(f_min, f_max, Count);

Freq_list = freq_gen.td_fra(f_min, f_max, Count, "order", "strait")'

Freq_list = freq_gen.td_fra(f_min, f_max, Count, "order", "reverse")'

Freq_list = freq_gen.td_fra(f_min, f_max, Count, "order", "shuffle")'


Freq_list = freq_gen.td_fra(f_min, f_max, Count, "order", ...
    "strait", 'repeat', 2)'

Freq_list = freq_gen.td_fra(f_min, f_max, Count, "order", ...
    "reverse", 'repeat', 2)'

Freq_list = freq_gen.td_fra(f_min, f_max, Count, "order", ...
    "shuffle", 'repeat', 2)'


f_min = 30;
f_max = 70;
Count = 50;

Freq_list = freq_gen.td_fra(f_min, f_max, Count)
plot(Freq_list, 'x')

