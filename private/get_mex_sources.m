function srcs = get_mex_sources(top)
arguments
  top (1,1) string  % package directory
end

%% source C++

% Matlab and Java don't have these functions
srcs = {fullfile(top, "src/is_char_device.cpp"), ...
  fullfile(top, "src/set_permissions.cpp"), ...
};

% isSymbolicLink() new in R2024b
if ~isMATLABReleaseOlderThan("R2024b")

s = fullfile(top, "src/is_symlink.cpp");
if ispc
  s(end+1) = fullfile(top, "src/windows.cpp");
end
srcs{end+1} = s;

end

end
