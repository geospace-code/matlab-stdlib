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

o = stdlib.Backend(mfilename(), backend);
ok = o.func(file, t);
b = o.backend;

end
