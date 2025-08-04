%% DEVICE filesystem device index of path

function i = device(file, backend)
arguments
  file {mustBeTextScalar}
  backend (1,:) string = ["java", "python", "sys"]
end

fun = hbackend(backend, "device");
i = fun(file);

end
