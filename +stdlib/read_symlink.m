%% READ_SYMLINK read symbolic link
%
% empty string if path is not a symlink

function r = read_symlink(p)
arguments
  p (1,1) string
end

r = "";

if stdlib.isoctave()
  t = readlink(p);
elseif isMATLABReleaseOlderThan("R2024b")
  if ~stdlib.is_symlink(p)
    return
  end

  % must be absolute path
  % must not be .canonical or symlink is gobbled!
  r = stdlib.absolute(p, "", false, true);

  % https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#readSymbolicLink(java.nio.file.Path)
  t = java.nio.file.Files.readSymbolicLink(java.io.File(r).toPath());
else
  [ok, t] = isSymbolicLink(p);
  if ~ok, return, end
end

r = stdlib.posix(t);

end

%!test
%! if !ispc
%! p = tempname();
%! this = strcat(mfilename("fullpath"), '.m');
%! assert (read_symlink(p), "")
%! assert (create_symlink(this, p))
%! assert (read_symlink(p), this)
%! endif
