function ncsave(filename, varname, A, opts)
% NCSAVE
% create or append to NetCDF4 file
% parent folder (file directory) must already exist

arguments
  filename (1,1) string {mustBeNonzeroLengthText}
  varname (1,1) string {mustBeNonzeroLengthText}
  A {mustBeNonempty}
  opts.dims cell = {}
  opts.type string {mustBeScalarOrEmpty} = string.empty
end

import stdlib.fileio.expanduser
import stdlib.hdf5nc.ncexists

if isnumeric(A)
  mustBeReal(A)
end


filename = expanduser(filename);

if isempty(opts.dims)
  if isscalar(A)
    sizeA = 1;
    ncdims = [];
  elseif isvector(A)
    sizeA = length(A);
    ncdims = {'x', sizeA};
  elseif ismatrix(A)
    sizeA = size(A);
    ncdims = {'x', sizeA(1), 'y', sizeA(2)};
  else
    sizeA = size(A);
    switch length(sizeA)
      case 3, ncdims = {'x', sizeA(1), 'y', sizeA(2), 'z', sizeA(3)};
      case 4, ncdims = {'x', sizeA(1), 'y', sizeA(2), 'z', sizeA(3), 'w', sizeA(4)};
      otherwise, error('ncsave currently does scalar through 4D')
    end
  end % if
else
  ncdims = opts.dims;

  for i = 2:2:length(opts.dims)
    sizeA(i/2) = opts.dims{i}; %#ok<AGROW>
  end
end
% coerce if needed
A = coerce_ds(A, opts.type);

if isfile(filename) && ncexists(filename, varname)
  exist_file(filename, varname, A, sizeA)
else
  new_file(filename, varname, A, sizeA, ncdims)
end

end % function


function exist_file(filename, varname, A, sizeA)

import stdlib.hdf5nc.ncsize

diskshape = ncsize(filename, varname);

if all(diskshape == sizeA)
  ncwrite(filename, varname, A)
elseif all(diskshape == fliplr(sizeA))
  ncwrite(filename, varname, A.')
else
  error('hdf5nc:ncsave:value_error', ['shape of ',varname,': ', int2str(sizeA), ' does not match existing NetCDF4 shape ', int2str(diskshape)])
end

end % function


function new_file(filename, varname, A, sizeA, ncdims)
import stdlib.hdf5nc.auto_chunk_size

folder = fileparts(filename);
if strlength(folder) > 0 && ~isfolder(folder)
  error('hdf5nc:ncsave:fileNotFound', '%s is not a folder, cannot create %s', folder, filename)
end

if isscalar(A)
  nccreate(filename, varname, 'Datatype', class(A), 'Format', 'netcdf4')
elseif isvector(A)
  nccreate(filename, varname, 'Dimensions', ncdims, 'Datatype', class(A), 'Format', 'netcdf4')
else
  % enable Gzip compression--remember Matlab's dim order is flipped from
  % C / Python
  % "Datatype" to be Octave case-sensitive keyword compatible
  nccreate(filename, varname, 'Dimensions', ncdims, ...
    'Datatype', class(A), ...
    'DeflateLevel', 1, 'Shuffle', true, ...
    'ChunkSize', auto_chunk_size(sizeA), ...
    'Format', 'netcdf4')
end

ncwrite(filename, varname, A)

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
