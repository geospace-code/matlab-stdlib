%% H5EXISTS check if object exists
%
%%% Inputs
% * file: data filename
% * variable: path of variable in file
%%% Outputs
% * exists: boolean

function exists = h5exists(file, variable)
arguments
  file (1,1) string
  variable (1,1) string
end

exists = false;

try
  h5info(file, variable);
  exists = true;
catch e
  if ~strcmp(e.identifier, 'MATLAB:imagesci:h5info:unableToFind') && ...
     ~strncmp(e.message, "h5info: location", 16)
    disp(e)
    rethrow(e)
  end
end

end

%!test
%! if !isempty(pkg('list', 'hdf5oct'))
%! pkg load hdf5oct
%! fn = tempname();
%! ds = '/a';
%! h5create(fn, ds, [1])
%! assert(h5exists(fn, ds))
%! assert(!h5exists(fn, '/b'))
%! delete(fn)
%! endif
