%% FILESYSTEM_TYPE tell type of filesystem
%
% example outputs: NTFS, ext4, apfs, ...

function t = filesystem_type(file, method)
arguments
  file {mustBeTextScalar}
  method (1,:) string = ["java", "dotnet", "python", "sys"]
end

fun = choose_method(method, "filesystem_type");

t = fun(file);

end
