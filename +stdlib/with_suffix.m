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

f = '';

r = stdlib.parent(p);
if strempty(r), return, end

s = stdlib.stem(p);

if strempty(s)
  f = stdlib.join(p, suffix);
  return
end

if strcmp(r, '.')
  f = s;
else
  f = fullfile(r, s);
end

f = strcat(f, suffix);

end

%!assert(with_suffix("ab.h5", ".nc"), "ab.nc")
%!assert(with_suffix("ab", ".nc"), "ab.nc")
%!assert(with_suffix("ab.h5", ""), "ab")
%!assert(with_suffix("ab", ""), "ab")
%!assert(with_suffix("ab/.h5", ".nc"), "ab/.h5.nc")
