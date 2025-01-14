%% GET_MODTIME get path modification time

function t = get_modtime(p)
arguments
  p (1,1) string
end

t = [];
if ~stdlib.exists(p), return, end

t = javaFileObject(p).lastModified() / 1000;

try %#ok<TRYNC>
  t = datetime(t, "ConvertFrom", "PosixTime");
end

end

%!test
%! p = tempname();
%! t = time();
%! assert(touch(p, t))
%! assert(get_modtime(p) > 0)
%! delete(p)
