function names = h5variables(file, group)

arguments
  file (1,1) string {mustBeFile}
  group string {mustBeScalarOrEmpty} = string.empty
end

if isempty(group) || strlength(group) == 0
  finf = h5info(file);
else
  finf = h5info(file, group);
end

ds = finf.Datasets;

if isempty(ds)
  names = string.empty;
else
  names = string({ds.Name});
end

end