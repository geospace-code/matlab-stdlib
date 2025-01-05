%% RELATIVE_TO relative path to base

function r = relative_to(base, other)
arguments
  base (1,1) string
  other (1,1) string
end

% must remove trailing slashes
b1 = stdlib.drop_slash(base);
o1 = stdlib.drop_slash(other);

b1 = strrep(b1, "/./", "/");
o1 = strrep(o1, "/./", "/");

if strcmp(b1, o1)
  r = ".";
  return
end

b = javaPathObject(b1);
o = javaPathObject(o1);

try
  w = contains(b1, "..");
catch e
  if strcmp(e.identifier, "Octave:undefined-function")
    w = ~isempty(strfind(b1, "..")); %#ok<STREMP>
  else
    rethrow(e);
  end
end

if w
  warning("relative_to(%s) is ambiguous base with '..'  consider using stdlib.canonical() first", b1)
end

try
  r = jPosix(b.relativize(o));
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
