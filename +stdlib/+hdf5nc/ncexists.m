function exists = ncexists(file, vars)

arguments
  file (1,1) string {mustBeFile}
  vars string
end

% NOT contains because we want exact string match
exists = ismember(vars, stdlib.hdf5nc.ncvariables(file));

end
