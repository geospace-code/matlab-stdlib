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

if isempty(opts.size)
  if isvector(A)
    sizeA = length(A);
  else
    sizeA = size(A);
  end
else
  sizeA = opts.size;
end
% coerce if needed
A = coerce_ds(A, opts.type);
if ischar(A)
  A = string(A);
  sizeA = size(A);
end

if isfile(filename) && h5exists(filename, varname)
  exist_file(filename, varname, A, sizeA)
else
  new_file(filename, varname, A, sizeA)
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
if ~isfolder(folder)
  error('hdf5nc:h5save:fileNotFound', '%s is not a folder, cannot create %s', folder, filename)
end

if isscalar(A) && ~isstring(A)
  dcpl = 'H5P_DEFAULT';

  if isfile(filename)
    fid = H5F.open(filename, 'H5F_ACC_RDWR', dcpl);
  else
    fid = H5F.create(filename);
  end

  create_hdf5_group(fid, varname);

  space_id = H5S.create('H5S_SCALAR');
  t = class2h5t(A);
  type_id = H5T.copy(t);
  dset_id = H5D.create(fid, varname, type_id, space_id, dcpl);
  H5D.write(dset_id,'H5ML_DEFAULT','H5S_ALL','H5S_ALL', dcpl, A);

  H5S.close(space_id);
  H5T.close(type_id);
  H5D.close(dset_id);
  H5F.close(fid);

  return
end

if isvector(A)
  h5create(filename, varname, sizeA, 'DataType', class(A))
else
  % enable Gzip compression--remember Matlab's dim order is flipped from
  % C / Python
  h5create(filename, varname, sizeA, 'DataType', class(A), ...
    'Deflate', 1, 'Fletcher32', true, 'Shuffle', true, ...
    'ChunkSize', auto_chunk_size(sizeA))
end % if

h5write(filename, varname, A)

end % function


function t = class2h5t(A)
% gets HDF5 H5T of variable A

switch class(A)
  case 'double', t = 'H5T_NATIVE_DOUBLE';
  case 'single', t = 'H5T_NATIVE_FLOAT';
  case 'int32', t = 'H5T_STD_I32LE';
  case 'int64', t = 'H5T_STD_I64LE';
  otherwise, error('h5save:class2h5t: unknown data class %s', class(A))
end

end


function create_hdf5_group(fid, name)

grps = split(name, "/");
if length(grps) < 3
  return
end

plist = 'H5P_DEFAULT';
groot = H5G.open(fid, "/");

for i = 0:length(grps) - 3
  n = join(grps(1:i+2), "/");

  if ~H5L.exists(groot, n, plist)
    gid = H5G.create(fid, n, plist, plist, plist);
    H5G.close(gid)
  end
end % for

H5G.close(groot)
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
