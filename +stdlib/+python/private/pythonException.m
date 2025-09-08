function pythonException(e)

switch e.identifier
  case {'MATLAB:Python:PythonUnavailable', 'MATLAB:undefinedVarOrClass'}
    % Python not available or Python imported module not available
  case 'MATLAB:Python:PyException'
    if ~contains(e.message, ["is not in the subpath of", "NotADirectoryError", "FileNotFoundError"])
      rethrow(e)
    end
  otherwise, rethrow(e)
end

end