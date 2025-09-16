%% GET_USERNAME tell username of current user
%
%%% Inputs
% * backend: preferred backend(s)
%%% Outputs
% * n: username of current user
% * b: backend used

function [r, b] = get_username(backend)
if nargin < 1
  backend = ["java", "dotnet", "python", "sys"];
else
  backend = string(backend);
end

r = '';

for b = backend
  switch b
    case "java"
      r = stdlib.java.get_username();
    case "dotnet"
      r = stdlib.dotnet.get_username();
    case "python"
      if stdlib.matlabOlderThan('R2022a'), continue, end
      r = stdlib.python.get_username();
    case "sys"
      r = stdlib.sys.get_username();
    otherwise
      error("stdlib:get_username:ValueError", "Unknown backend: %s", b)
  end

  if ~isempty(r)
    return
  end
end

end
