%% GET_USERNAME tell username of current user
%
function n = get_username()


if stdlib.has_dotnet()
  n = stdlib.dotnet.get_username();
elseif stdlib.has_java()
  n = stdlib.java.get_username();
elseif stdlib.has_python()
  n = stdlib.python.get_username();
else
  n = stdlib.sys.get_username();
end

end
