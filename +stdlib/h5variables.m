function names = h5variables(file, group)
%% h5variables(file, group)
% get dataset names in a file under group
% default is datasets under "/", optionally under "/group"
%
%%% Inputs
% * file: filename
% * group: group name (optional)
%
%%% Outputs
% * names: variable names

arguments
    file (1,1) string {mustBeFile}
    group string {mustBeScalarOrEmpty} = string.empty
end

names = stdlib.hdf5nc.h5variables(file, group);

end
