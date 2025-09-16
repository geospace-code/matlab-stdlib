%% H5GET_VERSION get version of HDF5 library as a string

function v = h5get_version()

try
  [major, minor, rel] = H5.get_libversion();
  v = sprintf('%d.%d.%d', major, minor, rel);
catch
  v = '';
end

end
