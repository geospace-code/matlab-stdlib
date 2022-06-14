function create_compress(filename, varname, A, sizeA)
%% enable Gzip compression
% remember Matlab's dim order is flipped from C / Python

import stdlib.hdf5nc.auto_chunk_size

h5create(filename, varname, sizeA, Datatype=class(A), ...
  Deflate=1, Fletcher32=true, Shuffle=true, ...
  ChunkSize=auto_chunk_size(sizeA))

end
