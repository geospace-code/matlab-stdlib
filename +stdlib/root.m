%% ROOT get root path
% ROOT(P) returns the root path of P.
% root is the root_name + root_directory.


function r = root(p, use_java)
arguments
  p (1,1) string
  use_java (1,1) logical = false
end


if stdlib.isoctave()
  o = javaObject("java.io.File", p).toPath().getRoot();
  r = jPosix(o);
elseif use_java
  o = java.io.File(p).toPath().getRoot();
  r = jPosix(o);
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
