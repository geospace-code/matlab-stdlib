function hash = md5sum(file)
%% md5sum(file)
% compute MD5 hash of file
arguments
  file (1,1) string {mustBeFile}
end

hash = stdlib.fileio.md5sum(file);

end
