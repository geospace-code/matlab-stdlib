%% H5EXISTS check if object exists
%
%%% Inputs
% * file: data filename
% * variable: path of variable in file
%%% Outputs
% * exists: boolean

function exists = h5exists(file, variable)

try
  h5info(file, variable);
  exists = true;
catch e
  if e.identifier ~= "MATLAB:imagesci:h5info:unableToFind"
    rethrow(e)
  end

  exists = false;
end

end
