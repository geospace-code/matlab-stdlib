%% IS_DEV_DRIVE is path on a Windows Dev Drive developer volume
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
% * i: true if path is a Dev Drive
% * b: backend used

function [i, b] = is_dev_drive(file, backend)
if nargin < 2
  backend = {'python', 'sys'};
else
  backend = cellstr(backend);
end

i = logical([]);

for j = 1:numel(backend)
  b = backend{j};
  switch b
    case 'python'
      if stdlib.matlabOlderThan('R2022a'), continue, end
      i = stdlib.python.is_dev_drive(file);
    case 'sys'
      i = stdlib.sys.is_dev_drive(file);
    otherwise
      error('stdlib:is_dev_drive:ValueError', 'Unknown backend: %s', b)
  end

  if ~isempty(i)
    return
  end
end

end

%!assert (islogical(stdlib.is_dev_drive('.')))
