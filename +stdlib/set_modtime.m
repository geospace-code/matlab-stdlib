%% SET_MODTIME set modification time of path
%
%%% Inputs
% * p: path to modify
% * t: new modification time
% * backend: backend to use
%%% Outputs
% * ok: true if successful
% * b: backend used

function [ok, b] = set_modtime(file, t, backend)
arguments
  file
  t (1,1) datetime
  backend (1,:) string = ["java", "python", "sys"]
end

[fun, b] = hbackend(backend, "set_modtime");

ok = fun(file, t);

end
