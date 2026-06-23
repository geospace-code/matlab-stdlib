%% GET_UID tell UID (numeric) of current user
%
%%% Inputs
% * backend: preferred backend(s)
%%% Outputs
% * n: UID of current user
% * b: backend used

function [i, b] = get_uid(backend)
arguments
  backend (1,:) string = ["dotnet", "python", "perl"]
end

i = missing;

for b = backend
  switch b
    case 'dotnet'
      i = stdlib.dotnet.get_uid();
    case 'python'
      if stdlib.has_python()
        i = stdlib.python.get_uid();
      end
    case 'perl'
      i = stdlib.perl.get_uid();
    otherwise
      error('stdlib:get_uid:ValueError', 'Unknown backend: %s', b)
  end

  if ~ismissing(i)
    return
  end
end

end
