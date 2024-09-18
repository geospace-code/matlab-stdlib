function t = filesystem_type(p)
arguments
  p (1,1) string
end

t = string(java.nio.file.Files.getFileStore(java.io.File(p).toPath()).type());

end
