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

if stdlib.len(s) == 0
  f = stdlib.join(p, suffix, false);
  return
end

if r == '.'
  f = s;
elseif ischar(r)
  f = strcat(r, '/', s);
else
  f = r + "/" + s;
end

if ischar(r)
  f = strcat(f, suffix);
else
  f = f + suffix;
end

end

%!assert(with_suffix("ab.h5", ".nc"), "ab.nc")
%!assert(with_suffix("ab", ".nc"), "ab.nc")
%!assert(with_suffix("ab.h5", ""), "ab")
%!assert(with_suffix("ab", ""), "ab")
