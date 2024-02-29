function p = join(a, b)
%% JOIN: join two paths with posix file separator
arguments
  a string {mustBeScalarOrEmpty}
  b string {mustBeScalarOrEmpty}
end

p = stdlib.fileio.join(a, b);

end
