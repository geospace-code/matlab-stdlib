%% IS_ADMIN is the process run as root / admin
%
%% Outputs
% * ok: true if process is run as root / admin
% * b: backend used

function [ok, b] = is_admin(backend)
arguments
  backend (1,:) string = ["java", "dotnet", "python", "sys"]
end

o = stdlib.Backend(mfilename(), backend);
ok = o.func();
b = o.backend;

end
