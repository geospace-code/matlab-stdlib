%% GET_PERMISSIONS permissions of file or directory
%
% output is string like "rwxrwxr--"

function p = get_permissions(f)
arguments
  f (1,1) string
end

p = "";

% Get the permissions of a file or directory
[status, v] = fileattrib(f);
if status == 0
  return
end

% Extract the permission string
p = "---------"; % Default permissions

groupRead = ~isnan(v.GroupRead) && logical(v.GroupRead);
groupWrite = ~isnan(v.GroupWrite) && logical(v.GroupWrite);
groupExecute = ~isnan(v.GroupExecute) && logical(v.GroupExecute);
otherRead = ~isnan(v.OtherRead) && logical(v.OtherRead);
otherWrite = ~isnan(v.OtherWrite) && logical(v.OtherWrite);
otherExecute = ~isnan(v.OtherExecute) && logical(v.OtherExecute);

try

if v.UserRead,    p = replaceBetween(p, 1, 1, "r"); end
if v.UserWrite,   p = replaceBetween(p, 2, 2, "w"); end
if v.UserExecute, p = replaceBetween(p, 3, 3, "x"); end
if groupRead,     p = replaceBetween(p, 4, 4, "r"); end
if groupWrite,    p = replaceBetween(p, 5, 5, "w"); end
if groupExecute,  p = replaceBetween(p, 6, 6, "x"); end
if otherRead,     p = replaceBetween(p, 7, 7, "r"); end
if otherWrite,    p = replaceBetween(p, 8, 8, "w"); end
if otherExecute,  p = replaceBetween(p, 9, 9, "x"); end

catch e
  if ~strcmp(e.identifier, "Octave:undefined-function")
    rethrow(e)
  end

  if v.UserRead,    p(1) = "r"; end
  if v.UserWrite,   p(2) = "w"; end
  if v.UserExecute, p(3) = "x"; end
  if groupRead,     p(4) = "r"; end
  if groupWrite,    p(5) = "w"; end
  if groupExecute,  p(6) = "x"; end
  if otherRead,     p(7) = "r"; end
  if otherWrite,    p(8) = "w"; end
  if otherExecute,  p(9) = "x"; end
end

end

%!assert(length(get_permissions('get_permissions.m')) == 9)
