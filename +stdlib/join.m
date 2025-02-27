%% JOIN join two paths with posix file separator

function p = join(base, other)
arguments
  base (1,1) string
  other (1,1) string
end


b = stdlib.posix(base);
o = stdlib.posix(other);

if startsWith(o, "/") || (ispc && stdlib.is_absolute(o))
  p = o;
  return
end

p = b;
if strlength(o)
  if endsWith(p, "/")
    p = strcat(p, o);
  elseif strlength(p)
    p = strcat(p, "/", o);
  else
    p = o;
  end
end

end

%!assert(join("", ""), "")
%!assert(join("", "b"), "b")
%!assert(join("a", ""), "a")
%!assert(join("a", "b"), "a/b")
%!assert(join("a", "/b/c"), "/b/c")
