%% PARENT parent directory of path
%

function p = parent(pth)
arguments
  pth (1,1) string
end

% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getParent()
% java was 10x slower and not correct for input like C:

p = stdlib.drop_slash(pth);

if is_root_stub(p)
  % 2 or 3 char drive letter
  p = stdlib.root(pth, false);
  return
end

j = strfind(p, '/');
if isempty(j)
  p = "";
elseif stdlib.isoctave()
  p = p(1:j(end)-1);
else
  p = extractBefore(p, j(end));
end

if is_root_stub(p)
  p = stdlib.root(pth, false);
  return
end


if ~stdlib.len(p)
  p = ".";
end

p = stdlib.posix(p);

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
%!   assert(parent('c:/foo'), 'c:/')
%!   assert(parent('c:\foo\'), 'c:/')
%!   assert(parent('c:\'), 'c:/')
%!   assert(parent('c:'), 'c:/')
%! end
