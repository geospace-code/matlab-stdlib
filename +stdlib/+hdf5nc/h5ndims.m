function frank = h5ndims(file, variable)
%% h5ndims(file, variable)
% get number of dimensions of an HDF5 dataset
%
%%% Inputs
% * file: data filename
% * variable: name of variable inside file
%
%%% Outputs
% * frank: number of variable dimensions (like Matlab ndims)

arguments
  file (1,1) string {mustBeFile}
  variable (1,1) string {mustBeNonzeroLengthText}
end

dsi = h5info(stdlib.fileio.expanduser(file), variable).Dataspace;
if dsi.Type == "scalar"
  frank = 0;
else
  frank = length(dsi.Size);
end

end
