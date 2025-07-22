%% JAVA_API Java API version

function api = java_api()

api = [];

v = stdlib.java_version();
if strempty(v), return, end

% major version is first number before "."

a = strsplit(v, '.');
if(isempty(a)), return, end

if a{1} == "1"
  api = str2double(a{2});
else
  api = str2double(a{1});
end

end


%!assert(!isempty(java_api()))
