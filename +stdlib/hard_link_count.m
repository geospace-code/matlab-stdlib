%% HARD_LINK_COUNT get the number of hard links to a file
%
% Ref:
% * https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#getPosixFileAttributes(java.nio.file.Path,java.nio.file.LinkOption...)
% * https://docs.oracle.com/javase/tutorial/essential/io/links.html

function c = hard_link_count(p)
arguments
  p (1,1) string
end

if ispc || ~isfile(p)
  c = [];
  return
end

op = javaPathObject(p);
opt = javaLinkOption();

if stdlib.isoctave()
  c = javaMethod("getAttribute", "java.nio.file.Files", op, "unix:nlink", opt);
else
  c = java.nio.file.Files.getAttribute(op, "unix:nlink", opt);
end

end

%!test
%! if ispc, return; end
%! assert(hard_link_count('hard_link_count.m') >= 1)
