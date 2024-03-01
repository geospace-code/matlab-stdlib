function ok = is_writable(p)
%% is_writable() returns true if the file at path p is writable

arguments
  p (1,1) string
end

ok = stdlib.fileio.is_writable(p);

end
