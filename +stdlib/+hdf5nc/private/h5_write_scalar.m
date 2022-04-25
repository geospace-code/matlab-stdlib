function h5_write_scalar(filename, varname, A)
%% write HDF5 scalar as a scalar
%  h5create doesn't support scalars
dcpl = 'H5P_DEFAULT';

if isfile(filename)
  fid = H5F.open(filename, 'H5F_ACC_RDWR', dcpl);
else
  fid = H5F.create(filename);
end

create_hdf5_group(fid, varname);

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

dset_id = H5D.create(fid, varname, type_id, space_id, dcpl);

H5D.write(dset_id,'H5ML_DEFAULT','H5S_ALL','H5S_ALL', dcpl, A);

H5S.close(space_id);
H5T.close(type_id);
H5D.close(dset_id);
H5F.close(fid);

end
