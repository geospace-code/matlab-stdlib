%% DEVICE filesystem device index of path
% optional: java

function i = device(path)
arguments
  path {mustBeTextScalar}
end

i = [];

if stdlib.has_python()
  i = uint64(py.pathlib.Path(path).stat().st_dev);
elseif ispc() && stdlib.has_dotnet()
  i = device_dotnet(path);
elseif stdlib.isoctave()
  [s, err] = stat(path);
  if err == 0
    i = s.dev;
  end
elseif isunix() && stdlib.java_api() >= 11
  % Java 1.8 is buggy in some corner cases, so we require at least 11.
  opt = javaMethod("values", "java.nio.file.LinkOption");
  i = java.nio.file.Files.getAttribute(javaPathObject(path), "unix:dev", opt);
end

end

%!assert(device(pwd) >= 0);
%!assert(isempty(device(tempname())));
