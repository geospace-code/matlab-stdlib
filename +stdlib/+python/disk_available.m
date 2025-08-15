function i = disk_available(file)
arguments
  file (1,1) string
end

i = disk_usage(file, 'free');

end
