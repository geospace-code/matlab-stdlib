function h5save(filename, varname, A, opts)
% H5SAVE
% create or append to HDF5 file
% parent folder (file directory) must already exist

arguments
  filename (1,1) string {mustBeNonzeroLengthText}
  varname (1,1) string {mustBeNonzeroLengthText}
  A {mustBeNonempty}
  opts.size (1,:) double {mustBeInteger,mustBeNonnegative} = []
  opts.type string {mustBeScalarOrEmpty} = string.empty
end

import stdlib.fileio.expanduser
import stdlib.hdf5nc.h5exists

if isnumeric(A)
  mustBeReal(A)
end

filename = expanduser(filename);

% coerce if needed
A = coerce_ds(A, opts.type);

if isfile(filename) && h5exists(filename, varname)
  exist_file(filename, varname, A, opts.size)
else
  new_file(filename, varname, A, opts.size)
end

end % function


function exist_file(filename, varname, A, sizeA)

import stdlib.hdf5nc.h5size

diskshape = h5size(filename, varname);
if length(diskshape) >= 2
  % start is always a row vector, regardless of shape of array
  start = ones(1,ndims(A));
elseif ~isempty(diskshape)
  start = 1;
end

if isempty(sizeA)
  sizeA = defaultSize(A);
end

if isscalar(A)
  h5write(filename, varname, A)
elseif all(diskshape == sizeA)
  h5write(filename, varname, A, start, sizeA)
elseif all(diskshape == fliplr(sizeA))
  h5write(filename, varname, A.', start, fliplr(sizeA))
else
  error('hdf5nc:h5save:value_error', ['shape of ',varname,': ', int2str(sizeA), ' does not match existing HDF5 shape ', int2str(diskshape)])
end

end % function


function new_file(filename, varname, A, sizeA)


folder = fileparts(filename);
if strlength(folder) > 0 && ~isfolder(folder)
  error('hdf5nc:h5save:fileNotFound', '%s is not a folder, cannot create %s', folder, filename)
end

if isempty(sizeA)
  if isscalar(A) && ~isstring(A)
    h5_write_scalar(filename, varname, A)
  elseif isvector(A)
    h5create(filename, varname, length(A), 'DataType', class(A))
  else
    create_compress(filename, varname, A, size(A))
  end
else
  if isscalar(sizeA)
    if sizeA == 0 && ~isstring(A)
      h5_write_scalar(filename, varname, A)
    else
      h5create(filename, varname, sizeA, 'DataType', class(A))
    end
  else
    create_compress(filename, varname, A, sizeA)
  end
end

h5write(filename, varname, A)

end % function


% Copyright 2020 Michael Hirsch

% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at

%     http://www.apache.org/licenses/LICENSE-2.0

% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.
