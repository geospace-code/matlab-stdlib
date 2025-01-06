%% GET_MODTIME get path modification time

function t = get_modtime(p)
arguments
  p (1,1) string
end

if stdlib.exists(p)

  t = javaFileObject(p).lastModified() / 1000;

  try %#ok<TRYNC>
    t = datetime(t, "ConvertFrom", "PosixTime");
  end
else
  try
    t = datetime.empty();
  catch
    t = [];
  end
end

end

%!test
%! p = tempname();
%! assert(touch(p))
%! assert(get_modtime(p) > 0)
%! delete(p)
