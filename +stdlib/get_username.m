%% GET_USERNAME tell username of current user
%
%%% Inputs
% * backend: preferred backend(s)
%%% Outputs
% * i: username of current user
% * b: backend used

function [i, b] = get_username(backend)
arguments
  backend (1,:) string = string.empty
end

[i, b] = getUsingBackend(backend, mfilename);

end
