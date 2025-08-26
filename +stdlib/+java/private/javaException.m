function javaException(e)

switch class(e.ExceptionObject)
  case {'java.nio.file.NoSuchFileException', 'java.nio.file.NotLinkException'}
  otherwise, rethrow(e)
end

end
