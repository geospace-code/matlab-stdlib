function t = class2h5t(A)
% gets HDF5 H5T of variable A

switch class(A)
  case 'double', t = 'H5T_NATIVE_DOUBLE';
  case 'single', t = 'H5T_NATIVE_FLOAT';
  case 'int32', t = 'H5T_STD_I32LE';
  case 'int64', t = 'H5T_STD_I64LE';
  otherwise, error('h5save:class2h5t: unknown data class %s', class(A))
end

end
