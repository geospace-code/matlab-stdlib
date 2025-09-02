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
arguments
  file (1,1) string
end

perm = '';
b = '';

if stdlib.exists(file)
  try
    perm = perm2char(filePermissions(file));
    b = 'native';
  catch e
    if e.identifier ~= "MATLAB:UndefinedFunction"
      rethrow(e)
    end

    perm = perm2char(stdlib.legacy.file_attributes(file));
    b = 'legacy';
  end
end

end
