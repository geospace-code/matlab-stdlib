%% HARD_LINK_COUNT get the number of hard links to a file
% requires: java
%
% Ref:
% * https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#getPosixFileAttributes(java.nio.file.Path,java.nio.file.LinkOption...)
% * https://docs.oracle.com/javase/tutorial/essential/io/links.html

function c = hard_link_count(p)
arguments
  p {mustBeTextScalar}
end

c = [];

if stdlib.isoctave()
  [s, err] = stat(p);
  if err == 0
    c = s.nlink;
  end
elseif isunix()
  c = java.nio.file.Files.getAttribute(javaPathObject(p), "unix:nlink", javaLinkOption());
end

end

%!test
%! if ispc, return; end
%! assert(hard_link_count('hard_link_count.m') >= 1)
