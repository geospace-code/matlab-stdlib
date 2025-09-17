function javaException(e)

switch e.identifier
  case 'MATLAB:Java:ClassLoad'
    % Java class not available e.g. wrong OS for this class
  case ''
    % pass GNU Octave
  case 'MATLAB:Java:GenericException'
    switch class(e.ExceptionObject)
      case {'java.nio.file.NoSuchFileException', 'java.nio.file.NotLinkException', 'java.lang.UnsupportedOperationException'}
        % pass
      otherwise
        rethrow(e)
    end
  case 'MATLAB:undefinedVarOrClass'
    % Java not enabled -nojvm
  otherwise
    rethrow(e)
end

end
