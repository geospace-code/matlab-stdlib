function r = relative_to(base, other)
arguments
  base (1,1) string
  other (1,1) string
end

% must remove trailing slashes
base = stdlib.fileio.normalize(base);
other = stdlib.fileio.normalize(other);

if base == other
  r = ".";
else
  b = java.io.File(base).toPath();
  o = java.io.File(other).toPath();
  try
    r = stdlib.fileio.posix(b.relativize(o));
  catch e
    if contains(e.message, 'java.lang.IllegalArgumentException')
      r = "";
    else
      rethrow(e);
    end
  end
end

end
