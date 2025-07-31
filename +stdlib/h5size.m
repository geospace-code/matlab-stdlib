%% H5SIZE get shape of HDF5 variable
%
%%% Inputs
% filename: data filename
% variable: name of variable inside file
%%% Outputs
% fsize: vector of variable size per dimension. Empty if scalar variable.

function fsize = h5size(file, variable)
arguments
  file {mustBeTextScalar}
  variable {mustBeTextScalar}
end

dsi = h5info(file, variable).Dataspace;

if ~stdlib.isoctave() && dsi.Type == "scalar"
  fsize = [];
else
  fsize = dsi.Size;
end

end
