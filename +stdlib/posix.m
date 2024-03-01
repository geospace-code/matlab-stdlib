function ppath = posix(file)
%% posix(file)
% convert a path to a Posix path separated with "/" even on Windows.
% If Windows path also have escaping "\" this breaks
arguments
  file string
end


ppath = stdlib.fileio.posix(file);

end
