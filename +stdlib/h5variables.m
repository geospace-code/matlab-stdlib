%% H5VARIABLES get HDF5 dataset names
% get dataset names in a file under group
% default is datasets under "/", optionally under "/group"
%
%%% Inputs
% * file: filename
% * group: group name (optional)
%%% Outputs
% * names: variable names

function names = h5variables(file, group)
arguments
  file {mustBeTextScalar}
  group {mustBeTextScalar} = ''
end

if strempty(group)
  finf = h5info(file);
else
  finf = h5info(file, group);
end

ds = finf.Datasets;

if isempty(ds)
  names = [];
else
  names = {ds.Name};
end

names = string(names);

end


%!test
%! if !isempty(pkg('list', 'hdf5oct'))
%! pkg load hdf5oct
%! fn = tempname();
%! ds = '/a';
%! h5create(fn, ds, [1])
%! assert(h5variables(fn, ''), {ds})
%! delete(fn)
%! endif
