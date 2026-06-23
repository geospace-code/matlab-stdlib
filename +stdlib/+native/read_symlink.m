function r = read_symlink(file)

if stdlib.matlabOlderThan('R2024b')
  r = missing;
else
  [~, r] = isSymbolicLink(file);
end

end
