function i = get_process_priority()

if stdlib.has_dotnet()
  p = System.Diagnostics.Process.GetCurrentProcess();
  i = double(p.PriorityClass);
else
  i = missing;
end

end
