%% DEVICE filesystem device index of path

function i = device(p)
arguments
  p {mustBeTextScalar}
end

i = [];

if stdlib.has_python()
  i = stdlib.python.device(p);
elseif isunix() && stdlib.has_java()
  i = stdlib.java.device(p);
end

if isempty(i)
  i = stdlib.sys.device(p);
end

i = uint64(i);

end

%!assert(device(pwd) >= 0);
%!assert(isempty(device(tempname())));
