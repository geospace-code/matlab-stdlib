function p = posix(p)
%% posix(file)
% convert a path to a Posix path separated with "/" even on Windows.
% If Windows path also have escaping "\" this breaks
arguments
  p string
end

if ispc
  p = strrep(p, "\", "/");
end

end
