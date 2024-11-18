%% JOIN join two paths with posix file separator

function p = join(a, b, use_java)
arguments
  a (1,1) string
  b (1,1) string
  use_java (1,1) logical = false
end

if a == "" && b == ""
  p = "";
  return
end

a = stdlib.posix(a);
b = stdlib.posix(b);

if a == ""
  p = b;
  return
end

if b == ""
  p = a;
  return
end


if use_java

p = java.io.File(a).toPath().resolve(b);

else

if startsWith(b, "/") || (ispc && stdlib.is_absolute(b))
  p = b;
  return
end

p = a + "/" + b;

end

p = stdlib.normalize(p);

end
