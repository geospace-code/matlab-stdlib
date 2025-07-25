%% READ_SYMLINK read symbolic link
%
% empty string if path is not a symlink
% always of string class in Matlab

function r = read_symlink(p)
arguments
  p {mustBeTextScalar}
end

if ~isMATLABReleaseOlderThan('R2024b')
  [ok, r] = isSymbolicLink(p);
  if ~ok
    r = string.empty; 
  end
elseif stdlib.dotnet_api() >= 6
  r = stdlib.dotnet.read_symlink(p);
elseif stdlib.has_java()
  r = stdlib.java.read_symlink(p);
elseif stdlib.has_python()
  r = stdlib.python.read_symlink(p);
elseif stdlib.isoctave()
  r = readlink(p);
else
  r = stdlib.sys.read_symlink(p);
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
