%% H4EXISTS check if object exists in HDF4 file
%
%%% Inputs
% * file: data filename
% * variable: path of variable in file
%%% Outputs
% * exists: boolean

function exists = h4exists(file, variable)
arguments (Input)
  file {mustBeTextScalar,mustBeFile}
  variable {mustBeTextScalar}
end
arguments (Output)
  exists (1,1) logical
end

finf = hdfinfo(file);
sds = finf.SDS;
exists = any(isequal(variable, sds.Name));

end
