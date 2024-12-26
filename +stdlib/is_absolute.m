%% IS_ABSOLUTE is path absolute?
% on Windows, absolute paths must be at least 3 character long, starting with a root name followed by a slash
% on non-Windows, absolute paths must start with a slash


function y = is_absolute(p, use_java)
arguments
  p (1,1) string
  use_java (1,1) logical = false
end

% not Octave is_absolute_filename() because this is a stricter check for "c:" false

if use_java
  % java is about 5x to 10x slower than intrinsic
  % https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/io/File.html#isAbsolute()
  y = javaFileObject(p).isAbsolute();

else
  y = false;
  L = stdlib.len(p);
  if ~L || (ispc && L < 3)
    return
  end

  if ispc
    if ischar(p)
      s = p(3); %#ok<UNRCH>
    else
      s = extractBetween(p, 3, 3);
    end
    y = stdlib.len(stdlib.root_name(p)) && (strcmp(s, '/') || strcmp(s, '\'));
  else
    y = strncmp(p, "/", 1);
  end

end

end

%!assert(is_absolute('',0), false)
%!test
%! if ispc
%!   assert(is_absolute('C:\', 0))
%!   assert(is_absolute('C:/', 0))
%!   assert(!is_absolute('C:', 0))
%!   assert(!is_absolute('C', 0))
%! else
%!   assert(is_absolute('/',0))
%!   assert(is_absolute('/usr',0))
%!   assert(!is_absolute('usr',0))
%! endif
