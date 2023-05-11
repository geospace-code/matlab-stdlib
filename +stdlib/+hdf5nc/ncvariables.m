function names = ncvariables(file, group)

arguments
  file (1,1) string {mustBeFile}
  group string {mustBeScalarOrEmpty} = string.empty
end

names = string.empty;

if isempty(group) || strlength(group) == 0
  finf = ncinfo(file);
else
  finf = ncinfo(file, group);
end

ds = finf.Variables(:);
if isempty(ds)
  return
end

names = string({ds.Name});

end % function
