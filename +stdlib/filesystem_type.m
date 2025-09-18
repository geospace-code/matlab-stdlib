%% FILESYSTEM_TYPE tell type of filesystem
%
% example outputs: NTFS, ext4, apfs, ...
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
% * r: filesystem type
% * b: backend used

function [r, b] = filesystem_type(file, backend)
if nargin < 2
  backend = {'java', 'dotnet', 'python', 'sys'};
else
  backend = cellstr(backend);
end

r = '';

for j = 1:numel(backend)
  b = backend{j};
  switch b
    case 'java'
      r = stdlib.java.filesystem_type(file);
    case 'dotnet'
      r = stdlib.dotnet.filesystem_type(file);
    case 'python'
      if stdlib.matlabOlderThan('R2022a'), continue, end
      r = stdlib.python.filesystem_type(file);
    case 'sys'
      r = stdlib.sys.filesystem_type(file);
    otherwise
      error('stdlib:filesystem_type:ValueError', 'Unknown backend: %s', b)
  end

  if ~isempty(r)
    return
  end
end

end


%!assert (~isempty(stdlib.filesystem_type('.')))
