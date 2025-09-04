function i = is_symlink(file)

try
  i = isSymbolicLink(file);
catch e
  if e.identifier ~= "MATLAB:UndefinedFunction"
    rethrow(e)
  end
  i = logical.empty;
end

end
