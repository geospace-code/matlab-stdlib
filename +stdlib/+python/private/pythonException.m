function pythonException(e)

switch e.identifier
  case 'MATLAB:Python:PyException'
    if ~contains(e.message, "FileNotFoundError")
      rethrow(e)
    end
  otherwise, rethrow(e)
end

end