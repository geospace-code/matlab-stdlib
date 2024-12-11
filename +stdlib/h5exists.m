%% H5EXISTS check if object exists
%
%%% Inputs
% * file: data filename
% * variable: path of variable in file
%%% Outputs
% * exists: boolean

function exists = h5exists(file, variable)
% arguments
%   file (1,1) string {mustBeFile}
%   variable (1,1) string
% end

exists = false;

try
  h5info(file, variable);
  exists = true;
catch e
  if stdlib.isoctave
    disp(e.message)
    if strcmp(e.identifier, "Octave:undefined-function") || isempty(strfind(e.message, 'does not exist'))
      rethrow(e)
    end
  else
    if ~strcmp(e.identifier, 'MATLAB:imagesci:h5info:unableToFind')
      rethrow(e)
    end
  end
end

end

%!test
%! pkg load hdf5oct
%! fn = tempname();
%! ds = '/a';
%! h5create(fn, ds, [1])
%! assert(h5exists(fn, ds))
%! delete(fn)
