function backends = init_backend(funcName)
arguments
  funcName (1,1) string
end

r = fileparts(fileparts(fileparts(mfilename('fullpath'))));
addpath(r)
co = onCleanup(@() rmpath(r));

backends = cellstr(stdlib.Backend().select(funcName));

if isempty(backends)
  error('Did not find any backends for function %s', funcName)
end

end
