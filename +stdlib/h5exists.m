function exists = h5exists(file, variable)
%% H5EXISTS check if object exists
%
%%% Inputs
% * file: data filename
% * variable: path of variable in file
%%% Outputs
% * exists: boolean
arguments
  file (1,1) string {mustBeFile}
  variable (1,1) string
end

exists = false;

try
  h5info(file, variable);
  exists = true;
catch e
  if e.identifier ~= "MATLAB:imagesci:h5info:unableToFind"
    rethrow(e)
  end
end

end
