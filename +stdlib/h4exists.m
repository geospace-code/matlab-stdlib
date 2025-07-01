function exists = h4exists(file, variable)
%% H4EXISTS check if object exists in HDF4 file
%
%%% Inputs
% * file: data filename
% * variable: path of variable in file
%%% Outputs
% * exists: boolean
arguments
  file {mustBeTextScalar}
  variable {mustBeTextScalar}
end

sds = hdfinfo(file).SDS;
exists = ismember(variable, sds.Name);

end


%!testif 0
