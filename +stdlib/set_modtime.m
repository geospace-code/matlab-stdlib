%% SET_MODTIME set modification time of path
%
%%% Inputs
% * p: path to modify
% * t: new modification time
% * backend: backend to use
%%% Outputs
% * i: true if successful
% * b: backend used

function [i, b] = set_modtime(file, time, backend)
arguments
  file {mustBeTextScalar, mustBeFile}
  time (1,1) datetime
  backend (1,:) string {mustBeNonempty} = ["java", "python", "shell"]
end


i = missing;

for b = filterBackend(backend)
  f = str2func("stdlib." + b + ".set_modtime");
  i = f(file, time);

  if ~ismissing(i)
    return
  end
end

end

%!test
%! pkg load tablicious
%! f = tempname();
%! assert(stdlib.touch(f))
%! assert(stdlib.set_modtime(f, datetime('now')))
%! assert(stdlib.remove(f))
