%% H4SIZE get size (shape) of a HDF4 variable
%
%%% Inputs
% filename: data filename
% variable: name of variable inside file
%%% Outputs
% fsize: vector of variable size per dimension. Empty if scalar variable.

function fsize = h4size(file, variable)
% arguments
%   file
%   variable (1,1) string
% end

finf = hdfinfo(file);
sds = finf.SDS;

i = strcmp({sds.Name}, variable);
if ~any(i)
  error(variable + " is not an SDS in " + file)
end

fsize = [sds(i).Dims.Size];

end
