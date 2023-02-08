function abspath = canonical(p)
%% canonical(p)
% path need not exist, but absolute path is returned
%
% NOTE: some network file systems are not resolvable by Matlab Java
% subsystem, but are sometimes still valid--so return
% unmodified path if this occurs.
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
