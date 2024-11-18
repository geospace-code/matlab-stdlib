%% H4SIZE get size (shape) of a HDF4 variable
%
%%% Inputs
% filename: data filename
% variable: name of variable inside file
%%% Outputs
% fsize: vector of variable size per dimension. Empty if scalar variable.

function fsize = h4size(file, variable)
arguments
  file (1,1) string {mustBeFile}
  variable (1,1) string {mustBeNonzeroLengthText}
end

sds = hdfinfo(file).SDS;

i = string(sds.Name) == variable;
if ~all(i)
  error(variable + " is not an SDS in " + file)
end

fsize = cell2mat({sds(i).Dims.Size});

end
