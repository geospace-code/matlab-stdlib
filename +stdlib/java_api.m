%% JAVA_API Java API version

function api = java_api()

v = stdlib.java_version();

% major version is first number before "."

a = split(v, ".");
if(isempty(a))
  api = 0;
  return
end

if a(1) == "1"
  api = double(a(2));
else
  api = double(a(1));
end

end
