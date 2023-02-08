function iswsl = is_wsl_path(path)
arguments
  path (1,1) string {mustBeNonzeroLengthText}
end

iswsl = stdlib.fileio.is_wsl_path(path);

end
