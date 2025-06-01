%% POSIX posix format of path with '/' separator
% convert a path to a Posix string path separated with "/" even on Windows.
% If Windows path also have escaping "\" this breaks
%

function r = posix(p)
arguments
  p {mustBeTextScalar}
end

if ispc
  r = strrep(p, '\', '/');
else
  r = p;
end

end

%!assert (posix('/'), '/')
