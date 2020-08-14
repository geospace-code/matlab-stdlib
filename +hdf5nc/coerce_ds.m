function A = coerce_ds(A, dtype)
% used by h5save and ncsave
narginchk(2,2)
validateattributes(A, {'numeric'}, {'nonempty'},1)
validateattributes(dtype, {'char'}, {'vector'},2)

switch dtype
  case {'float64', 'double'}
    if ~isa(A, 'double')
      A = double(A);
    end
  case {'float32', 'single'}
    if ~isa(A, 'single')
      A = single(A);
    end
  case {'int32'}
     if ~isa(A, 'int32')
       A = int32(A);
     end
  case {'int64'}
     if ~isa(A, 'int64')
       A = int64(A);
     end
  case {'char', 'string'}
    if ~isstring(A)
      A = string(A);
    end
  otherwise, error('create_ds:type_error', 'unknown data type %s', dtype)
end

end % function