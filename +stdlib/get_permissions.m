%% GET_PERMISSIONS permissions of file or directory
%
% output is char like 'rwxrwxr--'

function p = get_permissions(f)
arguments
  f {mustBeTextScalar}
end

p = '';

try
  v = filePermissions(f);
catch e
  switch e.identifier
    case "MATLAB:io:filesystem:filePermissions:CannotFindLocation", return
    case "Octave:undefined-function"
      [s, err] = stat(f);
      if err == 0
        p = s.modestr;
      end
      return
    case "MATLAB:UndefinedFunction"
      v = file_attributes(f);
      if isempty(v), return, end
    otherwise, rethrow(e)
  end
end

p = perm2char(v);

end


function p = perm2char(v)

p = '---------';

if isa(v, "matlab.io.WindowsPermissions") || isa(v, "matlab.io.UnixPermissions")
  if v.Readable,  p(1) = 'r'; end
  if v.Writable,  p(2) = 'w'; end
elseif isstruct(v)
  if v.UserRead,  p(1) = 'r'; end
  if v.UserWrite, p(2) = 'w'; end
else
  % cloud / remote locations we don't handle
  p = [];
  return
end


if isfield(v, 'UserExecute') || isa(v, "matlab.io.UnixPermissions")
  if v.UserExecute, p(3) = 'x'; end
elseif ispc() && (isstruct(v) || isa(v, "matlab.io.WindowsPermissions"))
  % on Windows, any readable file has executable permission
  if p(1) == 'r',     p(3) = 'x'; end
end


if isstruct(v) || isa(v, "matlab.io.UnixPermissions")

  if v.GroupRead,     p(4) = 'r'; end
  if v.GroupWrite,    p(5) = 'w'; end
  if v.GroupExecute,  p(6) = 'x'; end
  if v.OtherRead,     p(7) = 'r'; end
  if v.OtherWrite,    p(8) = 'w'; end
  if v.OtherExecute,  p(9) = 'x'; end

end

end

%!assert(length(get_permissions('get_permissions.m')) >= 9)
