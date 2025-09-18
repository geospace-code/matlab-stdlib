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
if nargin < 1
  backend = {'sys', 'python', 'dotnet', 'java'};
else
  backend = cellstr(backend);
end

os = '';
version = '';

for j = 1:numel(backend)
  b = backend{j};
  switch b
    case 'java'
      [os, version] = stdlib.java.os_version();
    case 'dotnet'
      [os, version] = stdlib.dotnet.os_version();
    case 'python'
      if stdlib.matlabOlderThan('R2022a'), continue, end
      [os, version] = stdlib.python.os_version();
    case 'sys'
      [os, version] = stdlib.sys.os_version();
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
