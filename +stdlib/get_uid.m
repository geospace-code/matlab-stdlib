%% GET_UID tell UID (numeric) of current user
%
%%% Inputs
% * backend: preferred backend(s)
%%% Outputs
% * i: UID of current user
% * b: backend used

function [i, b] = get_uid(backend)
arguments
  backend (1,:) string = string.empty
end

[i, b] = getUsingBackend(backend, mfilename);

end
