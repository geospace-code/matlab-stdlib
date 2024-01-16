function csize = auto_chunk_size(dims)
%% auto_chunk_size(dims)
% automatically determine HDF5 / NetCDF4 chunk size.
% based on https://github.com/h5py/h5py/blob/master/h5py/_hl/filters.py
% refer to https://support.hdfgroup.org/HDF5/Tutor/layout.html
%
%%% Inputs
% * dims: proposed dataset dimensions (like size())

arguments
  dims (1,:) {mustBeInteger,mustBePositive}
end

CHUNK_BASE = 16000;  % Multiplier by which chunks are adjusted
CHUNK_MIN = 8000;    % lower limit: 8 kbyte
CHUNK_MAX = 1000000; % upper limit: 1 Mbyte
TYPESIZE = 8;        % bytes, assume real64 for simplicity

csize = dims;

if isscalar(dims) || prod(dims) * TYPESIZE < CHUNK_MIN
  return
end

dset_size = prod(csize) * TYPESIZE;
target_size = CHUNK_BASE * (2.*log10(dset_size / 1e6));
if (target_size > CHUNK_MAX)
  target_size = CHUNK_MAX;
end

% print *,'target_size [bytes]: ',target_size

i = 0;
while true
  % Repeatedly loop over the axes, dividing them by 2.
  % Stop when:
  %  1a. We're smaller than the target chunk size, OR
  %  1b. We're within 50% of the target chunk size, AND
  %   2. The chunk is smaller than the maximum chunk size

  chunk_bytes = prod(csize) * TYPESIZE;

  if chunk_bytes < target_size || ...
     2*(abs(chunk_bytes-target_size) / target_size) < 1 && ...
     chunk_bytes < CHUNK_MAX
     break
  end

  if prod(csize) == 1
    break
  end
  % Element size larger than CHUNK_MAX
  j = mod(i, length(dims)) + 1;
  csize(j) = ceil(csize(j) / 2);
  i = i+1;
end

end % function
