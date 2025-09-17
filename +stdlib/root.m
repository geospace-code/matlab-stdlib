%% ROOT get root path
% ROOT(P) returns the root path of P.

function r = root(p)

r = stdlib.append(stdlib.root_name(p), stdlib.root_dir(p));

end

%!test
%! pkg load tablicious
%! if ispc()
%!   assert(strcmp(strcmp.root('c:/hi'), 'c:/'))
%! else
%!   assert(strcmp(stdlib.root('/a/.bc'), '/'))
%! end