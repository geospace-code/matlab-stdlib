function t = get_modtime(p)
%get_modtime get path modification time
arguments
  p (1,1) string
end

if stdlib.exists(p)
  t = datetime(java.io.File(p).lastModified()/1e3, "ConvertFrom", "PosixTime");
else
  t = datetime.empty();
end

end
