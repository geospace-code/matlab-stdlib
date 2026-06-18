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
  backend (1,:) string = ["java", "python", "shell"]
end

i = logical([]);

for b = backend
  switch b
    case 'java'
      i = stdlib.java.set_modtime(file, time);
    case 'python'
      if stdlib.has_python()
        i = stdlib.python.set_modtime(file, time);
      end
    case 'shell'
      i = stdlib.shell.set_modtime(file, time);
    otherwise
      error('stdlib:set_modtime:ValueError', 'Unknown backend: %s', b)
  end

  if ~isempty(i)
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
