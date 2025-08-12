%% GET_OWNER owner name of file or directory
%
%%% Inputs
% * file: path to examine
% * backend: backend to use
%%% Outputs
% * n: owner, or empty if path does not exist
% * b: backend used

function [n, b] = get_owner(file, backend)
arguments
  file string
  backend (1,:) string = ["java", "dotnet", "python", "sys"]
end

[fun, b] = hbackend(backend, "get_owner");

if isscalar(file)
  n = fun(file);
else
  n = arrayfun(fun, file);
end

end
