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
if nargin < 3
  backend = {'java', 'python', 'sys'};
else
  backend = cellstr(backend);
end

i = logical([]);

for j = 1:numel(backend)
  b = backend{j};
  switch b
    case 'java'
      i = stdlib.java.set_modtime(file, time);
    case 'python'
      if stdlib.matlabOlderThan('R2022a'), continue, end
      i = stdlib.python.set_modtime(file, time);
    case 'sys'
      i = stdlib.sys.set_modtime(file, time);
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