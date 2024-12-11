%% IS_ABSOLUTE is path absolute?
% on Windows, absolute paths must be at least 3 character long, starting with a root name followed by a slash
% on non-Windows, absolute paths must start with a slash


function isabs = is_absolute(p, use_java)
% arguments
%   p (1,1)
%   use_java (1,1) logical = false
% end
if nargin < 2, use_java = false; end

if stdlib.isoctave()
  % not is_absolute_filename() because this is a stricter check for "c:" false
  isabs = javaObject("java.io.File", p).isAbsolute();
elseif use_java
  % java is about 5x to 10x slower than intrinsic
  % https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/io/File.html#isAbsolute()
  isabs = java.io.File(p).toPath().isAbsolute();
else
  L = strlength(p);
  if ispc
    s = "";
    if L > 2
      s = extractBetween(p, 3, 3);
    end
    isabs = L > 2 && strlength(stdlib.root_name(p)) && (strcmp(s, '/') || strcmp(s, '\'));
  else
    isabs = L >= 1 && startsWith(p, "/");
  end
end

end

%!assert(is_absolute(''), false)
%!test
%! if ispc
%!   assert(is_absolute('C:\'))
%!   assert(is_absolute('C:/'))
%!   assert(!is_absolute('C:'))
%!   assert(!is_absolute('C'))
%! else
%!   assert(is_absolute('/'))
%!   assert(is_absolute('/usr'))
%!   assert(!is_absolute('usr'))
%! endif
