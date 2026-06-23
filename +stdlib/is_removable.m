%% IS_REMOVABLE - Check if a file path is on a removable drive
% Not necessarily perfectly reliable at detection, but works for most cases.
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
% * i: true if path is on a removable drive
% * b: backend used

function [i, b] = is_removable(file, backend)
arguments
  file {mustBeTextScalar, mustBeFileOrFolder}
  backend (1,:) string = ["python", "shell"]
end


i = missing;

for b = backend
  switch b
    case 'python'
      if stdlib.has_python()
        i = stdlib.python.is_removable(file);
      end
    case 'shell'
      i = stdlib.shell.is_removable(file);
    otherwise
      error('stdlib:is_removable:ValueError', 'Unknown backend: %s', b)
  end

  if ~ismissing(i)
    return
  end
end

end
