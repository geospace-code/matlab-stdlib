function mustBeScalarOrEmpty(x)

if ~(isempty(x) || isscalar(x))
  throwAsCaller(MException('MATLAB:validators:mustBeScalarOrEmpty', "must be scalar or empty"))
end

end
