function a = absolute_path(p)
%% absolute_path(p)
% path need not exist, but absolute path is returned
%
% NOTE: some network file systems are not resolvable by Matlab Java
% subsystem, but are sometimes still valid--so return
% unmodified path if this occurs.
%
%%% Inputs
% * p: path to make absolute
%%% Outputs
% * a: absolute path, if determined

arguments
  p (1,1) string
end

a = stdlib.fileio.absolute_path(p);

end
