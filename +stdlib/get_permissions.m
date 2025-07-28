%% GET_PERMISSIONS permissions of file or directory
%
% output is char like 'rwxrwxr--'

function p = get_permissions(f)
arguments
  f {mustBeTextScalar}
end

p = '';

if ~stdlib.exists(f), return, end

if ~isMATLABReleaseOlderThan('R2025a')
  v = filePermissions(f);
elseif stdlib.isoctave()
  [s, err] = stat(f);
  if err == 0
    p = s.modestr;
  end
  return
else
  v = stdlib.native.file_attributes(f);
end

p = perm2char(v, f);

end


function p = perm2char(v, f)
arguments
  v (1,1)
  f {mustBeTextScalar}
end


p = '---------';

if isa(v, "matlab.io.WindowsPermissions") || isa(v, "matlab.io.UnixPermissions")
  if v.Readable,  p(1) = 'r'; end
  if v.Writable,  p(2) = 'w'; end
elseif isstruct(v)
  if v.UserRead,  p(1) = 'r'; end
  if v.UserWrite, p(2) = 'w'; end
else
  % cloud / remote locations we don't handle
  p = '';
  return
end

if isa(v, "matlab.io.WindowsPermissions") || ispc()

  if p(1) == 'r' && stdlib.native.has_windows_executable_suffix(f)
    p(3) = 'x';
  end

  return

else

  if v.UserExecute, p(3) = 'x'; end

end

if v.GroupRead,     p(4) = 'r'; end
if v.GroupWrite,    p(5) = 'w'; end
if v.GroupExecute,  p(6) = 'x'; end
if v.OtherRead,     p(7) = 'r'; end
if v.OtherWrite,    p(8) = 'w'; end
if v.OtherExecute,  p(9) = 'x'; end

end

%!assert(length(get_permissions('get_permissions.m')) >= 9)
