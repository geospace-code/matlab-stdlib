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
  file
  backend (1,:) string = ["java", "python", "sys"]
end

i = uint64.empty;

for b = backend
  switch b
    case "java"
      i = stdlib.java.device(file);
    case "python"
      if stdlib.matlabOlderThan('R2022a'), continue, end
      i = stdlib.python.device(file);
    case "sys"
      i = stdlib.sys.device(file);
    otherwise
      error("stdlib:device:ValueError", "Unknown backend: %s", b)
  end

  if ~isempty(i)
    return
  end
end

end
