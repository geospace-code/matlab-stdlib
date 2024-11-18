function exists = h4exists(file, variable)
%% H4EXISTS
% check if object exists in HDF4 file
%
%%% Inputs
% * file: data filename
% * variable: path of variable in file
%%% Outputs
% * exists: boolean
arguments
  file (1,1) string {mustBeFile}
  variable (1,1) string {mustBeNonzeroLengthText}
end

exists = false;

try
  sds = hdfinfo(file).SDS;
  i = string(sds.Name) == variable;
  exists = any(i);
catch e
  if e.identifier ~= "MATLAB:imagesci:h5info:unableToFind"
    rethrow(e)
  end
end
