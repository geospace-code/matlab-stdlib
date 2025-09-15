%% IS_DEV_DRIVE is path on a Windows Dev Drive developer volume
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
% * i: true if path is a Dev Drive
% * b: backend used

function [i, b] = is_dev_drive(file, backend)
arguments
  file
  backend (1,:) string = ["python", "sys"]
end

i = logical.empty;

for b = backend
  switch b
    case 'python'
      if stdlib.matlabOlderThan('R2022a'), continue, end
      i = stdlib.python.is_dev_drive(file);
    case 'sys'
      i = stdlib.sys.is_dev_drive(file);
    otherwise
      error("stdlib:is_dev_drive:ValueError", "Unknown backend: %s", b)
  end

  if ~isempty(i)
    return
  end
end

end
