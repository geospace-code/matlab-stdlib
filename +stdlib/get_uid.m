%% GET_UID tell UID (numeric) of current user
%
%%% Inputs
% * backend: preferred backend(s)
%%% Outputs
% * n: UID of current user
% * b: backend used

function [i, b] = get_uid(backend)
if nargin < 1
  backend = ["dotnet", "python", "perl"];
else
  backend = string(backend);
end

i = [];

for b = backend
  switch b
    case 'dotnet'
      i = stdlib.dotnet.get_uid();
    case 'python'
      if stdlib.matlabOlderThan('R2022a'), continue, end
      i = stdlib.python.get_uid();
    case 'perl'
      i = stdlib.perl.get_uid();
    otherwise
      error("stdlib:get_uid:ValueError", "Unknown backend: %s", b)
  end

  if ~isempty(i)
    return
  end
end

end
