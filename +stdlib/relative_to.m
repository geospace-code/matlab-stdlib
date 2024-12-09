%% RELATIVE_TO relative path to base

function r = relative_to(base, other)
arguments
  base (1,1) string
  other (1,1) string
end

% must remove trailing slashes
base = stdlib.drop_slash(base);
other = stdlib.drop_slash(other);

if strcmp(base, other)
  r = ".";
  return
end

if stdlib.isoctave()
  b = javaObject("java.io.File", base).toPath();
  o = javaObject("java.io.File", other).toPath();
else
  b = java.io.File(base).toPath();
  o = java.io.File(other).toPath();
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
