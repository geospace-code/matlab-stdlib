function backends = init_backend(backends, opts)
arguments
  backends cell
  opts.native = true
  opts.dotnet_api = 0
  opts.java = true
end

r = fileparts(fileparts(fileparts(mfilename('fullpath'))));
addpath(r)
co = onCleanup(@() rmpath(r));

 mask = false(size(backends));

for i = 1:numel(backends)
  switch backends{i}
    case 'java'
      if ~stdlib.has_java() || ~opts.java
        mask(i) = true;
      end
    case 'python'
      if ~stdlib.has_python()
        mask(i) = true;
      end
    case 'dotnet'
      if ~stdlib.has_dotnet() || stdlib.dotnet_api < opts.dotnet_api
        mask(i) = true;
      end
    case 'native'
      if ~opts.native
        mask(i) = true;
      end
  end
end

backends(mask) = [];

end
