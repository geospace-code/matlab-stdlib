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
arguments
  file {mustBeTextScalar}
  backend (1,:) string = ["java", "dotnet", "python", "shell"]
end

r = missing;

for b = backend
  switch b
    case 'java'
      r = stdlib.java.filesystem_type(file);
    case 'dotnet'
      r = stdlib.dotnet.filesystem_type(file);
    case 'python'
      if stdlib.has_python()
        r = stdlib.python.filesystem_type(file);
      end
    case 'shell'
      r = stdlib.shell.filesystem_type(file);
    otherwise
      error('stdlib:filesystem_type:ValueError', 'Unknown backend: %s', b)
  end

  if ~ismissing(r)
    return
  end
end

end
