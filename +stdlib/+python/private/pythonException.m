function pythonException(e)

switch e.identifier
  case 'MATLAB:Python:PythonUnavailable'
    % pass
  case 'MATLAB:Python:PyException'
    if ~contains(e.message, ["is not in the subpath of", "NotADirectoryError", "FileNotFoundError"])
      rethrow(e)
    end
  otherwise, rethrow(e)
end

end