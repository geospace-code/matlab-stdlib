%% NC_GET_VERSION get NetCDF library version

function v = nc_get_version()

try
  v = netcdf.inqLibVers;
catch
  v = '';
end

end
