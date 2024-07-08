function names = h4variables(file)

arguments
  file (1,1) string {mustBeFile}
end

finf = hdfinfo(file);

ds = finf.SDS;

names = string({ds.Name});

end
