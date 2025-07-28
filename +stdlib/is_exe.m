%% IS_EXE is file executable
%
% false if not a file

function y = is_exe(p)
arguments
  p {mustBeTextScalar}
end

% Java or Python are like 100x faster than Matlab native
if stdlib.has_java()
  y = stdlib.java.is_exe(p);
elseif stdlib.has_python()
  y = stdlib.python.is_exe(p);
else
  y = stdlib.native.is_exe(p);
end

end
