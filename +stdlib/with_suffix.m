%% WITH_SUFFIX switch file extension
%
%%% Inputs
% * filename: original filename
% * suffix: file extension with "." e.g. ".dat"
%%% Outputs
% * filename: modified filename

function f = with_suffix(filename, suffix)
arguments
  filename (1,1) string
  suffix (1,1) string
end

p = stdlib.parent(filename);
s = stdlib.stem(filename);

if strlength(s) == 0
  f = stdlib.join(filename, suffix);
  return
end

if p == "."
  f = s;
else
  f = p + "/" + s;
end

f = f + suffix;

end
