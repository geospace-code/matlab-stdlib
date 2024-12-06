%% WITH_SUFFIX switch file extension
%
%%% Inputs
% * p: path to modify
% * suffix: file extension with "." e.g. ".dat"
%%% Outputs
% * f: modified filename

function f = with_suffix(p, suffix)
arguments
  p (1,1) string
  suffix (1,1) string
end

r = stdlib.parent(p);
s = stdlib.stem(p);

if strlength(s) == 0
  f = stdlib.join(p, suffix);
  return
end

if r == "."
  f = s;
else
  f = r + "/" + s;
end

f = f + suffix;

end
