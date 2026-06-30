%% H4SIZE get size (shape) of a HDF4 variable
%
%%% Inputs
% filename: data filename
% variable: name of variable inside file
%%% Outputs
% fsize: vector of variable size per dimension. Empty if scalar variable.

function fsize = h4size(file, variable)
arguments (Input)
  file {mustBeTextScalar,mustBeFile}
  variable {mustBeTextScalar}
end
arguments (Output)
  fsize (1,:) {mustBeNonnegative,mustBeInteger}
end

finf = hdfinfo(file);
sds = finf.SDS;

i = strcmp({sds.Name}, variable);
if ~any(i)
  error('%s is not an SDS in %s', variable, file)
end

fsize = [sds(i).Dims.Size];

end
