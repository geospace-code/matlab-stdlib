%% ROOT get root path
% ROOT(P) returns the root path of P.

function r = root(p)

r = strcat(stdlib.root_name(p), stdlib.root_dir(p));

end

%!assert(root('/'), '/')
%!test
%! if ispc
%!   assert(root('C:\'), 'C:\')
%!   assert(root('C:/'), 'C:/')
%!   assert(root('C:'), 'C:')
%!   assert(isempty(root('C')))
%! endif
