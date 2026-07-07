function backend = filterBackend(backend)
arguments
  backend (1,:) string
end
%FILTERBACKENDS Filter backends
%   backend = filterBackends(backend) filters the input backend list to remove
%   backends that are not supported. If the input
%   backend list is empty, the output will also be empty.

if stdlib.matlabOlderThan('R2022a')
  backend = backend(backend ~= "python");
end

end
