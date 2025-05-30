%% ROOT_NAME get root name
% ROOT_NAME(P) returns the root name of P.
% root_name is the drive letter on Windows without the trailing slash
% or an empty string if P is not an absolute path.
% on non-Windows platforms, root_name is always an empty string.


function r = root_name(p)
arguments
  p {mustBeTextScalar}
end

r = "";

if ~ispc || strlength(p) < 2
  return
end

c = char(p);

if c(2) == ':' && isletter(c(1))
  r = c(1:2);
end

if isstring(p)
  r = string(r);
end

end

%!assert(root_name(''), '')
%!assert(root_name('/'), '')
%!test
%! if ispc
%!   assert(root_name('C:\'), 'C:')
%!   assert(root_name('C:/'), 'C:')
%!   assert(root_name('C:'), 'C:')
%!   assert(root_name('C'), '')
%! endif
