%% IS_ABSOLUTE is path absolute
%
% * Windows, absolute paths must be at least 3 character long, starting with a root name followed by a slash
%
% * non-Windows, absolute paths must start with a slash

function y = is_absolute(p)
arguments
  p {mustBeTextScalar}
end

% not Octave is_absolute_filename() because this is a stricter check for "c:" false

y = ~strempty(stdlib.root_dir(p));

if ispc()
  y = y && ~strempty(stdlib.root_name(p));
end

end

%!assert(is_absolute(''), false)
%!test
%! if ispc()
%!   assert(is_absolute('C:\'))
%!   assert(is_absolute('C:/'))
%!   assert(!is_absolute('C:'))
%!   assert(!is_absolute('C'))
%! else
%!   assert(is_absolute('/'))
%!   assert(is_absolute('/usr'))
%!   assert(!is_absolute('usr'))
%! endif
