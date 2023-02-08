function h5save(filename, varname, A, opts)

arguments
  filename (1,1) string {mustBeNonzeroLengthText}
  varname (1,1) string {mustBeNonzeroLengthText}
  A {mustBeNonempty}
  opts.size (1,:) double {mustBeInteger,mustBeNonnegative} = []
  opts.type string {mustBeScalarOrEmpty} = string.empty
end

if isnumeric(A)
  mustBeReal(A)
end

filename = stdlib.fileio.expanduser(filename);

% coerce if needed
A = coerce_ds(A, opts.type);

if isfile(filename)
  if stdlib.hdf5nc.h5exists(filename, varname)
    h5_exist_file(filename, varname, A, opts.size)
  else
    h5_new_file(filename, varname, A, opts.size)
  end
else
    h5_new_file(filename, varname, A, opts.size)
end

end % function

% Copyright 2020 SciVision, Inc.

% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at

%     http://www.apache.org/licenses/LICENSE-2.0

% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.
