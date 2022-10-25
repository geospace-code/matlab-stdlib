function fsize = h5size(file, variable)
%% h5size(file, variable)
% get size (shape) of a data file variable
%
%% Inputs
% filename: data filename
% variable: name of variable inside file
%
%% Outputs
% fsize: vector of variable size per dimension

arguments
  file (1,1) string {mustBeFile}
  variable (1,1) string {mustBeNonzeroLengthText}
end

dsi = h5info(stdlib.fileio.expanduser(file), variable).Dataspace;
if dsi.Type == "scalar"
  fsize = [];
else
  fsize = dsi.Size;
end

end
