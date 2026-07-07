function mustBeSymbolicLink(Path)

if stdlib.matlabOlderThan('R2024b')
  tf = stdlib.is_symlink(Path);
else
  tf = isSymbolicLink(Path);
end

if ~all(tf, 'all')
    files = string(Path);

    e = MException('MATLAB:validators:mustBeSymbolicLink', ...
        '%s is not a symbolic link', files(~tf));

    throw(e)
end

end
