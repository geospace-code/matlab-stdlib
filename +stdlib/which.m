function exe = which(filename, fpath)
%% which(filename, fpath)
% Find executable with name under path
% like Python shutil.which, may return relative or absolute path

arguments
  filename (1,1) string {mustBeNonzeroLengthText}
  fpath (1,:) string = getenv('PATH')
end

exe = stdlib.fileio.which(filename, fpath);

end
