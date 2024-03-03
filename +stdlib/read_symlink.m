function isabs = read_symlink(apath)
%% read_symlink read symbolic link

arguments
  apath (1,1) string
end

isabs = stdlib.fileio.read_symlink(apath);

end
