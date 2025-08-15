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

o = stdlib.Backend(mfilename(), backend);

if isscalar(file)
  n = o.func(file);
else
  n = arrayfun(o.func, file);
end

b = o.backend;

end
