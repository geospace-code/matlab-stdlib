function fsize = ncsize(file, variable)

arguments
  file (1,1) string {mustBeFile}
  variable (1,1) string {mustBeNonzeroLengthText}
end

dsi = ncinfo(stdlib.fileio.expanduser(file), variable);
if isempty(dsi.Dimensions)
  fsize = [];
else
  fsize = dsi.Size;
end

end
