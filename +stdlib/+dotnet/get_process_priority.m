function i = get_process_priority()

p = System.Diagnostics.Process.GetCurrentProcess();
i = p.PriorityClass;

end
