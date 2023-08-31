function home = homedir()

persistent h;

if ~isempty(h)
  home = h;
  return
end

try
   home = string(java.lang.System.getProperty("user.home"));
catch excp
    % if Java not available use env vars, else error
    if excp.identifier ~= "MATLAB:undefinedVarOrClass"
      error("stdlib:fileio:homedir", excp.message)
    end

    if ispc
      home = getenv('USERPROFILE');
    else
      home = getenv('HOME');
    end
end

h = home;

end