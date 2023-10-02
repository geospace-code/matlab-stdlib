function isabs = is_absolute_path(apath)
%% is_absolute_path(apath)
% true if path is absolute. Path need not yet exist.
% even if path has inside ".." it's still considered absolute
% e.g. Python
%  os.path.isabs("/foo/../bar") == True

arguments
  apath string {mustBeScalarOrEmpty}
end

isabs = stdlib.fileio.is_absolute_path(apath);

end
