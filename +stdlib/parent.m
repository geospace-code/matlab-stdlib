%% PARENT parent directory of path
%

function p = parent(pth, use_java)
arguments
  pth (1,1) string
  use_java (1,1) logical = false
end

p = stdlib.drop_slash(pth);

if ~stdlib.len(p)
  p = ".";
  return
elseif is_root_stub(p)
  % 2 or 3 char drive letter
  if stdlib.len(p) == 2
    p = strcat(p, "/");
  end
  return
elseif strcmp(p, stdlib.root(p, use_java))
  return
end


if use_java
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getParent()
% Java is about 20x slower than pure Matlab
p = jPosix(javaFileObject(p).getParent());

else

j = strfind(p, '/');
if isempty(j)
  p = "";
elseif ischar(p)
  p = p(1:j(end)-1);
else
  p = extractBefore(p, j(end));
end

if is_root_stub(p)
  p = stdlib.root(pth, false);
  return
end

p = stdlib.posix(p);

end

if ~stdlib.len(p)
  p = ".";
end

end


function s = is_root_stub(p)
  s = ispc() && any(stdlib.len(p) == [2,3]) && stdlib.len(stdlib.root_name(p));
end


%!assert(parent("/a/b/c"), "/a/b")
%!assert(parent("/a/b/c/"), "/a/b")
%!assert(parent('/a///b'), '/a')
%!assert(parent('a/b/'), 'a')
%!assert(parent('a//b/'), 'a')
%!assert(parent('a//b'), 'a')
%!test
%! if ispc
%!   assert(parent('c:/a'), 'c:/')
%!   assert(parent('c:\a\'), 'c:/')
%!   assert(parent('c:\'), 'c:/')
%!   assert(parent('c:'), 'c:/')
%! end
