function mustBeScalarOrEmpty(x)
% for Matlab < R2020b

assert(isempty(x) || isscalar(x), "must be scalar or empty")

end
