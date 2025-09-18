%% H5SIZE get shape of HDF5 variable
%
%%% Inputs
% filename: data filename
% variable: name of variable inside file
%%% Outputs
% fsize: vector of variable size per dimension. Empty if scalar variable.

function fsize = h5size(file, variable)

finf = h5info(file, variable);
dsi = finf.Dataspace;

if strcmp(dsi.Type, 'scalar')
  fsize = [];
else
  fsize = dsi.Size;
end

end
