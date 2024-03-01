function home = homedir()
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/System.html#getProperty(java.lang.String)
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/System.html#getProperties()
persistent h;

if ~isempty(h)
  home = h;
  return
end

home = stdlib.fileio.posix(java.lang.System.getProperty("user.home"));

h = home;

end
