%% GET_OWNER owner name of file or directory
%
%%% Inputs
% * p: path to examine
%%% Outputs
% * n: owner, or empty if path does not exist

function n = get_owner(file, method)
arguments
  file {mustBeTextScalar}
  method (1,:) string = ["java", "dotnet", "python" "sys"]
end

fun = choose_method(method, "get_owner");

n = fun(file);

end
