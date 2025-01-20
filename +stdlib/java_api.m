%% JAVA_API Java API version
% requires: java

function api = java_api()

v = stdlib.java_version();

% major version is first number before "."

a = strsplit(v, '.');
if(isempty(a))
  api = 0;
  return
end

if a{1} == "1"
  api = str2double(a{2});
else
  api = str2double(a{1});
end

end


%!assert(java_api() > 0)
