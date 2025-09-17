%% IS_FOLDER Determine if path is a folder
%
% for Matlab < R2017b that doesn't have isfolder(), note that exist() also looks
% on the Matlab path.

function y = is_folder(fpath)

try
  y = isfolder(fpath);
catch e
  if strcmp(e.identifier, 'MATLAB:UndefinedFunction')
    y = exist(fpath, 'dir') == 7;
  else
    rethrow(e)
  end
end

end
