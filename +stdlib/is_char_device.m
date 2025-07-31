%% IS_CHAR_DEVICE is path a character device
%
% e.g. NUL, /dev/null
% false if file does not exist

function ok = is_char_device(file, method)
arguments
  file {mustBeTextScalar}
  method (1,:) string = ["python", "sys"]
end

fun = choose_method(method, "is_char_device");

ok = fun(file);

end

