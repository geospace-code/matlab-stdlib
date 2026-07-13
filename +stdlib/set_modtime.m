%% SET_MODTIME set modification time of path
%
%%% Inputs
% * file: path to modify
% * time: new modification time
% * backend: backend to use (optional)
%%% Outputs
% * i: true if successful
% * b: backend used

function [i, b] = set_modtime(file, time, backend)
arguments
  file {mustBeTextScalar, mustBeFile}
  time (1,1) datetime
  backend (1,:) string = string.empty
end

[i, b] = getUsingBackend(backend, mfilename, file, time);

end
