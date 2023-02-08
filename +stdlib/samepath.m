function issame = samepath(path1, path2)
%% samepath(path1, path)
% true if inputs resolve to same path
% files need not exist
%%% Inputs
% * path1, path2: paths to compare
%%% Outputs
% issame: logical
arguments
  path1 string {mustBeScalarOrEmpty}
  path2 string {mustBeScalarOrEmpty}
end

issame = stdlib.fileio.samepath(path1, path2);

end
