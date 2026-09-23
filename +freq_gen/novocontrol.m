
% FIXME: check description

% Generate logarithmic frequency sweep (Novocontrol style).
%
%   [freq_list, N] = novocontrol(f_min, f_max, Scale) returns a column
%   vector of frequencies logarithmically spaced from f_max down to f_min.
%   The ratio between adjacent frequencies is given by Scale, so that
%   log10(Scale) decades are covered per step. If f_min is not exactly
%   hit by the logarithmic grid, it is appended to the end of the list.
%   N is the total number of frequencies returned.
%
%   [freq_list, N] = novocontrol(f_min, f_max, Scale, Name, Value) allows
%   additional control through name-value pair arguments.
%
%   Inputs:
%       f_min   - Lower frequency bound (numeric scalar, must be > 0).
%       f_max   - Upper frequency bound (numeric scalar, must be > 0).
%       Scale   - Multiplicative step factor between adjacent frequencies
%                 (numeric scalar, must be > 1). For example, Scale = 10
%                 gives one point per decade.
%
%   Name-Value Pair Arguments:
%       "order"  - Order of the returned frequency list. One of:
%                    "strait"  (default) - descending logarithmic order.
%                    "reverse"          - ascending order.
%                    "shuffle"          - random permutation.
%       "repeat" - Positive integer (default = 1). Number of times the
%                  base frequency list is repeated. When > 1, the repeated
%                  list is sorted in ascending order before applying the
%                  "order" option.
%
%   Outputs:
%       freq_list - Column vector of generated frequencies (in Hz).
%       N         - Number of elements in freq_list.
%
%   Errors:
%       "Freq must be >= 0"  - if f_min <= 0 or f_max <= 0.
%       "Scale must be >= 1" - if Scale <= 1.
%
%   Example:
%       % 10 points per decade from 1 Hz to 1 MHz, reversed order
%       [f, N] = novocontrol(1, 1e6, 10, "order", "reverse");
%


function [freq_list, N] = novocontrol(f_min, f_max, Scale, options)
arguments
    f_min
    f_max
    Scale
    options.order {mustBeMember(options.order, ...
        ["strait", "reverse", "shuffle"])} = "strait"
    options.repeat {mustBeInteger(options.repeat), ...
        mustBeGreaterThanOrEqual(options.repeat, 1)} = 1
end

if f_min <= 0 || f_max <= 0
    error("Freq must be >= 0");
end

if Scale <= 1
    error("Scale must be >= 1");
end

freq_list = log10(f_max) : -log10(Scale) : log10(f_min);
freq_list = 10.^freq_list;
freq_list(freq_list < f_min) = [];

if freq_list(1) ~= f_min
    freq_list(end+1) = f_min;
end

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

