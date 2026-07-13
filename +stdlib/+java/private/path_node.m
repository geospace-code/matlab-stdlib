function i = path_node(file, ntype)


if ~ispc()
  opt = javaMethod('values', 'java.nio.file.LinkOption');

  switch ntype
    case 'device'
      m = 'unix:dev';
    case 'inode'
      m = 'unix:ino';
    otherwise, error('unknown path_node type %s', ntype)
  end
  % Java 1.8 benefits from the absolute() for stability
  % seen on older Matlab versions on HPC
  i = java.nio.file.Files.getAttribute(javaAbsolutePath(file), m, opt);
  i = uint64(i);
else
  i = missing;
end
