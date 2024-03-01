function ok = exists(p)
%% exists does path exist

arguments
  p (1,1) string
end

ok = stdlib.fileio.exists(p);

end
