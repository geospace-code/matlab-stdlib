%% OS_VERSION Get operating system name and version.
%
% Note: for Windows 11, need new-enough Java version to show Windows 11
% instead of Windows 10.
%
%%% Outputs
% * os: operating system name
% * version: operating system version
% * b: backend used
%
% Ref: https://bugs.openjdk.org/browse/JDK-8274840

function [os, version, b] = os_version(backend)
arguments
  backend (1,:) string = ["shell", "python", "dotnet", "java"];
end

os = '';
version = '';

for b = backend
  switch b
    case 'java'
      [os, version] = stdlib.java.os_version();
    case 'dotnet'
      [os, version] = stdlib.dotnet.os_version();
    case 'python'
      if stdlib.has_python()
        [os, version] = stdlib.python.os_version();
      end
    case 'shell'
      [os, version] = stdlib.shell.os_version();
    otherwise
      error('stdlib:os_version:ValueError', 'Unknown backend: %s', b)
  end

  if ~isempty(os) && ~isempty(version)
    return
  end
end

end


%!test
%! [o, v] = stdlib.os_version();
%! assert(~isempty(o))
%! assert(~isempty(v))
