%% IS_WRITABLE is path writable
%
% non-existant path is false

function ok = is_writable(p)
arguments
  p (1,1) string
end

ok = false;
if ~stdlib.exists(p), return, end
% exists() check speeds up by factor of 50x on macOS

a = file_attributes(p);
if isempty(a), return, end

ok = a.UserWrite || v.GroupWrite || v.OtherWrite;

end

%!assert (is_writable('is_writable.m'))
%!assert (!is_writable(''))
