%% WITH_SUFFIX switch file extension
%
%%% Inputs
% * p: path to modify
% * suffix: file extension with "." e.g. ".dat"
%%% Outputs
% * f: modified filename

function f = with_suffix(p, suffix)
arguments
  p {mustBeTextScalar}
  suffix {mustBeTextScalar}
end

f = "";

r = stdlib.parent(p);
if ~strlength(r), return, end

s = stdlib.stem(p);

if strlength(s) == 0
  f = stdlib.join(p, suffix);
  return
end

if strcmp(r, '.')
  f = s;
else
  f = strcat(r, '/', s);
end

f = strcat(f, suffix);

end

%!assert(with_suffix("ab.h5", ".nc"), "ab.nc")
%!assert(with_suffix("ab", ".nc"), "ab.nc")
%!assert(with_suffix("ab.h5", ""), "ab")
%!assert(with_suffix("ab", ""), "ab")
%!assert(with_suffix("ab/.h5", ".nc"), "ab/.h5.nc")
