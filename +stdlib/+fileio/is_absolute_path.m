function isabs = is_absolute_path(apath)

arguments
  apath string
end

% leave expanduser() here to work like C++ filesystem::path::is_absolute()
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

end
