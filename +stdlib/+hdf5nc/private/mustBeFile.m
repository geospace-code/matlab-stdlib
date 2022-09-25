function mustBeFile(a)
arguments
  a string {mustBeNonzeroLengthText}
end

assert(all(isfile(stdlib.fileio.expanduser(a)), 'all'), "%s is not a file", a)

end
