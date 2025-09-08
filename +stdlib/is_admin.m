%% IS_ADMIN is the process run as root / admin
%
%%% Outputs
% * i: true if process is run as root / admin
% * b: backend used

function [i, b] = is_admin(backend)
arguments
  backend (1,:) string = ["java", "dotnet", "perl", "python", "sys"]
end

i = logical.empty;

for b = backend
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
