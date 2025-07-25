%% IS_ADMIN is the process run as root / admin

function y = is_admin()


if (isunix() || ~isMATLABReleaseOlderThan('R2024a')) && stdlib.has_python()
  y = stdlib.python.is_admin();
elseif ispc() && stdlib.has_dotnet()
  y = stdlib.dotnet.is_admin();
elseif isunix() && stdlib.has_java()
  y = stdlib.java.is_admin();
elseif stdlib.isoctave()
  y = getuid() == 0;
else
  y = stdlib.sys.is_admin();
end

end

%!assert (islogical(is_admin()))
