%% IS_ADMIN is the process run as root / admin
%
%%% Outputs
% * i: true if process is run as root / admin
% * b: backend used

function [i, b] = is_admin(backend)
arguments
  backend (1,:) string = string.empty
end

[i, b] = getUsingBackend(backend, mfilename);

end
