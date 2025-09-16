%% XCODE_VERSION on macOS, tell the Xcode Command Line Tools version

function v = xcode_version()

v = '';

if ismac()
  [s, m] = system('pkgutil --pkg-info com.apple.pkg.CLTools_Executables');
  if s == 0
    t = regexp(m, 'version:\s*(\d+\.\d+(\.\d+)+)', 'tokens', 'once');
    if ~isempty(t)
      v = t{1};
    end
  else
    warning("stdlib:xcode_version:runtimeError", "%d failed to get Command Line Tools Xcode version", s)
  end
end

end
