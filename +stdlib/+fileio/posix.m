function ppath = posix(file)
%% posix(file)
% convert a path or sequence of path components to a Posix path separated
% with "/" even on Windows.
% If Windows path also have escaping "\" this breaks
arguments
  file (1,:) string
end


ppath = fullfile(file);

if ispc
  ppath = strrep(ppath, "\", "/");
end

end % function
