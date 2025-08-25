%% IS_REMOVABLE - Check if a file path is on a removable drive
% Not necessarily perfectly reliable at detection, but works for most cases.
%
%% Inputs
% * file: path to check
% * backend: backend to use
%
%% Outputs
% * ok: true if path is on a removable drive
% * b: backend used

function [ok, b] = is_removable(file, backend)
arguments
  file string
  backend (1,:) string = ["python", "sys"]
end

o = stdlib.Backend(mfilename(), backend);

if isscalar(file)
  ok = o.func(file);
else
  ok = arrayfun(o.func, file);
end

b = o.backend;

end
