%% JOIN join two paths with posix file separator

function p = join(base, other, use_java)
% arguments
%   base (1,1) string
%   other (1,1) string
%   use_java (1,1) logical = false
% end
if nargin < 3, use_java = false; end

b = stdlib.drop_slash(base);
o = stdlib.drop_slash(other);

Lb = stdlib.len(b);
Lo = stdlib.len(o);

if ~Lb && ~Lo
  p = "";
  return
end

if ~Lb
  p = o;
  return
end

if ~stdlib.len(o)
  p = b;
  return
end

if stdlib.isoctave()
  p = javaObject("java.io.File", b).toPath().resolve(o).toString();
elseif use_java
  p = string(java.io.File(b).toPath().resolve(o));
else

if startsWith(o, "/") || (ispc && stdlib.is_absolute(o))
  p = o;
  return
end

p = b + "/" + o;

end

p = stdlib.posix(p);

end

%!assert(join("", ""), "")
%!assert(join("", "b"), "b")
%!assert(join("a", ""), "a")
%!assert(join("a", "b"), "a/b")
%!assert(join("a", "/b/c"), "/b/c")
