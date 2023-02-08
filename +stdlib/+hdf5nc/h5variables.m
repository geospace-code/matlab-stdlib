function names = h5variables(file, group)

arguments
  file (1,1) string {mustBeFile}
  group string {mustBeScalarOrEmpty} = string.empty
end

names = string.empty;

if isempty(group) || strlength(group) == 0
  finf = h5info(stdlib.fileio.expanduser(file));
else
  finf = h5info(stdlib.fileio.expanduser(file), group);
end

ds = finf.Datasets;

if isempty(ds)
  return
end

names = string({ds.Name});

end % function
