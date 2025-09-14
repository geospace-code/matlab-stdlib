%% NATIVE.PERM2CHAR convert file permissions to permission string

function p = perm2char(v)
arguments
  v {mustBeScalarOrEmpty}
end

if isempty(v)
  p = '';
  return
end


p = '---------';

switch class(v)
  case {'matlab.io.WindowsPermissions', 'matlab.io.UnixPermissions'}
    if v.Readable,  p(1) = 'r'; end
    if v.Writable,  p(2) = 'w'; end
  case 'struct'
    if v.UserRead,  p(1) = 'r'; end
    if v.UserWrite, p(2) = 'w'; end
  otherwise
    % cloud / remote locations we don't handle
    p = '';
    return
end

if isa(v, "matlab.io.WindowsPermissions") || ispc()

  if p(1) == 'r'
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
