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

try
  if h5exists(filename, varname)
    h5_exist_file(filename, varname, A, opts.size)
  else
    h5_new_file(filename, varname, A, opts.size)
  end
catch e
  if e.identifier == "MATLAB:imagesci:hdf5io:resourceNotFound"
    h5_new_file(filename, varname, A, opts.size)
  else
    rethrow(e)
  end
end

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
