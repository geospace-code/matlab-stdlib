%% ROOT get root path
% ROOT(P) returns the root path of P.
% root is the root_name + root_directory.


function r = root(p)
arguments
  p {mustBeTextScalar}
end

r = stdlib.root_name(p);

if ~strlength(r)
  if strncmp(p, '/', 1)
    r = '/';
  end
elseif ~(ispc() && strcmp(r, p))
  r = strcat(r, '/');
end

if isstring(p)
  r = string(r);
end

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
