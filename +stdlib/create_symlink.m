%% CREATE_SYMLINK create symbolic link
%
%%% inputs
% * target: path to link to
% * link: path to create link at
%%% Outputs
% * i: true if successful
% * b: backend used
%
% Some Windows Matlab R2025a give error 'MATLAB:io:filesystem:symlink:NeedsAdminPerms'
% For example, Matlab 25.1.0.2973910 R2025a Update 1 gave this error.

function [i, b] = create_symlink(target, link, backend)
if nargin < 3
  backend = {'native', 'dotnet', 'python', 'sys'};
else
  backend = string(backend);
end

i = logical([]);

for j = 1:numel(backend)
  b = backend{j};
  switch b
    case 'native'
      i = stdlib.native.create_symlink(target, link);
    case 'dotnet'
      i = stdlib.dotnet.create_symlink(target, link);
    case 'python'
      if stdlib.matlabOlderThan('R2022a'), continue, end
      i = stdlib.python.create_symlink(target, link);
    case 'sys'
      i = stdlib.sys.create_symlink(target, link);
    otherwise
      error('stdlib:create_symlink:ValueError', 'Unknown backend: %s', b)
  end

  if ~isempty(i)
    return
  end
end

end
