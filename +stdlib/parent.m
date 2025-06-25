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

f = fullfile(char(pth));
if endsWith(f, {'/', filesep}) && ~strcmp(f, stdlib.root(f))
  f = f(1:end-1);
end

p = fileparts(f);

if strempty(p)
  p = '.';
elseif ispc() && strcmp(p, stdlib.root_name(pth))
  p = strcat(p, filesep);
end

if isstring(pth)
  p = string(p);
end

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
