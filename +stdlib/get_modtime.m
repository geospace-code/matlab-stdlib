%% GET_MODTIME get path modification time

function t = get_modtime(p)
arguments
  p (1,1) string
end

if stdlib.exists(p)

  utc = javaFileObject(p).lastModified() / 1000;

  try
    t = datetime(utc, "ConvertFrom", "PosixTime");
  catch e
    if strcmp(e.identifier, "Octave:undefined-function")
      t = utc;
    else
      rethrow(e);
    end
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
