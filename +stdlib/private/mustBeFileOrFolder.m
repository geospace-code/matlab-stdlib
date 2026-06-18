function mustBeFileOrFolder(Path)

tf = isfile(Path) | isfolder(Path);

if ~all(tf, 'all')
    files = string(Path);

    e = MException('MATLAB:validators:mustBeFileOrFolder', ...
        '%s is not a file or folder', files(~tf));

    throw(e)
end

end
