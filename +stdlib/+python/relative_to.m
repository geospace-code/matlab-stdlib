function rel = relative_to(base, other)

try
  rel = string(py.os.path.relpath(other, base));
catch e
  if e.identifier == "MATLAB:Python:PyException" && startsWith(e.message, 'Python Error: ValueError')
    rel = "";
  else
    rethrow(e)
  end
end

end
