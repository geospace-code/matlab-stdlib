function isabs = is_symlink(apath)
%% is_symlink is a symbolic link
arguments
  apath (1,1) string
end

isabs = stdlib.fileio.is_symlink(apath);

end
