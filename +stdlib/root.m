%% ROOT get root path
% ROOT(P) returns the root path of P.
% root is the root_name + root_directory.


function r = root(p, use_java)
arguments
  p (1,1) string
  use_java (1,1) logical = false
end

if use_java
  r = string(java.io.File(p).toPath().getRoot());
  return
end


r = "";
if stdlib.len(p) == 0
  return
end

r = stdlib.root_name(p);

if ischar(p)

  if isempty(r) %#ok<UNRCH>
    if p(1) == '/'
      r = "/";
    end

    return
  end

  if ispc && strcmp(r, p)
    return
  end

  r = strcat(r, '/');

else

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

end

%!assert(root('', 0), '')
%!assert(root('/', 0), '/')
%!test
%! if ispc
%!   assert(root('C:\', 0), 'C:/')
%!   assert(root('C:/', 0), 'C:/')
%!   assert(root('C:', 0), 'C:')
%!   assert(root('C', 0), '')
%! endif
