function home = homedir()

persistent h;

if ~isempty(h)
  home = h;
  return
end

home = string(java.lang.System.getProperty("user.home"));

h = home;

end
