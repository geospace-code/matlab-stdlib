function exists = h5exists(file, variable)
%% H5EXISTS(file, vars)
% check if object(s) exists in HDF5 file
%
%%% Inputs
% * file: data filename
% * variable: path of variable in file
%
%%% Outputs
% * exists: boolean

arguments
    file (1,1) string {mustBeFile}
    variable string {mustBeScalarOrEmpty}
end

exists = stdlib.hdf5nc.h5exists(file, variable);

end
