%% XCODE_VERSION on macOS, tell the Xcode Command Line Tools version

function v = xcode_version()

v = '';

if ~ismac(), return, end

[s, m] = system('pkgutil --pkg-info com.apple.pkg.CLTools_Executables');

if s ~= 0, return, end

v = regexp(m, '(?<=version: )(\d+\.\d+(\.\d+)+)', 'match', 'once');

end
