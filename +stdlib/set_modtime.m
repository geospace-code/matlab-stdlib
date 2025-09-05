%% SET_MODTIME set modification time of path
%
%%% Inputs
% * p: path to modify
% * t: new modification time
% * backend: backend to use
%%% Outputs
% * i: true if successful
% * b: backend used

function [i, b] = set_modtime(file, t, backend)
arguments
  file
  t (1,1) datetime
  backend (1,:) string = ["java", "python", "sys"]
end

i = logical.empty;

for b = backend
  switch b
    case "java"
      i = stdlib.java.set_modtime(file, t);
    case "python"
      if stdlib.matlabOlderThan('R2022a'), continue, end
      i = stdlib.python.set_modtime(file, t);
    case "sys"
      i = stdlib.sys.set_modtime(file, t);
    otherwise
      error("stdlib:set_modtime:ValueError", "Unknown backend: %s", b)
  end

  if ~isempty(i)
    return
  end
end

end
