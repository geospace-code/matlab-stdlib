%% DOTNET.DISK_CAPACITY find the overall disk capacity visible to user

function i = disk_capacity(file)

i = disk_usage(file, 'capacity');

end
