%% WSL_TEMPFILE get temporary file from WSL
% Windows Subsystem for Linux (WSL) temporary file from Windows Matlab

function p = wsl_tempfile()
% arguments (Output)
%   p (1,1) string {mustBeNonzeroLengthText}
% end

assert(stdlib.has_wsl(), "stdlib:sys:wsl_tempfile:EnvironmentError", "%s only supported on Windows Matlab with WSL",  mfilename())

[stat, p] = system("wsl mktemp -u");

assert(stat == 0, "stdlib:sys:wsl_tempfile:IOError", "could not get wsl mktemp %s", p)

try %#ok<TRYNC>
p = strip(p);
end

end

%!test
%! if stdlib.has_wsl()
%! assert(ischar(wsl_tempfile()))
%! endif
