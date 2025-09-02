function pythonException(e)

switch e.identifier
  case 'MATLAB:Python:PyException'
    if ~contains(e.message, ["NotADirectoryError", "FileNotFoundError"])
      rethrow(e)
    end
  otherwise, rethrow(e)
end

end