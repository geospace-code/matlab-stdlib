%% CPU_LOAD get total physical CPU load
%
% Returns the "recent cpu usage" for the whole system.
%
% This value is a double greater than 0.
% If the system recent cpu usage is not available, the method returns a negative or NaN value.

function L = cpu_load(method)
arguments
  method (1,:) string = ["java", "python", "sys"]
end

fun = choose_method(method, "cpu_load");

L = fun();


end
