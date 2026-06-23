function i = is_symlink(file)

if ~stdlib.matlabOlderThan('R2024b')
  i = isSymbolicLink(file);
else
  i = missing;
end

end
