%% FILESYSTEM_TYPE tell type of filesystem
%
% example outputs: NTFS, ext4, apfs, ...

function t = filesystem_type(file, backend)
arguments
  file {mustBeTextScalar}
  backend (1,:) string = ["java", "dotnet", "python", "sys"]
end

fun = hbackend(backend, "filesystem_type");

t = fun(file);

end
