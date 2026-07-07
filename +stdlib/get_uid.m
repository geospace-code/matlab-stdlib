%% GET_UID tell UID (numeric) of current user
%
%%% Inputs
% * backend: preferred backend(s)
%%% Outputs
% * i: UID of current user
% * b: backend used

function [i, b] = get_uid(backend)
arguments
  backend (1,:) string {mustBeNonempty} = ["dotnet", "python", "perl"]
end

i = missing;

for b = filterBackend(backend)
  f = str2func("stdlib." + b + ".get_uid");
  i = f();

  if ~ismissing(i)
    return
  end
end

end
