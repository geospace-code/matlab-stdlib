function c = resolve(p)
%% resolve(p)
% path need not exist--absolute path will be relative to pwd if not exist
% if path exists, same result as canonical()
%
% NOTE: some network file systems are not resolvable by Matlab Java
% subsystem, but are sometimes still valid--so return
% unmodified path if this occurs.
%
% This also resolves Windows short paths to full long paths.
%
%%% Inputs
% * p: path to resolve
%%% Outputs
% * c: resolved path

arguments
  p string {mustBeScalarOrEmpty}
end

c = stdlib.fileio.resolve(p);

end
