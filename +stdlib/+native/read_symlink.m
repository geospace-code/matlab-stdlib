function r = read_symlink(file)

[ok, r] = isSymbolicLink(file);
if ~ok
  r = string.empty; 
end

end
