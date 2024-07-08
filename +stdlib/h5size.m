function fsize = h5size(file, variable)
%% h5size(file, variable)
% get size (shape) of a data file variable
%
%%% Inputs
% filename: data filename
% variable: name of variable inside file
%
%%% Outputs
% fsize: vector of variable size per dimension. Empty if scalar variable.

arguments
    file (1,1) string
    variable (1,1) string
end

fsize = stdlib.hdf5nc.h5size(file, variable);

end
