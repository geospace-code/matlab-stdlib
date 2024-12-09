%% RELATIVE_TO relative path to base

function r = relative_to(base, other)
arguments
  base (1,1) string
  other (1,1) string
end

% must remove trailing slashes
b1 = stdlib.drop_slash(base);
o1 = stdlib.drop_slash(other);

if strcmp(b1, o1)
  r = ".";
  return
end

if stdlib.isoctave()
  b = javaObject("java.io.File", b1).toPath();
  o = javaObject("java.io.File", o1).toPath();
else
  b = java.io.File(b1).toPath();
  o = java.io.File(o1).toPath();
end

try
  r = stdlib.posix(b.relativize(o).toString());
catch e
  r = "";
  if stdlib.isoctave()
    if isempty(strfind(e.message, "'other' is different type of Path")) && isempty(strfind(e.message, "'other' has different root"))
      rethrow(e);
    end
  else
    if ~any(contains(e.message, ["'other' is different type of Path", "'other' has different root"]))
      rethrow(e);
    end
  end
end

end

%!assert(relative_to("/a/b", "/a/b"), ".")
%!assert(relative_to("/a/b", "/a/b/c"), "c")
%!assert(relative_to("/a/b", "/a/b/c/"), "c")
%!assert(relative_to("/a/b", "d"), "")
