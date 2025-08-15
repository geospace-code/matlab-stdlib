%% GET_USERNAME tell username of current user
%
%% Outputs
% * n: username of current user
% * b: backend used

function [n, b] = get_username(backend)
arguments
  backend (1,:) string = ["java", "dotnet", "python", "sys"]
end

o = stdlib.Backend(mfilename(), backend);
n = o.func();

b = o.backend;

end
