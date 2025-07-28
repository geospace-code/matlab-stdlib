%% PARENT parent directory of path
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

if stdlib.has_java()
  p = stdlib.java.parent(pth);
elseif stdlib.has_python()
  p = stdlib.python.parent(pth);
else
  p = stdlib.native.parent(pth);
end

end

%!assert(parent("/a/b/c"), fullfile('/a','b'))
%!assert(parent("/a/b/c/"), fullfile('/a','b'))
%!assert(parent('/a///b'), fullfile('/a'))
%!assert(parent('a/b/'), 'a')
%!assert(parent('a//b/'), 'a')
%!assert(parent('a//b'), 'a')
%!test
%! if ispc
%!   assert(parent('c:/a'), 'c:\')
%!   assert(parent('c:\a\'), 'c:\')
%!   assert(parent('c:\'), 'c:\')
%!   assert(parent('c:'), 'c:\')
%! end
