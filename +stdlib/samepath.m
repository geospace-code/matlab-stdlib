%% SAMEPATH is path the same
%
% true if inputs resolve to same path.
% Both paths must exist.
%
% NOTE: in general on Windows same(".", "not-exist/..") is true, but on
% Unix it is false.
% In C/C++ access() or stat() the same behavior is observed Windows vs Unix.
%
% Ref: https://devblogs.microsoft.com/oldnewthing/20220128-00/?p=106201
%
%%% Inputs
% * path1, path2: paths to compare

function y = samepath(path1, path2, method)
arguments
  path1 {mustBeTextScalar}
  path2 {mustBeTextScalar}
  method (1,:) string = ["python", "java", "sys", "native"]
end

% For this function, Python is over 10x faster than Java

fun = choose_method(method, "samepath");

y = fun(path1, path2);

end
