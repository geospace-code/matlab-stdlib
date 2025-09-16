function s = jPosix(o)

  s = o;

  if isempty(o)
    s = "";
  elseif isa(o, 'java.io.File') || isa(o, 'java.nio.file.Path') || ...
         isa(o, 'sun.nio.fs.UnixPath') || isa(o, 'sun.nio.fs.WindowsPath')
    s = o.toString();
  end

  s = stdlib.posix(s);

end
