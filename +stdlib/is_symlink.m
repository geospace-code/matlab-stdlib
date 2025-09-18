%% IS_SYMLINK is path a symbolic link
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
% * i: true if path is a symbolic link
% * b: backend used

function [i, b] = is_symlink(file, backend)
if nargin < 2
  backend = {'native', 'java', 'python', 'dotnet', 'sys'};
else
  backend = cellstr(backend);
end

i = logical([]);

for j = 1:numel(backend)
  b = backend{j};
  switch b
    case 'java'
      i = stdlib.java.is_symlink(file);
    case 'native'
      i = stdlib.native.is_symlink(file);
    case 'dotnet'
      i = stdlib.dotnet.is_symlink(file);
    case 'python'
      if stdlib.matlabOlderThan('R2022a'), continue, end
      i = stdlib.python.is_symlink(file);
    case 'sys'
      i = stdlib.sys.is_symlink(file);
    otherwise
      error('stdlib:is_symlink:ValueError', 'Unknown backend: %s', b)
  end

  if ~isempty(i)
    return
  end
end

end


%!assert (islogical(stdlib.is_symlink('.')))
