%% DISK_CAPACITY disk total capacity (bytes)
%
% example:  stdlib.disk_capacity('/')

function f = disk_capacity(filepath, method)
arguments
  filepath {mustBeTextScalar}
  method (1,:) string = ["java", "dotnet", "python", "sys"]
end

fun = choose_method(method, "disk_capacity");

f = fun(filepath);

end
