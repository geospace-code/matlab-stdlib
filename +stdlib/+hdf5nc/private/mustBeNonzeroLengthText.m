function mustBeNonzeroLengthText(a)

if ~((ischar(a) || isstring(a) || iscellstr(a)) && all(strlength(a) > 0, 'all'))
    error("MATLAB:validators:mustBeNonzeroLengthText", "text must have non-zero length")
end

end