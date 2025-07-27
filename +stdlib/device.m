%% DEVICE filesystem device index of path

function i = device(p)
arguments
  p {mustBeTextScalar}
end

if isunix() && stdlib.has_java()
  i = stdlib.java.device(p);
elseif stdlib.has_python()
  i = stdlib.python.device(p);
else
  i = stdlib.sys.device(p);
end

end

%!assert(device(pwd) >= 0);
%!assert(isempty(device(tempname())));
