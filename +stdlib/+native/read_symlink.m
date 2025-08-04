function r = read_symlink(file)

[ok, r] = isSymbolicLink(file);

r(~ok) = "";

end
