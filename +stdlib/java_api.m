function api = java_api()
%% JAVA_API Java API version
v = stdlib.java_version();

% major version is first number before "."

a = split(v, ".");
if a(1) == "1"
  api = double(a(2));
else
  api = double(a(1));
end

end
