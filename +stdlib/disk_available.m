%% DISK_AVAILABLE disk available space (bytes)
%
% example:  stdlib.disk_available('/')
%
%%% inputs
% * file: path to check
%%% Outputs
% * f: free disk space (bytes)
% * b: backend used
%
% Ref: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getUsableSpace()

function [i, b] = disk_available(file, backend)
arguments
  file {mustBeTextScalar}
  backend (1,:) string = ["java", "dotnet", "python", "shell"]
end

i = uint64([]);

for b = backend
  switch b
    case 'dotnet'
      i = stdlib.dotnet.disk_available(file);
    case 'java'
      i = stdlib.java.disk_available(file);
    case 'python'
      if stdlib.has_python()
        i = stdlib.python.disk_available(file);
      end
    case 'shell'
      i = stdlib.shell.disk_available(file);
    otherwise
      error('stdlib:disk_available:ValueError', 'Unknown backend: %s', b)
  end

  if ~isempty(i)
    return
  end
end

end
