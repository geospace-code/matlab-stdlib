function create_hdf5_group(fid, name)

grps = split(name, "/");
if length(grps) < 3
  return
end

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
end
