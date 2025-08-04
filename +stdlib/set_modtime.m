%% SET_MODTIME set modification time of path

function ok = set_modtime(p, t, backend)
arguments
  p {mustBeTextScalar}
  t (1,1) datetime
  backend (1,:)string = ["java", "python", "sys"]
end

fun = hbackend(backend, "set_modtime");

ok = fun(p, t);

end
