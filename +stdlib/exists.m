%% EXISTS does path exist
%
% NOTE: in general on Windows exists("./not-exist/..") is true, but on
% Unix it is false.
% In C/C++ access() or stat() the same behavior is observed Windows vs Unix.
%
%%% Inputs
% * fpath: path to check
%%% Outputs
% * ok: true if exists

function y = exists(fpath)

try
  y = isfile(fpath) || isfolder(fpath);
catch e
  if strcmp(e.identifier, 'MATLAB:UndefinedFunction')
    y = exist(fpath,'file') == 2 || exist(fpath, 'dir') == 7;
  else
    rethrow(e)
  end
end

end

%!assert (stdlib.exists('.'))