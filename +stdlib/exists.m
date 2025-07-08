%% EXISTS does path exist
%
% NOTE: in general on Windows exists("./not-exist/..") is true, but on
% Unix it is false.
% In C/C++ access() or stat() the same behavior is observed Windows vs Unix.
%
%%% Inputs
% * p: path to check
%%% Outputs
% * ok: true if exists

function y = exists(p)

y = isfile(p) | isfolder(p);

end

%!assert (!exists(''))
%!assert (!exists(tempname))
%!assert (exists(program_invocation_name))
