%% H5SAVE save data to HDF5 file
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
%
% The shape of the dataset can be controlled by specifying the "size" argument.
% This is particularly useful when writing HDF5 files to be used in other programming languages where dimensional shapes are important.
% Matlab may collapse singleton dimensions otherwise.
%  h5save(filename, dataset_name, dataset, size=[3,1])
%
% Likewise, the type of the dataset may be explicitly specified with the "type" argument.
%  h5save(filename, dataset_name, dataset, type="int32")

function h5save(filename, varname, A, opts)
arguments
  filename (1,1) string {mustBeNonzeroLengthText}
  varname (1,1) string {mustBeNonzeroLengthText}
  A {mustBeNonempty}
  opts.size (1,:) double {mustBeInteger,mustBeNonnegative} = []
  opts.type (1,1) string = ""
end

if isnumeric(A)
  mustBeReal(A)
end

% avoid confusing creating file ./~/foo.h5
filename = stdlib.expanduser(filename);

% coerce if needed
A = coerce_ds(A, opts.type);

if isfile(filename)
  if stdlib.h5exists(filename, varname)
    h5_exist_file(filename, varname, A, opts.size)
  else
    h5_new_file(filename, varname, A, opts.size)
  end
else
    h5_new_file(filename, varname, A, opts.size)
end

end % function
