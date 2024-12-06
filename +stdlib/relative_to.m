%% RELATIVE_TO relative path to base

function r = relative_to(base, other)
arguments
  base (1,1) string
  other (1,1) string
end

% must remove trailing slashes
base = stdlib.drop_slash(base);
other = stdlib.drop_slash(other);

if base == other
  r = ".";
  return
end

b = java.io.File(base).toPath();
o = java.io.File(other).toPath();
try
  r = stdlib.posix(b.relativize(o));
catch e
  if contains(e.message, 'java.lang.IllegalArgumentException')
    r = "";
  else
    rethrow(e);
  end
end

end
