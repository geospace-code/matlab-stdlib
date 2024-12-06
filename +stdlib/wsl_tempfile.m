%% WSL_TEMPFILE get temporary file from WSL
% Windows Subsystem for Linux (WSL) temporary file from Windows Matlab

function p = wsl_tempfile()
arguments (Output)
  p (1,1) string {mustBeNonzeroLengthText}
end

assert(stdlib.has_wsl(), "stdlib:sys:wsl_tempfile:EnvironmentError", mfilename() + "only supported on Windows Matlab with WSL")

[stat, p] = system("wsl mktemp -u");

assert(stat == 0, "stdlib:sys:wsl_tempfile:IOError", "could not get wsl mktemp " + p)

p = strip(p);

end
