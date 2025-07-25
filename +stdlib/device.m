%% DEVICE filesystem device index of path

function i = device(p)
arguments
  p {mustBeTextScalar}
end

i = [];

if stdlib.has_python()
  i = stdlib.python.device(p);
elseif ispc() && stdlib.has_dotnet()
  i = stdlib.dotnet.device(p);
elseif isunix() && stdlib.java_api() >= 11
  % Java 1.8 is buggy in some corner cases, so we require at least 11.
  i = stdlib.java.device(p);
end

if isempty(i)
  i = stdlib.sys.device(p);
end

i = uint64(i);

end

%!assert(device(pwd) >= 0);
%!assert(isempty(device(tempname())));
