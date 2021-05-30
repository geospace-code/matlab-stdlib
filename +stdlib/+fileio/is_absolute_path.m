function isabs = is_absolute_path(apath)
%% true if path is absolute. Path need not yet exist.
% even if path has inside ".." it's still considered absolute
% e.g. Python
%  os.path.isabs("/foo/../bar") == True

arguments
  apath string
end

apath = stdlib.fileio.expanduser(apath);

if ispc
  i = strlength(apath) < 3;
  isabs(i) = false;

  hasDrive = cell2mat(isstrprop(extractBefore(apath(~i), 2), "alpha", "ForceCellOutput", true));
  isabs(~i) = hasDrive & extractBetween(apath(~i), 2,2) == ":" & ...
                   (extractBetween(apath(~i), 3,3) == "/" | extractBetween(apath(~i), 3,3) == "\");
else
  isabs = startsWith(apath, "/");
end

end % function
