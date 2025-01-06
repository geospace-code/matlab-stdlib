%% IS_EXE is file executable
%
% false if file does not exist


function ok = is_exe(p, use_java)
arguments
  p (1,1) string
  use_java (1,1) logical = false
end

ok = false;
if ~stdlib.exists(p), return, end

if use_java
% about the same time as fileattrib
% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/io/File.html#canExecute()
% more complicated
% ok = java.nio.file.Files.isExecutable(javaPathObject(stdlib.canonical(p)));

ok = javaFileObject(p).canExecute();

else

a = file_attributes(p);
if isempty(a), return, end

ok = a.UserExecute || a.GroupExecute || a.OtherExecute;

end

%!assert (!is_exe('', 0))
%!assert (!is_exe(tempname, 0))
%!assert (is_exe(".", 0))
%!assert (is_exe(program_invocation_name, 0))
