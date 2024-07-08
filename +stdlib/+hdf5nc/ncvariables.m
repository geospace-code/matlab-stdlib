function names = ncvariables(file, group)

arguments
  file (1,1) string {mustBeFile}
  group string {mustBeScalarOrEmpty} = string.empty
end

if isempty(group) || strlength(group) == 0
  finf = ncinfo(file);
else
  finf = ncinfo(file, group);
end

ds = finf.Variables(:);

if isempty(ds)
  names = string.empty;
else
  names = string({ds.Name});
end

end
