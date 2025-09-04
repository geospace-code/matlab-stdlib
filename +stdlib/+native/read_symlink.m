function r = read_symlink(file)

try
  [ok, r] = isSymbolicLink(file);
  if ~ok
    r = string.empty;
  end
catch e
  if e.identifier ~= "MATLAB:UndefinedFunction"
    rethrow(e)
  end
  r = string.empty;
end

end
