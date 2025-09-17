%% GET_PERMISSIONS permissions of file or directory
%
% output is char like 'rwxrwxr--'
%
%%% inputs
% * file: path to check
%%% Outputs
% * p: permissions string
% * b: backend used

function [perm, b] = get_permissions(file)

try
  perm = perm2char(filePermissions(file));
  b = 'native';
catch e
  switch e.identifier
    case {'MATLAB:UndefinedFunction', 'Octave:undefined-function'}
      perm = perm2char(file_attributes(file));
      b = 'legacy';
    case 'MATLAB:io:filesystem:filePermissions:CannotFindLocation'
      perm = '';
      b = '';
    otherwise
      rethrow(e)
  end
end

end

%!test
%! addpath('private')
%! assert(length(stdlib.get_permissions('.')) > 8)