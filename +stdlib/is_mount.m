%% IS_MOUNT is filepath a mount path
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
% * ok: true if path is a mount point
% * b: backend used
%
% Examples:
%
% * Windows: is_mount('c:') false;  is_mount('C:\') true
% * Linux, macOS, Windows: is_mount('/') true

function [i, b] = is_mount(file, backend)
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
      i = stdlib.python.is_mount(file);
    case 'sys'
      i = stdlib.sys.is_mount(file);
    otherwise
      error('stdlib:is_mount:ValueError', 'Unknown backend: %s', b)
  end

  if ~isempty(i)
    return
  end
end

end

%!assert (islogical(stdlib.is_mount('.')))
