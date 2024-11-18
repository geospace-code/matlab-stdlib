%% WSL_TEMPFILE get temporary file from WSL
% Windows Subsystem for Linux (WSL) temporary file from Windows Matlab

function path = wsl_tempfile()
arguments (Output)
  path (1,1) string {mustBeNonzeroLengthText}
end

assert(stdlib.has_wsl(), "stdlib:sys:wsl_tempfile:EnvironmentError", mfilename() + "only supported on Windows Matlab with WSL")

[stat, path] = system("wsl mktemp -u");

assert(stat == 0, "stdlib:sys:wsl_tempfile:IOError", "could not get wsl mktemp " + path)

path = strip(path);

end
