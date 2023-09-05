function abspath = absolute_path(p)
%% absolute_path(p)
% path need not exist, but absolute path is returned
%
% NOTE: some network file systems are not resolvable by Matlab Java
% subsystem, but are sometimes still valid--so return
% unmodified path if this occurs.
%
% This also resolves Windows short paths to full long paths.
%
%%% Inputs
% * p: path to make absolute
%%% Outputs
% * abspath: absolute path, if determined

arguments
  p string {mustBeScalarOrEmpty}
end

abspath = stdlib.fileio.absolute_path(p);

end
