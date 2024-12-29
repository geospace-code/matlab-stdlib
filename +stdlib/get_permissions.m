%% GET_PERMISSIONS permissions of file or directory
%
% output is char like 'rwxrwxr--'

function p = get_permissions(f)
arguments
  f (1,1) string
end

p = '';

if ~stdlib.isoctave() && ~stdlib.too_old('R2025a')
  perms = filePermissions(f);
  p = perm2char(perms);
% elseif ~ispc && ~isMATLABReleaseOlderThan('R2024b')
% % undocumented internals in Matlab R2024b, does not work on Windows
%   perms = matlab.io.UnixPermissions(f);
%   p = perm2str(perms);
else
  [status, v] = fileattrib(f);
  if status == 0
    return
  end
  p = perm2char(v);
end

end


function p = perm2char(v)

p = '---------';

groupRead = ~isnan(v.GroupRead) && logical(v.GroupRead);
groupWrite = ~isnan(v.GroupWrite) && logical(v.GroupWrite);
groupExecute = ~isnan(v.GroupExecute) && logical(v.GroupExecute);
otherRead = ~isnan(v.OtherRead) && logical(v.OtherRead);
otherWrite = ~isnan(v.OtherWrite) && logical(v.OtherWrite);
otherExecute = ~isnan(v.OtherExecute) && logical(v.OtherExecute);

if isstruct(v) % from fileattrib
  if v.UserRead,  p(1) = 'r'; end
  if v.UserWrite, p(2) = 'w'; end
else % filePermissions object
  if v.Readable,  p(1) = 'r'; end
  if v.Writable,  p(2) = 'w'; end
end

if v.UserExecute, p(3) = 'x'; end
if groupRead,     p(4) = 'r'; end
if groupWrite,    p(5) = 'w'; end
if groupExecute,  p(6) = 'x'; end
if otherRead,     p(7) = 'r'; end
if otherWrite,    p(8) = 'w'; end
if otherExecute,  p(9) = 'x'; end

end

%!assert(length(get_permissions('get_permissions.m')) == 9)
