function issame = samepath(path1, path2)
%% issame = samepath(path1, path)
% true if inputs resolve to same path

issame = gemini3d.fileio.absolute_path(path1) == gemini3d.fileio.absolute_path(path2);
end
