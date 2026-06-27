function v = javaException(e)

v = missing;

switch e.identifier
  case {'MATLAB:Java:ClassLoad', 'MATLAB:Java:JVMInitialize', 'MATLAB:Java:UnableToRead'}
    % Java class not available e.g. wrong OS for this class
  case ''
    % pass GNU Octave
  case 'MATLAB:Java:GenericException'
    switch class(e.ExceptionObject)
      case {'java.nio.file.NoSuchFileException', 'java.nio.file.NotLinkException', 'java.lang.UnsupportedOperationException'}
        % pass
      case 'java.lang.NullPointerException'
        % empty input
      otherwise
        rethrow(e)
    end
  case 'MATLAB:undefinedVarOrClass'
    % Java not enabled -nojvm
  otherwise
    rethrow(e)
end

end
