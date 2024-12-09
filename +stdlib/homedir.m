%% HOMEDIR get user home directory
%
% Ref:
% * https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/System.html#getProperty(java.lang.String)
% * https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/System.html#getProperties()

function home = homedir(use_java)
arguments
  use_java (1,1) logical = false
end

if(use_java)
  home = java.lang.System.getProperty("user.home");
elseif ispc
  home = getenv("USERPROFILE");
else
  home = getenv("HOME");
end

home = stdlib.posix(home);

end

%!assert(!isempty(homedir(false)))
