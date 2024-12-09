%% PROXIMATE_TO proximate path to base

function r = proximate_to(base, other)
arguments
  base (1,1) string
  other (1,1) string
end

r = stdlib.relative_to(base, other);
if stdlib.len(r) > 0
  return;
end

r = other;

end

%!assert(proximate_to("/a/b", "/a/b"), ".")
%!assert(proximate_to("/a/b", "/a/b/c"), "c")
%!assert(proximate_to("/a/b", "/a/b/c/"), "c")
%!assert(proximate_to("/a/b", "d"), "d")
