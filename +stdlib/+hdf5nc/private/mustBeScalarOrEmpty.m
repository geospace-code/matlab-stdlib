function mustBeScalarOrEmpty(x)

assert(isempty(x) || isscalar(x), "must be scalar or empty")

end
