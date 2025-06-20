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
  pth {mustBeTextScalar}
end

p = stdlib.drop_slash(pth);

if ~strlength(p)
  p = '.';
elseif is_root_stub(p)
  % 2 or 3 char drive letter
  if strlength(p) == 2
    p = strcat(p, '/');
  end
elseif strcmp(p, stdlib.root(p))
  % noop
else
  j = strfind(p, '/');
  if isempty(j)
    p = '';
  elseif ischar(p)
    p = p(1:j(end)-1);
  else
    p = p{1}(1:j(end)-1);
  end

  if is_root_stub(p)
    p = stdlib.root(pth);
    return
  end
end

if ~strlength(p)
  p = '.';
end

if isstring(pth)
  p = string(p);
end

end


function s = is_root_stub(p)
  s = ispc() && any(strlength(p) == [2,3]) && strlength(stdlib.root_name(p));
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
%!   assert(parent('c:\a\'), 'c:\')
%!   assert(parent('c:\'), 'c:/')
%!   assert(parent('c:'), 'c:/')
%! end
