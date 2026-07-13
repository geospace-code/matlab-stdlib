function i = path_node(file, ntype)

switch ntype
  case 'device'
    m = 'unix:dev';
  case 'hard_link_count'
    m = 'unix:nlink';
  case 'inode'
    m = 'unix:ino';
  otherwise, error('unknown path_node type %s', ntype)
end
% Java 1.8 benefits from the absolute() for stability
% seen on older Matlab versions on HPC

opt = java.nio.file.LinkOption.values();

i = java.nio.file.Files.getAttribute(javaAbsolutePath(file), m, opt);

i = uint64(i);

end
