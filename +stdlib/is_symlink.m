%% IS_SYMLINK is path a symbolic link

function ok = is_symlink(p)
arguments
  p {mustBeTextScalar}
end

if ~isMATLABReleaseOlderThan('R2024b')
  ok = isSymbolicLink(p);
elseif stdlib.has_dotnet()
  ok = stdlib.dotnet.is_symlink(p);
elseif stdlib.has_java()
  ok = stdlib.java.is_symlink(p);
elseif stdlib.has_python()
  ok = stdlib.python.is_symlink(p);
elseif stdlib.isoctave()
  % use lstat() to work with a broken symlink, like Matlab isSymbolicLink
  [s, err] = lstat(p);
  ok = err == 0 && S_ISLNK(s.mode);
else
  ok = stdlib.sys.is_symlink(p);
end

end


%!test
%! if !ispc
%! p = tempname();
%! assert(create_symlink("is_symlink.m", p))
%! assert(is_symlink(p), p)
%! delete(p)
%! endif
