function isabs = is_absolute_path(apath)
%% is_absolute_path
arguments
  apath (1,1) string
end

isabs = stdlib.fileio.is_absolute_path(apath);

end
