function fid = h5create_group(file, hpath)
%% create HDF5 group
%
% file: HDF5 file name or handle
% hpath: HDF5 group/dataset -- ensure final character is "/" if hpath is only a group

arguments
  file
  hpath (1,1) string {mustBeNonzeroLengthText}
end

import stdlib.fileio.expanduser

%% polymorphic fid/filename
if isa(file, 'H5ML.id')
  fid = file;
else
  file = expanduser(file);
  dcpl = 'H5P_DEFAULT';
  try
    fid = H5F.open(file, 'H5F_ACC_RDWR', dcpl);
  catch e
    if e.identifier == "MATLAB:imagesci:hdf5io:resourceNotFound"
      fid = H5F.create(file);
    else
      rethrow(e)
    end
  end
end

%% are there any groups
grps = split(hpath, "/");
if length(grps) < 3
  return
end

%% recursively create groups as needed
plist = 'H5P_DEFAULT';
groot = H5G.open(fid, "/");

for i = 0:length(grps) - 3
  n = join(grps(1:i+2), "/");

  if ~H5L.exists(groot, n, plist)
    gid = H5G.create(fid, n, plist, plist, plist);
    H5G.close(gid)
  end
end % for

H5G.close(groot)

if nargout == 0
  H5F.close(fid);
  clear('fid')
end

end
