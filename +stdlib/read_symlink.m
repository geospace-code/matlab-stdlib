%% READ_SYMLINK read symbolic link
%
% empty string if path is not a symlink
% always of string class in Matlab

function r = read_symlink(p)
arguments
  p {mustBeTextScalar}
end

r = string.empty;

try
  [ok, r] = isSymbolicLink(p);
  if ~ok, r = string.empty; end
catch e
  switch e.identifier
    case "Octave:undefined-function", r = readlink(p);
    case "MATLAB:UndefinedFunction"
      if ~stdlib.is_symlink(p), return, end

      if stdlib.has_python()
        % https://docs.python.org/3/library/pathlib.html#pathlib.Path.readlink
        r = string(py.str(py.pathlib.Path(p).readlink()));
      elseif stdlib.has_dotnet() && stdlib.dotnet_api() >= 6
        r = System.IO.FileInfo(p).LinkTarget;
      elseif stdlib.has_java()
        % must be absolute path
        % must not be .canonical or symlink is gobbled!
        r = stdlib.absolute(p);
        % https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#readSymbolicLink(java.nio.file.Path)
        r = java.nio.file.Files.readSymbolicLink(javaPathObject(r)).string;
      end
    otherwise, rethrow(e)
  end
end

end

%!test
%! if !ispc
%! p = tempname();
%! this = strcat(mfilename("fullpath"), '.m');
%! assert (read_symlink(p), "")
%! assert (create_symlink(this, p))
%! assert (read_symlink(p), this)
%! endif
