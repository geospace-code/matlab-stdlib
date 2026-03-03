%% WINDOWS_LONG_PATHS_ENABLED
% for Windows, detect if long paths are enabled in the registry
% programs (like Matlab) must also have a manifest that supports long paths

function y = windows_long_paths_enabled()

if ispc
  s = winqueryreg('HKEY_LOCAL_MACHINE', ...
        'SYSTEM\CurrentControlSet\Control\FileSystem', 'LongPathsEnabled');

  y = s == 1;
else
  y = false;
end

end
