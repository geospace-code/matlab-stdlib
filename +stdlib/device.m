%% DEVICE filesystem device index of path

function i = device(file, method)
arguments
  file {mustBeTextScalar}
  method (1,:) string = ["java", "python", "sys"]
end

fun = choose_method(method, "device");
i = fun(file);

end
