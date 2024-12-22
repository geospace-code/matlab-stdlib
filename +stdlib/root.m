%% ROOT get root path
% ROOT(P) returns the root path of P.
% root is the root_name + root_directory.


function r = root(p, use_java)
arguments
  p (1,1) string
  use_java (1,1) logical = false
end


r = "";
if stdlib.len(p) == 0
  return
end


if stdlib.isoctave()
  o = javaObject("java.io.File", p).toPath().getRoot();
  if ~isempty(o)
    r = stdlib.posix(o.toString());
  end
elseif use_java
  r = stdlib.posix(java.io.File(p).toPath().getRoot().toString());
else

  r = stdlib.root_name(p);

  if strlength(r) == 0
    if startsWith(p, "/")
      r = "/";
    end

    return
  end

  if ispc && r == p
    return
  end

  r = r + "/";

end

%!assert(root(''), '')
%!assert(root('/'), '/')
%!test
%! if ispc
%!   assert(root('C:\'), 'C:/')
%!   assert(root('C:/'), 'C:/')
%!   assert(root('C:'), 'C:')
%!   assert(root('C'), '')
%! endif
