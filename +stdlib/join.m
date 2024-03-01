function p = join(a, b)
%% JOIN: join two paths with posix file separator
arguments
  a (1,1) string
  b (1,1) string
end

p = stdlib.fileio.join(a, b);

end
