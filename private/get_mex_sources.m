function srcs = get_mex_sources(top)
arguments
  top (1,1) string  % package directory
end

win = string.empty;
if ispc
win = fullfile(top, "src/windows.cpp");
end

mac = fullfile(top, "src/macos.cpp");

srcs = {fullfile(top, "src/is_char_device.cpp"), ...
  fullfile(top, "src/set_permissions.cpp"), ...
  fullfile(top, "src/create_symlink.cpp"), ...
  [fullfile(top, "src/is_rosetta.cpp"), mac], ...
  [fullfile(top, "src/windows_shortname.cpp"), win]
};

%% isSymbolicLink() new in R2024b
if ~isMATLABReleaseOlderThan("R2024b")
srcs{end+1} = [fullfile(top, "src/is_symlink.cpp"), win];
end

end
