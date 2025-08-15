function r = read_symlink(file)
arguments
  file string
end

[ok, r] = isSymbolicLink(file);

r(~ok) = "";

end
