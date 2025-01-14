%% IS_READABLE is file readable
%
% non-existant file is false

function ok = is_readable(p)
arguments
  p (1,1) string
end

a = file_attributes(p);

ok = ~isempty(a) && (a.UserRead || v.GroupRead || v.OtherRead);

end

%!assert (is_readable('is_readable.m'))
%!assert (!is_readable(''))
