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

if isunix() && stdlib.has_java()
  c = stdlib.java.hard_link_count(p);
elseif stdlib.has_python()
  c = stdlib.python.hard_link_count(p);
elseif stdlib.isoctave()
  [s, err] = stat(p);
  if err == 0
    c = s.nlink;
  end
end

end

%!test
%! if ispc, return; end
%! assert(hard_link_count('hard_link_count.m') >= 1)
