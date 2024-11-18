%% POSIX posix format of path with '/' separator
% convert a path to a Posix string path separated with "/" even on Windows.
% If Windows path also have escaping "\" this breaks

function p = posix(p)
arguments
  p string
end

p = string(p);

if ispc
  p = strrep(p, "\", "/");
end

end
