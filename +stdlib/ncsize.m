function fsize = ncsize(file, variable)
%% ncsize(file, variable)
% get size (shape) of a data file variable
%
%%% Inputs
% filename: data filename
% variable: name of variable inside file
%
%%% Outputs
% fsize: vector of variable size per dimension. Empty if scalar variable.

arguments
  file (1,1) string {mustBeFile}
  variable (1,1) string {mustBeNonzeroLengthText}
end

fsize = stdlib.hdf5nc.ncsize(file, variable);

end
