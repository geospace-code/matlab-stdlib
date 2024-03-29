function path = wsl_tempfile()
%% wsl_tempfile()
% Windows Subsystem for Linux (WSL) temporary file from Windows Matlab
arguments (Output)
  path (1,1) string {mustBeNonzeroLengthText}
end

assert(stdlib.sys.has_wsl(), "stdlib:sys:wsl_tempfile:EnvironmentError", mfilename() + "only supported on Windows Matlab with WSL")

[stat, path] = system("wsl mktemp -u");

assert(stat == 0, "stdlib:sys:wsl_tempfile:IOError", "could not get wsl mktemp " + path)

path = strip(path);

end
