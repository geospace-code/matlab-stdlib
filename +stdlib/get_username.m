%% GET_USERNAME tell username of current user
%
function n = get_username()

n = '';

if stdlib.has_dotnet()
  n = stdlib.dotnet.get_username();
elseif stdlib.has_java()
  n = stdlib.java.get_username();
end

if strempty(n)
  n = stdlib.sys.get_username();
end

try  %#ok<*TRYNC>
  n = string(n);
end

end

%!assert(!isempty(get_username()))
