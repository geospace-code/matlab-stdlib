function h5save(filename, varname, A, opts)
%% h5save(filename, varname, A, opts)
% create or append to data file
%
% parent folder (file directory) must already exist
%
%%% Inputs
% * filename: data filename
% * varname: variable name to save
% * A: data to write
% * opts.size: variable shape -- helps write scalar or vectors especially
% * opts.type: class of variable e.g. int32, float32

arguments
    filename (1,1) string {mustBeNonzeroLengthText}
    varname (1,1) string {mustBeNonzeroLengthText}
    A {mustBeNonempty}
    opts.size (1,:) double {mustBeInteger,mustBeNonnegative} = []
    opts.type string {mustBeScalarOrEmpty} = string.empty
end

stdlib.hdf5nc.h5save(filename, varname, A, ...
'size', opts.size, 'type', opts.type)

end
