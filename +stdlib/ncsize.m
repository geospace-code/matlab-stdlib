%% NCSIZE get size (shape) of a NetCDF4 variable
% get size (shape) of a data file variable
%
%%% Inputs
% file: data filepath
% variable: name of variable inside file
%%% Outputs
% fsize: vector of variable size per dimension. Empty if scalar variable.

function fsize = ncsize(file, variable)
arguments
  file
  variable
end

dsi = ncinfo(file, variable);
if isempty(dsi.Dimensions)
  fsize = [];
else
  fsize = dsi.Size;
end

end
