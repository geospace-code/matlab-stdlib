%% GET_OWNER owner name of file or directory
%
%%% Inputs
% * p: path to examine
%%% Outputs
% * n: owner, or empty if path does not exist
% * b: backend used

function [n, b] = get_owner(file, backend)
arguments
  file {mustBeTextScalar}
  backend (1,:) string = ["java", "dotnet", "python", "sys"]
end

[fun, b] = hbackend(backend, "get_owner");

n = fun(file);

end
