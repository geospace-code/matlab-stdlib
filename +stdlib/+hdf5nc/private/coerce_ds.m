function A = coerce_ds(A, dtype)
% used by h5save and ncsave
arguments
  A
  dtype string {mustBeScalarOrEmpty}
end

if ischar(A)
  A = string(A);
  return
end

if isempty(dtype)
  return
end

switch dtype
  case ""
    return
  case {'float64', 'double'}
    if ~isa(A, 'double')
      A = double(A);
    end
  case {'float32', 'single'}
    if ~isa(A, 'single')
      A = single(A);
    end
 case 'int8'
     if ~isa(A, 'int8')
       A = int8(A);
     end
 case 'int16'
     if ~isa(A, 'int16')
       A = int16(A);
     end
  case 'int32'
     if ~isa(A, 'int32')
       A = int32(A);
     end
  case 'int64'
     if ~isa(A, 'int64')
       A = int64(A);
     end
  case 'char'
    A = string(A);
  case 'string'
    % pass
  otherwise, error('create_ds:type_error', 'unknown data type %s', dtype)
end

end % function
