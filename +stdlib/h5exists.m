%% H5EXISTS check if object exists
%
%%% Inputs
% * file: data filename
% * variable: path of variable in file
%%% Outputs
% * exists: boolean

function exists = h5exists(file, variable)
arguments
  file
  variable (1,1) string
end

exists = false;

try
  h5info(file, variable);
  exists = true;
catch e
  if ~strcmp(e.identifier, 'MATLAB:imagesci:h5info:unableToFind')
    rethrow(e)
  end
end

end
