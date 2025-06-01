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
arguments
  p {mustBeTextScalar}
end

% Matlab >= R2024b allowed URLs to act like files or folders.
% fileattrib() does not consider URLs to be a file or folder
% at least through Matlab R2025a.

y = strlength(p) && fileattrib(p) == 1;

end

%!assert (!exists(''))
%!assert (!exists(tempname))
%!assert (exists(program_invocation_name))
