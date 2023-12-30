function c = canonical(p)
%% canonical(p)
% path need not exist, but canonical path is returned
%
% NOTE: some network file systems are not resolvable by Matlab Java
% subsystem, but are sometimes still valid--so return
% unmodified path if this occurs.
%
% This also resolves Windows short paths to full long paths.
%
%%% Inputs
% * p: path to make canonical
%%% Outputs
% * c: canonical path, if determined

arguments
  p string {mustBeScalarOrEmpty}
end

c = stdlib.fileio.canonical(p);

end
