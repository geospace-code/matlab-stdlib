%% HOMEDIR get user home directory
%
% Ref:
% * https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/System.html#getProperty(java.lang.String)
% * https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/System.html#getProperties()

function h = homedir(use_java)
arguments
  use_java (1,1) logical = false
end

if stdlib.isoctave()
  h = javaMethod("getProperty", "java.lang.System", "user.home");
elseif use_java
  h = java.lang.System.getProperty("user.home");
elseif ispc
  h = getenv("USERPROFILE");
else
  h = getenv("HOME");
end

h = stdlib.posix(h);

end

%!assert(!isempty(homedir()))
