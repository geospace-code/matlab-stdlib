%% ROOT_NAME get root name
% ROOT_NAME(P) returns the root name of P.
% root_name is the drive letter on Windows without the trailing slash
% or an empty string if P is not an absolute path.
% on non-Windows platforms, root_name is always an empty string.


function r = root_name(p)
arguments
  p (1,1) string
end

r = "";

if ~ispc || stdlib.len(p) < 2 || stdlib.is_url(p), return, end

if ischar(p)
  if p(2) == ':' && isletter(p(1)) %#ok<UNRCH>
    r = p(1:2);
  end
else
  if extractBetween(p, 2, 2) == ":" && isletter(extractBetween(p, 1, 1))
    r = extractBetween(p, 1, 2);
  end
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
