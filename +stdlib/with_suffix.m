%% WITH_SUFFIX switch file extension
%
%%% Inputs
% * p: path to modify
% * suffix: file extension with "." e.g. ".dat"
%%% Outputs
% * f: modified filename

function f = with_suffix(p, suffix)
arguments
  p string
  suffix {mustBeTextScalar}
end

f = extractBefore(p, stdlib.suffix(p));

i = strempty(f);
f(i) = p(i);

f = f + suffix;

end
