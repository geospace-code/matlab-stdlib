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
t = class2h5t(A);
type_id = H5T.copy(t);
dset_id = H5D.create(fid, varname, type_id, space_id, dcpl);
H5D.write(dset_id,'H5ML_DEFAULT','H5S_ALL','H5S_ALL', dcpl, A);

H5S.close(space_id);
H5T.close(type_id);
H5D.close(dset_id);
H5F.close(fid);

end
