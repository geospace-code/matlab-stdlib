%% GET_MODTIME get path modification time

function t = get_modtime(p)
arguments
  p (1,1) string
end

if stdlib.exists(p)
  t = datetime(java.io.File(p).lastModified()/1e3, "ConvertFrom", "PosixTime");
else
  t = datetime.empty();
end

end
