%% DEVICE filesystem device index of path
%
%%% Inputs
% * file: path to file
% * backend: backend to use
%%% Outputs
% * i: device index
% * b: backend used

function [i, b] = device(file, backend)
arguments
  file {mustBeTextScalar, mustBeFileOrFolder}
  backend (1,:) string = ["java", "python", "shell"]
end

i = uint64([]);

for b = backend
  switch b
    case 'java'
      i = stdlib.java.device(file);
    case 'python'
      if stdlib.has_python()
        i = stdlib.python.device(file);
      end
    case 'shell'
      i = stdlib.shell.device(file);
    otherwise
      error('stdlib:device:ValueError', 'Unknown backend: %s', b)
  end

  if ~isempty(i)
    return
  end
end

end
