function c = canonical(p)
%% canonical(p)
% If exists, canonical absolute path is returned
% if path does not exist, normalized relative path is returned
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
  p (1,1) string
end

c = stdlib.fileio.canonical(p);

end
