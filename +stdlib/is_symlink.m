%% IS_SYMLINK is path a symbolic link

function ok = is_symlink(p)
arguments
  p {mustBeTextScalar}
end

try
  ok = isSymbolicLink(p);
catch e
  switch e.identifier
    case "MATLAB:UndefinedFunction"
      if stdlib.has_dotnet()
        if stdlib.dotnet_api() >= 6
          ok = ~isempty(System.IO.FileInfo(p).LinkTarget);
        else
          attr = string(System.IO.File.GetAttributes(p).ToString());
          % https://learn.microsoft.com/en-us/dotnet/api/system.io.fileattributes
          % ReparsePoint is for Linux, macOS, and Windows
          ok = contains(attr, 'ReparsePoint');
        end
      elseif stdlib.has_java()
        ok = java.nio.file.Files.isSymbolicLink(javaPathObject(stdlib.absolute(p)));
      elseif stdlib.has_python()
        ok = py.pathlib.Path(p).is_symlink();
      else
        ok = logical.empty;
      end
    case "Octave:undefined-function"
      % use lstat() to work with a broken symlink, like Matlab isSymbolicLink
      [s, err] = lstat(p);
      ok = err == 0 && S_ISLNK(s.mode);
    otherwise, rethrow(e)
  end
end

end


%!test
%! if !ispc
%! p = tempname();
%! assert(create_symlink("is_symlink.m", p))
%! assert(is_symlink(p), p)
%! delete(p)
%! endif
