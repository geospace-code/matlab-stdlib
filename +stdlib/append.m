%% APPEND Concatenate strings or character arrays without removing trailing whitespace
% APPEND(S1, S2, ...) appends strings or character vectors S1, S2, ... together.
% the output is a scalar string or character vector
%
% strcat() has the side effect of trimming whitespace, so we prefer
% stdlib.append() for string concatenation in case a user path has trailing whitespace.

function s = append(txt, a)
arguments
  txt {mustBeTextScalar}
end
arguments (Repeating)
  a {mustBeText}
end

s = string(txt).append(a{:});

if ischar(txt) && all(cellfun(@ischar, a))
  s = char(s);
end

end
