%% DISK_AVAILABLE disk available space (bytes)
%
% example:  stdlib.disk_available('/')
%
% Ref: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getUsableSpace()

function f = disk_available(filepath, backend)
arguments
  filepath {mustBeTextScalar}
  backend (1,:) string = ["java", "dotnet", "python", "sys"]
end

fun = hbackend(backend, "disk_available");

f = fun(filepath);

end
