%% GET_USERNAME tell username of current user
%
%%% Inputs
% * backend: preferred backend(s)
%%% Outputs
% * n: username of current user
% * b: backend used

function [r, b] = get_username(backend)
arguments
  backend (1,:) string {mustBeNonempty} = ["java", "dotnet", "python", "shell"]
end

r = missing;

for b = filterBackend(backend)
  f = str2func("stdlib." + b + ".get_username");
  r = f();

  if ~ismissing(r)
    return
  end
end

end
