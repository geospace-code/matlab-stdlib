%% JOIN join two paths with posix file separator

function p = join(base, other, use_java)
arguments
  base (1,1) string
  other (1,1) string
  use_java (1,1) logical = false
end


if use_java
  r = javaFileObject(base).toPath().resolve(other);
  p = jPosix(r);
else

b = stdlib.drop_slash(base);
o = stdlib.drop_slash(other);

if strncmp(o, "/", 1) || (ispc && stdlib.is_absolute(o, false))
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

%!assert(join("", "", 1), "")
%!assert(join("", "b", 1), "b")
%!assert(join("a", "", 1), "a")
%!assert(join("a", "b", 1), "a/b")
%!assert(join("a", "/b/c", 1), "/b/c")
