function r = proximate_to(base, other)
arguments
  base (1,1) string
  other (1,1) string
end

r = stdlib.fileio.proximate_to(base, other);

end
