%% IS_REMOVABLE - Check if a file path is on a removable drive
% Not necessarily perfectly reliable at detection, but works for most cases.
%
%% Inputs
% * filepath: path to check
% * backend: backend to use
%
%% Outputs
% * ok: true if path is on a removable drive
% * b: backend used

function [ok, b] = is_removable(filepath, backend)
arguments
  filepath {mustBeTextScalar}
  backend (1,:) string = ["dotnet", "sys"]
end

[fun, b] = hbackend(backend, "is_removable");

ok = fun(filepath);

end
