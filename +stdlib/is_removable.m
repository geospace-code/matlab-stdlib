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
  file string
  backend (1,:) string = ["python", "sys"]
end

i = logical.empty;

for b = backend
  switch b
    case 'python'
      if stdlib.matlabOlderThan('R2022a'), continue, end
      i = stdlib.python.is_removable(file);
    case 'sys'
      i = stdlib.sys.is_removable(file);
    otherwise
      error("stdlib:is_removable:ValueError", "Unknown backend: %s", b)
  end

  if ~isempty(i)
    return
  end
end

end
