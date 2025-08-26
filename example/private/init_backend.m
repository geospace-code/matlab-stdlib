function backends = init_backend(funcName)
arguments
  funcName (1,1) string
end

r = fileparts(fileparts(fileparts(mfilename('fullpath'))));
addpath(r)
co = onCleanup(@() rmpath(r));

backends = cellstr(stdlib.Backend().select(funcName));

end
