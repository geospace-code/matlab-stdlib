function ok = is_readable(p)
%% is_readable() returns true if the file at path p is readable

arguments
  p (1,1) string
end

ok = stdlib.fileio.is_readable(p);

end
