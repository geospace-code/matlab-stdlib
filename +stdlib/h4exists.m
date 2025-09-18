function exists = h4exists(file, variable)
%% H4EXISTS check if object exists in HDF4 file
%
%%% Inputs
% * file: data filename
% * variable: path of variable in file
%%% Outputs
% * exists: boolean
% arguments
%   file
%   variable (1,1) string
% end

finf = hdfinfo(file);
sds = finf.SDS;
exists = any(isequal(variable, sds.Name));

end
