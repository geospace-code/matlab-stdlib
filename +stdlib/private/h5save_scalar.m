function h5save_scalar(file, hpath, A)
%% write HDF5 scalar as a scalar
%  h5create doesn't support scalars
arguments
  file (1,1)
  hpath (1,1) string
  A (1,1)
end

dcpl = 'H5P_DEFAULT';

fid = stdlib.h5create_group(file, hpath);

space_id = H5S.create('H5S_SCALAR');
if isstring(A)
  A = char(A);
end
if ischar(A)
  type_id = H5T.copy('H5T_C_S1');
  H5T.set_cset(type_id, H5ML.get_constant_value('H5T_CSET_UTF8'));
  H5T.set_size(type_id, 'H5T_VARIABLE');
  H5T.set_strpad(type_id, 'H5T_STR_NULLTERM');
else
  type_id = H5T.copy(class2h5t(A));
end

dset_id = H5D.create(fid, hpath, type_id, space_id, dcpl);

H5D.write(dset_id,'H5ML_DEFAULT','H5S_ALL','H5S_ALL', dcpl, A);

H5S.close(space_id);
H5T.close(type_id);
H5D.close(dset_id);
H5F.close(fid);

end


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
