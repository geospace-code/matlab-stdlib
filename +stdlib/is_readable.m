%% IS_READABLE is file readable
%
% non-existant file is false

function ok = is_readable(p)
arguments
  p (1,1) string
end

ok = false;
if ~stdlib.exists(p), return, end
% exists() check speeds up by factor of 50x on macOSa

a = file_attributes(p);
if isempty(a), return, end

ok = a.UserRead || v.GroupRead || v.OtherRead;

end

%!assert (is_readable('is_readable.m'))
%!assert (!is_readable(''))
