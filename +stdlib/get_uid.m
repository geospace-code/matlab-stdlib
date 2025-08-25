%% GET_UID tell UID (numeric) of current user
%
%% Outputs
% * n: UID of current user
% * b: backend used

function [n, b] = get_uid(backend)
arguments
  backend (1,:) string = ["dotnet", "python", "perl"]
end

o = stdlib.Backend(mfilename(), backend);
n = o.func();

b = o.backend;

end
