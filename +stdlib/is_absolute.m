%% IS_ABSOLUTE is path absolute?
%
%!assert(is_absolute('', false), false)
%!test
%! if ispc
%!   assert(is_absolute('C:\', false), true)
%!   assert(is_absolute('C:/', false), true)
%!   assert(is_absolute('C:', false), false)
%!   assert(is_absolute('C', false), false)
%! else
%!   assert(is_absolute('/', false), true)
%!   assert(is_absolute('/usr', false), true)
%!   assert(is_absolute('usr', false), false)
%! endif

function isabs = is_absolute(p, use_java)
arguments
  p (1,1)
  use_java (1,1) logical = false
end

if use_java
  % java is about 5x to 10x slower than intrinsic
  % https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/io/File.html#isAbsolute()
  isabs = java.io.File(p).toPath().isAbsolute();
elseif ischar(p)
  L = length(p);
  if ispc
    isabs = L > 2 && ~isempty(stdlib.root_name(p)) && (p(3) == '\' || p(3) == '/');
  else
    isabs = L >= 1 && p(1) == '/';
  end
else
  L = strlength(p);
  if ispc
    isabs = L > 2 && strlength(stdlib.root_name(p)) && any(extractBetween(p, 3, 3) == ["/", "\"]);
  else
    isabs = L >= 1 && startsWith(p, "/");
  end
end

end
