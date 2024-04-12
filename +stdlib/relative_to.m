function r = relative_to(base, other)
arguments
  base (1,1) string
  other (1,1) string
end

if base == "" && other == ""
  r = ".";  % like C++ std::filesystem::relative
else
  r = stdlib.fileio.relative_to(base, other);
end

end
