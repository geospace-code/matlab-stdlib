%% JOIN join two paths with posix file separator

function p = join(base, other, use_java)
arguments
  base (1,1) string
  other (1,1) string
  use_java (1,1) logical = false
end


b = stdlib.drop_slash(base);
o = stdlib.drop_slash(other);

if use_java
  r = javaFileObject(b).toPath().resolve(o);
  p = jPosix(r);
else

if startsWith(o, "/") || (ispc && stdlib.is_absolute(o))
  p = o;
  return
end

p = b;
if strlength(o)
  if endsWith(p, "/")
    p = p + o;
  elseif strlength(p)
    p = p + "/" + o;
  else
    p = o;
  end
end

end

end

%!assert(join("", ""), "")
%!assert(join("", "b"), "b")
%!assert(join("a", ""), "a")
%!assert(join("a", "b"), "a/b")
%!assert(join("a", "/b/c"), "/b/c")
