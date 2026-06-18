%% IS_FOLDER Determine if path is a folder
%
% left for backward compatibility

function y = is_folder(fpath)
arguments
  fpath {mustBeTextScalar}
end

y = isfolder(fpath);

end
