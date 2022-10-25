function ncsave(filename, varname, A, opts)
%% ncsave(filename, varname, A, opts)
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
  opts.dims cell = {}
  opts.type string {mustBeScalarOrEmpty} = string.empty
end

if isnumeric(A)
  mustBeReal(A)
end

filename = stdlib.fileio.expanduser(filename);

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

if isfile(filename)
  if stdlib.hdf5nc.ncexists(filename, varname)
    nc_exist_file(filename, varname, A, sizeA)
  else
    nc_new_file(filename, varname, A, sizeA, ncdims)
  end
else
  nc_new_file(filename, varname, A, sizeA, ncdims)
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
