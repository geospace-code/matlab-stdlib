function r = read_symlink(file)

if ~stdlib.matlabOlderThan('R2024b')
  [ok, r] = isSymbolicLink(file);
  if ~ok
    r = string.empty;
  end
else
  r = string.empty;
end

end
