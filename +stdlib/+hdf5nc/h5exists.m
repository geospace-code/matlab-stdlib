function exists = h5exists(file, vars)

arguments
  file (1,1) string {mustBeFile}
  vars string
end

i = startsWith(vars, "/");
vars(i) = extractAfter(vars(i), 1);
% NOT contains because we want exact string match
exists = ismember(vars, stdlib.hdf5nc.h5variables(file));

end
