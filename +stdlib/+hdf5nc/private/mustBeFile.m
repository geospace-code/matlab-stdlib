function mustBeFile(a)
arguments
  a string {mustBeNonzeroLengthText}
end

if ~all(isfile(stdlib.fileio.expanduser(a)), 'all')
  throwAsCaller(MException('MATLAB:validators:mustBeFile', a + " is not a file"))
end

end
