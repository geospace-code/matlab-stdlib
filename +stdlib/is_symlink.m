%% IS_SYMLINK is path a symbolic link
% on Windows, distinguishes between symlinks and App Execution Aliases,
% which are not symlinks.

function ok = is_symlink(p)
arguments
  p (1,1) string
end


try
  ok = isSymbolicLink(p);
catch e
  % must be absolute path
  % NOT .canonical or symlink is gobbled!
  p = stdlib.absolute(p, "", false, true);
  op = javaFileObject(p).toPath();

% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#isSymbolicLink(java.nio.file.Path)
% https://dev.java/learn/java-io/file-system/links/

  if strcmp(e.identifier, "MATLAB:UndefinedFunction")
    ok = java.nio.file.Files.isSymbolicLink(op);
  elseif strcmp(e.identifier, "Octave:undefined-function")
    ok = javaMethod("isSymbolicLink", "java.nio.file.Files", op);
  else
    rethrow(e)
  end

end

end

%!test
%! if !ispc
%! p = tempname();
%! assert(create_symlink(mfilename("fullpath"), p))
%! assert(is_symlink(p))
%! endif
