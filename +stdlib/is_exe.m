%% IS_EXE is file executable
%
% false if file does not exist


function ok = is_exe(p, use_java)
arguments
  p (1,1) string
  use_java (1,1) logical = true
end

if ~isfile(p)
  ok = false;
  return
end

if use_java
% about the same time as fileattrib
% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/io/File.html#canExecute()
% more complicated
% ok = java.nio.file.Files.isExecutable(java.io.File(stdlib.canonical(p)).toPath());

try
  ok = java.io.File(p).canExecute();
catch e
  if strcmp(e.identifier, "Octave:undefined-function")
    ok = javaObject("java.io.File", p).canExecute();
  else
    rethrow(e);
  end
end

else

  if ~strlength(p)
    ok = false;
    return
  end

  [status, v] = fileattrib(p);

  ok = status ~= 0 && (v.UserExecute || (~isnan(v.GroupExecute) && v.GroupExecute) || (~isnan(v.OtherExecute) && v.OtherExecute));

end

end

%!assert (!is_exe(''))
%!assert (!is_exe(tempname))
%!assert (is_exe(program_invocation_name))
