%% GET_OWNER owner name of file or directory
%
%%% Inputs
% * file: path to examine
% * backend: backend to use
%%% Outputs
% * r: owner, or empty if path does not exist
% * b: backend used

function [r, b] = get_owner(file, backend)
arguments
  file
  backend (1,:) string = ["java", "dotnet", "python", "sys"]
end

r = '';

for b = backend
  switch b
    case "java"
      r = stdlib.java.get_owner(file);
    case "dotnet"
      r = stdlib.dotnet.get_owner(file);
    case "python"
      if stdlib.matlabOlderThan('R2022a'), continue, end
      r = stdlib.python.get_owner(file);
    case "sys"
      r = stdlib.sys.get_owner(file);
    otherwise
      error("stdlib:get_owner:ValueError", "Unknown backend: %s", b)
  end

  if ~isempty(r)
    return
  end
end

end
