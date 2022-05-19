function t = class2h5t(A)
% gets HDF5 H5T of variable A

C = class(A);
switch C
  case 'double', t = 'H5T_NATIVE_DOUBLE';
  case 'single', t = 'H5T_NATIVE_FLOAT';
  case {'int8', 'int16', 'int32', 'int64'}
    t = "H5T_STD_I" + extractBetween(C, 4, strlength(C)) + "LE";
  case {'uint8', 'uint16', 'uint32', 'uint64'}
    t = "H5T_STD_U" + extractBetween(C, 5, strlength(C)) + "LE";
  otherwise, error('h5save:class2h5t: unknown data class %s', class(A))
end

end
