%% IS_ABSOLUTE is path absolute
%
% * Windows, absolute paths must be at least 3 character long, starting with a root name followed by a slash
%
% * non-Windows, absolute paths must start with a slash

function y = is_absolute(p)
arguments
  p (1,1) string
end

% not Octave is_absolute_filename() because this is a stricter check for "c:" false

y = false;

L = stdlib.len(p);
if ~L || (ispc && L < 3)
  return
end

if ispc
  if ischar(p)
    s = p(3); %#ok<UNRCH>
  else
    s = extractBetween(p, 3, 3);
  end
  y = stdlib.len(stdlib.root_name(p)) && (strcmp(s, '/') || strcmp(s, '\'));
else
  y = strncmp(p, "/", 1);
end

end

%!assert(is_absolute(''), false)
%!test
%! if ispc
%!   assert(is_absolute('C:\'))
%!   assert(is_absolute('C:/'))
%!   assert(!is_absolute('C:'))
%!   assert(!is_absolute('C'))
%! else
%!   assert(is_absolute('/'))
%!   assert(is_absolute('/usr'))
%!   assert(!is_absolute('usr'))
%! endif
