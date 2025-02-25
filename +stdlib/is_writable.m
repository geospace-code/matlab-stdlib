%% IS_WRITABLE is path writable
%
% non-existant path is false

function ok = is_writable(p)
arguments
  p (1,1) string
end

a = file_attributes(p);

ok = ~isempty(a) && (a.UserWrite || a.GroupWrite || a.OtherWrite);

end

%!assert (is_writable('is_writable.m'))
%!assert (!is_writable(''))
