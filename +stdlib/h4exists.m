function exists = h4exists(file, variable)
%% H5EXISTS(file, variable)
% check if object exists in HDF4 file
%
%%% Inputs
% * file: data filename
% * variable: path of variable in file
%
%%% Outputs
% * exists: boolean

arguments
  file (1,1) string
  variable (1,1) string
end

exists = stdlib.hdf5nc.h4exists(file, variable);

end
