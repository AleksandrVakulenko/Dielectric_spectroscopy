
% FIXME: check description
% FIXME: do something with freq number and correction

% Generate frequency list for Time-Domain Frequency-Response Analysis.
%
%   [freq_list, N] = td_fra(f_min, f_max, count) generates a frequency
%   list using the external helper TDFRA_fit_other.gen_freq_arr with the
%   given count of points between f_min and f_max. The result is returned
%   as a column vector. N is the total number of frequencies returned.
%   Freq list is corrected by shifting frequencies away from 50 Hz and 
%   its harmonics;
%
%   [freq_list, N] = td_fra(f_min, f_max, count, Name, Value) allows
%   additional control through name-value pair arguments.
%
%   Inputs:
%       f_min   - Lower frequency bound (numeric scalar, must be > 0).
%       f_max   - Upper frequency bound (numeric scalar, must be > 0).
%       count   - Positive integer (default = 1). Number of frequency
%                 points to generate, passed directly to the external
%                 generator.
%
%   Name-Value Pair Arguments:
%       "order"  - Order of the returned frequency list. One of:
%                    "strait"  (default) - unmodified order.
%                    "reverse"          - reversed order.
%                    "shuffle"          - random permutation.
%       "repeat" - Positive integer (default = 1). Number of times the
%                  base frequency list is repeated. When > 1, the repeated
%                  list is sorted in ascending order before applying the
%                  "order" option.
%
%   Outputs:
%       freq_list - Column vector of generated frequencies.
%       N         - Number of elements in freq_list.
%
%   Errors:
%       "Freq must be >= 0" - if f_min <= 0 or f_max <= 0.
%
%   Dependencies:
%       TDFRA_fit_other.gen_freq_arr - external function/method used to
%       generate the base frequency array.
%
%   Example:
%       % Generate 20 frequencies between 0.1 Hz and 10 kHz, shuffled
%       [f, N] = td_fra(0.1, 1e4, 20, "order", "shuffle");
%


function [freq_list, N] = td_fra(f_min, f_max, count, options)
arguments
    f_min
    f_max
    count {mustBeInteger(count), mustBeGreaterThanOrEqual(count, 1)} = 1
    options.order {mustBeMember(options.order, ...
        ["strait", "reverse", "shuffle"])} = "strait"
    options.repeat {mustBeInteger(options.repeat), ...
        mustBeGreaterThanOrEqual(options.repeat, 1)} = 1
end

if f_min <= 0 || f_max <= 0
    error("Freq must be >= 0");
end



freq_list = TDFRA_fit_other.gen_freq_arr(f_min, f_max, count, ...
    "shuffle", "off", "repeat", 1, "correction", "on");

freq_list = freq_list(:);
N = numel(freq_list);

if options.repeat > 1
    freq_list = repmat(freq_list, options.repeat, 1);
    freq_list = sort(freq_list);
    N = numel(freq_list);
end

if options.order == "shuffle"
    inds = randperm(N);
    freq_list = freq_list(inds);
elseif options.order == "reverse"
    freq_list = flip(freq_list);
elseif options.order == "strait"
    % do nothing
end

end

