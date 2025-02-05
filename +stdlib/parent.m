%% PARENT parent directory of path
% optional: mex
%
%% Examples:
% parent("a/b/c") == "a/b"
% parent("a/b/c/") == "a/b"
%
% MEX is about 10x faster than plain Matlab for this function

function p = parent(pth)
arguments
  pth (1,1) string
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
elseif strcmp(p, stdlib.root(p))
  return
end


j = strfind(p, '/');
if isempty(j)
  p = "";
elseif ischar(p)
  p = p(1:j(end)-1);
else
  p = extractBefore(p, j(end));
end

if is_root_stub(p)
  p = stdlib.root(pth);
  return
end

p = stdlib.posix(p);

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
