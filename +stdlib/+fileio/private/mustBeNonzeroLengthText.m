function mustBeNonzeroLengthText(a)

if ~((ischar(a) || isstring(a) || iscellstr(a)) && all(strlength(a) > 0, 'all'))
  throwAsCaller(MException("MATLAB:validators:mustBeNonzeroLengthText", "text must have non-zero length"))
end

end
