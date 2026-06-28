%% DOTNET.DISK_AVAILABLE find the disk space available to the user

function i = disk_available(file)

i = disk_usage(file, 'available');

end
