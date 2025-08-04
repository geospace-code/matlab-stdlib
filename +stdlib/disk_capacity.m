%% DISK_CAPACITY disk total capacity (bytes)
%
% example:  stdlib.disk_capacity('/')

function f = disk_capacity(filepath, backend)
arguments
  filepath {mustBeTextScalar}
  backend (1,:) string = ["java", "dotnet", "python", "sys"]
end

fun = hbackend(backend, "disk_capacity");

f = fun(filepath);

end
