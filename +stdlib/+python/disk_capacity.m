function i = disk_capacity(file)
arguments
  file (1,1) string
end

i = disk_usage(file, 'total');

end
