%% SET_MODTIME set modification time of path

function ok = set_modtime(p, t, method)
arguments
  p {mustBeTextScalar, mustBeFile}
  t (1,1) datetime
  method (1,:) string = ["java", "python", "sys"]
end

fun = choose_method(method, "set_modtime");

ok = fun(p, t);

end
