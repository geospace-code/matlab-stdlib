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

if dtype == "float64"
  dtype = "double";
elseif dtype == "float32"
  dtype = "single";
end

switch dtype
  case ""
    return
  case {'double', 'single', 'int8', 'int16', 'int32', 'int64','uint8', 'uint16', 'uint32', 'uint64'}
    A = cast(A, dtype);
  case {'char', 'string'}
    A = string(A);
  otherwise, error('create_ds:type_error', 'unknown data type %s', dtype)
end

end % function
