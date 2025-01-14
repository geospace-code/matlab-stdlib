%% GET_PERMISSIONS permissions of file or directory
%
% output is char like 'rwxrwxr--'

function p = get_permissions(f)
arguments
  f (1,1) string
end

p = '';

try
  perms = filePermissions(f);
  p = perm2char(perms);
catch e
  if ~strcmp(e.identifier, "MATLAB:UndefinedFunction") && ...
      ~strcmp(e.identifier, "Octave:undefined-function")
    rethrow(e)
  end

  [status, v] = fileattrib(f);
  if status == 0
    return
  end
  p = perm2char(v);
end

end


function p = perm2char(v)

p = '---------';

try
  % filePermissions object
  if v.Readable,  p(1) = 'r'; end
  if v.Writable,  p(2) = 'w'; end
catch e
  if ~strcmp(e.identifier, "MATLAB:nonExistentField") && ...
      ~strcmp(e.identifier, "Octave:invalid-indexing")
    rethrow(e)
  end

  if v.UserRead,  p(1) = 'r'; end
  if v.UserWrite, p(2) = 'w'; end
end

% on Windows, any readable file has executable permission
if ispc
  if p(1) == 'r'
    p(3) = 'x';
  end
else
  if v.UserExecute, p(3) = 'x'; end
end

% Windows doesn't have these permissions

try
  if v.GroupRead,     p(4) = 'r'; end
  if v.GroupWrite,    p(5) = 'w'; end
  if v.GroupExecute,  p(6) = 'x'; end
  if v.OtherRead,     p(7) = 'r'; end
  if v.OtherWrite,    p(8) = 'w'; end
  if v.OtherExecute,  p(9) = 'x'; end
catch e
  if ~strcmp(e.identifier, "MATLAB:nologicalnan") && ...
     ~strcmp(e.identifier, "MATLAB:nonExistentField") && ...
     ~strcmp(e.identifier, "MATLAB:noSuchMethodOrField") && ...
      ~strcmp(e.message, "invalid conversion from NaN to logical")
    rethrow(e)
  end
end

end

%!assert(length(get_permissions('get_permissions.m')) == 9)
