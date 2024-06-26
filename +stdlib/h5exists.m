function exists = h5exists(file, variable)
%% H5EXISTS(file, variable)
% check if object exists in HDF5 file
%
%%% Inputs
% * file: data filename
% * variable: path of variable in file
%
%%% Outputs
% * exists: boolean

arguments
  file (1,1) string
  variable string {mustBeScalarOrEmpty}
end

exists = stdlib.hdf5nc.h5exists(file, variable);

end
