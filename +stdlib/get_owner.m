%% GET_OWNER owner name of file or directory
%
%%% Inputs
% * p: path to examine
%%% Outputs
% * n: owner, or empty if path does not exist

function n = get_owner(p)
arguments
  p {mustBeTextScalar}
end

if stdlib.has_java()
  n = stdlib.java.get_owner(p);
elseif ispc() && stdlib.has_dotnet()
  n = stdlib.dotnet.get_owner(p);
elseif ~ispc() && stdlib.has_python()
  n = stdlib.python.get_owner(p);
else
  n = stdlib.sys.get_owner(p);
end

end
