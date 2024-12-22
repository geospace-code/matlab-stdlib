%% IS_SYMLINK is it a symbolic link
%
% Ref:
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#isSymbolicLink(java.nio.file.Path)

function ok = is_symlink(p)
arguments
  p (1,1) string
end

if stdlib.isoctave()
  p = stdlib.absolute(p, "", false, true);
  op = javaObject("java.io.File", p).toPath();
  ok = javaMethod("isSymbolicLink", "java.nio.file.Files", op);
elseif isMATLABReleaseOlderThan("R2024b")
  % must be absolute path
  % NOT .canonical or symlink is gobbled!
  p = stdlib.absolute(p, "", false, true);
  ok = java.nio.file.Files.isSymbolicLink(java.io.File(p).toPath());
else
  ok = isSymbolicLink(p);
end

end

%!test
%! if !ispc
%! p = tempname();
%! assert(create_symlink(mfilename("fullpath"), p))
%! assert(is_symlink(p))
%! endif
