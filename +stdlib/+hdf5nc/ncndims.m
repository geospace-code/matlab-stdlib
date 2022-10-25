function frank = ncndims(file, variable)
%% ncndims(file, variable)
% get number of dimensions of a variable in the file
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

dsi = ncinfo(stdlib.fileio.expanduser(file), variable);
if isempty(dsi.Dimensions)
  frank = 0;
else
  frank = length(dsi.Size);
end

end
