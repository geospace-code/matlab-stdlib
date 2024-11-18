function fsize = h5size(file, variable)
%% H5SIZE get shape of HDF5 variable
%
%%% Inputs
% filename: data filename
% variable: name of variable inside file
%%% Outputs
% fsize: vector of variable size per dimension. Empty if scalar variable.
arguments
  file (1,1) string {mustBeFile}
  variable (1,1) string {mustBeNonzeroLengthText}
end

dsi = h5info(file, variable).Dataspace;
if dsi.Type == "scalar"
  fsize = [];
else
  fsize = dsi.Size;
end

end
