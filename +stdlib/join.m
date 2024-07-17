function p = join(a, b)
%% JOIN: join two paths with posix file separator
arguments
  a (1,1) string
  b (1,1) string
end

p = stdlib.posix(fullfile(a, b));

end
