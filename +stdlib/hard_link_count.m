%% HARD_LINK_COUNT get the number of hard links to a file
%
%
% Ref:
% * https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#getPosixFileAttributes(java.nio.file.Path,java.nio.file.LinkOption...)
% * https://docs.oracle.com/javase/tutorial/essential/io/links.html

function c = hard_link_count(p)
arguments
  p {mustBeTextScalar}
end

c = [];

if stdlib.has_python()
  c = uint64(int64(py.os.stat(p).st_nlink)); % int64 first is for Matlab <= R2022a
elseif stdlib.isoctave()
  [s, err] = stat(p);
  if err == 0
    c = s.nlink;
  end
elseif isunix() && stdlib.has_java()
  opt = javaMethod("values", "java.nio.file.LinkOption");
  c = java.nio.file.Files.getAttribute(javaPathObject(p), "unix:nlink", opt);
end

end

%!test
%! if ispc, return; end
%! assert(hard_link_count('hard_link_count.m') >= 1)
