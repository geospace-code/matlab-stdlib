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
% * opts.type: class of variable e.g. int32, single
%
% The shape of the dataset can be controlled by specifying the "size" argument.
% This is particularly useful when writing HDF5 files to be used in other programming languages where dimensional shapes are important.
% Matlab may collapse singleton dimensions otherwise.
%  h5save(filename, dataset_name, dataset, size=[3,1])
%
% Likewise, the type of the dataset may be explicitly specified with the "type" argument.
%  h5save(filename, dataset_name, dataset, type="int32")

function h5save(filename, varname, A, varargin)
% arguments
%   filename (1,1) string
%   varname (1,1) string
%   A {mustBeNonempty}
%   opts.size (1,:) double {mustBeInteger,mustBeNonnegative} = []
%   opts.type (1,1) string = ""
%   opts.compressLevel (1,1) double {mustBeInteger,mustBeNonnegative} = 0
% end

p = inputParser;
addParameter(p, 'size', []);
addParameter(p, 'type', '');
addParameter(p, 'compressLevel', 0, @(x) mustBeInteger(x) && mustBeNonnegative(x));
parse(p, varargin{:});

opts = p.Results;

if isnumeric(A)
  mustBeReal(A)
end

% avoid confusing creating file ./~/a.h5
filename = stdlib.expanduser(filename);

% coerce if needed
A = coerce_ds(A, opts.type);

try
  h5save_exist(filename, varname, A, opts.size)
catch e
  switch e.identifier
    case {'MATLAB:imagesci:hdf5io:resourceNotFound', 'MATLAB:imagesci:h5info:unableToFind', 'MATLAB:imagesci:h5info:fileOpenErr', 'MATLAB:imagesci:h5info:libraryError'}
      h5save_new(filename, varname, A, opts.size, opts.compressLevel)
    otherwise
      rethrow(e)
  end
end

end
