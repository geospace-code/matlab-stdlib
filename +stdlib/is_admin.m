%% IS_ADMIN is the process run as root / admin
%
%%% Outputs
% * i: true if process is run as root / admin
% * b: backend used

function [i, b] = is_admin(backend)
arguments
  backend (1,:) string {mustBeNonempty} = ["java", "dotnet", "perl", "python", "shell"]
end

i = missing;

for b = filterBackend(backend)
  f = str2func("stdlib." + b + ".is_admin");
  i = f();

  if ~ismissing(i)
    return
  end
end

end
