%% ROOT get root path
% ROOT(P) returns the root path of P.
% root is the root_name + root_directory.


function r = root(p, use_java)
arguments
  p (1,1) string
  use_java (1,1) logical = false
end


if use_java
  o = javaFileObject(p).toPath().getRoot();
  r = jPosix(o);
else

  r = stdlib.root_name(p);

  if ~stdlib.len(r)
    if strncmp(p, "/", 1)
      r = "/";
    end

    return
  end

  if ispc && strcmp(r, p)
    return
  end

  r = strcat(r, "/");

end

%!assert(root('',0), '')
%!assert(root('/',0), '/')
%!test
%! if ispc
%!   assert(root('C:\',0), 'C:/')
%!   assert(root('C:/',0), 'C:/')
%!   assert(root('C:',0), 'C:')
%!   assert(root('C',0), '')
%! endif
