function srcs = get_mex_sources(top)
arguments
  top (1,1) string  % package directory
end

%% source C++

srcs = {fullfile(top, "src/is_char_device.cpp")};

s = fullfile(top, "src/is_symlink.cpp");
if ispc
  s(end+1) = fullfile(top, "src/windows.cpp");
end

srcs{end+1} = s;

end
