%% DEVICE filesystem device index of path

function i = device(p)
arguments
  p {mustBeTextScalar}
end

i = [];

if stdlib.has_python()
  i = stdlib.python.device(p);
elseif ispc() && stdlib.has_dotnet()
  i = device_dotnet(p);
elseif stdlib.isoctave()
  [s, err] = stat(p);
  if err == 0
    i = s.dev;
  end
elseif isunix() && stdlib.java_api() >= 11
  % Java 1.8 is buggy in some corner cases, so we require at least 11.
  opt = javaMethod("values", "java.nio.file.LinkOption");
  i = java.nio.file.Files.getAttribute(javaPathObject(p), "unix:dev", opt);
end

end

%!assert(device(pwd) >= 0);
%!assert(isempty(device(tempname())));
