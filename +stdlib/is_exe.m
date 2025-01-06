%% IS_EXE is file executable
%
% false if file does not exist

function ok = is_exe(p)
arguments
  p (1,1) string
end

ok = false;
if ~stdlib.exists(p), return, end

a = file_attributes(p);
if isempty(a), return, end

ok = a.UserExecute || a.GroupExecute || a.OtherExecute;

end

%!assert (!is_exe(''))
%!assert (!is_exe(tempname))
%!assert (is_exe("."))
%!assert (is_exe(program_invocation_name))
