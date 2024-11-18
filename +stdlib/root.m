%% ROOT get root of path

function r = root(p, use_java)
arguments
  p (1,1) string
  use_java (1,1) logical = false
end

if use_java
  r = string(java.io.File(p).toPath().getRoot());
else

  r = "";
  if ~stdlib.is_absolute(p)
    return
  end

  if ispc
    r = extractBetween(p, 1, 2) + "/";
  else
    r = "/";
  end

end

end
