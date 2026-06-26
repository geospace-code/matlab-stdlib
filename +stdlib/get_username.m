%% GET_USERNAME tell username of current user
%
%%% Inputs
% * backend: preferred backend(s)
%%% Outputs
% * n: username of current user
% * b: backend used

function [r, b] = get_username(backend)
arguments
  backend (1,:) string = ["java", "dotnet", "python", "shell"]
end

r = missing;

for b = backend
  switch b
    case 'java'
      r = stdlib.java.get_username();
    case 'dotnet'
      r = stdlib.dotnet.get_username();
    case 'python'
      if stdlib.has_python()
        r = stdlib.python.get_username();
      end
    case 'shell'
      r = stdlib.shell.get_username();
    otherwise
      error('stdlib:get_username:ValueError', 'Unknown backend: %s', b)
  end

  if ~ismissing(r)
    return
  end
end

end
