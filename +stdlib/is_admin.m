%% IS_ADMIN is the process run as root / admin
%
%%% Outputs
% * i: true if process is run as root / admin
% * b: backend used

function [i, b] = is_admin(backend)
if nargin < 1
  backend = {'java', 'dotnet', 'perl', 'python', 'sys'};
else
  backend = cellstr(backend);
end

i = logical([]);

for j = 1:numel(backend)
  b = backend{j};
  switch b
    case "java"
      i = stdlib.java.is_admin();
    case "dotnet"
      i = stdlib.dotnet.is_admin();
    case "perl"
      i = stdlib.perl.is_admin();
    case "python"
      if stdlib.matlabOlderThan('R2022a'), continue, end
      i = stdlib.python.is_admin();
    case "sys"
      i = stdlib.sys.is_admin();
    otherwise
      error("stdlib:is_admin:ValueError", "Unknown backend: %s", b)
  end

  if ~isempty(i)
    return
  end
end

end

%!assert (islogical(stdlib.is_admin()))