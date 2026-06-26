function i = get_process_priority()

try
  p = System.Diagnostics.Process.GetCurrentProcess();
  i = double(p.PriorityClass);
catch e
  i = dotnetException(e);
end

end
