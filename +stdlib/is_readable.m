%% IS_READABLE is file readable
%
% non-existant file is false

function ok = is_readable(p)
arguments
  p {mustBeTextScalar}
end

a = file_attributes(p);

ok = ~isempty(a) && (a.UserRead || a.GroupRead || a.OtherRead);

end

%!assert (is_readable('is_readable.m'))
%!assert (!is_readable(''))
