%% APPEND Concatenate strings or character arrays without removing trailing whitespace
% APPEND(S1, S2, ...) appends strings or character vectors S1, S2, ... together.
% the output is a scalar string or character vector
%
% builtin append() is for Matlab >= R2019a, while this works back to R2016b.
% strcat() has the side effect of trimming whitespace, so we prefer
% stdlib.append() for string concatenation in case a user path has trailing whitespace.

function s = append(txt, varargin)

s = string(txt);

if stdlib.matlabOlderThan('R2019a')
  for i = 1:numel(varargin)
    s = s + varargin{i};
  end
else
  s = s.append(varargin{:});
end

if ischar(txt) && all(cellfun(@ischar, varargin))
  s = char(s);
end

end
