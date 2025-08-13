%% REMOVE delete file or empty directory
%
% Matlab delete() has trouble with not being able to delete
% open files on Windows. This function mitigates that limitation by returning
% a boolean success status.

function ok = remove(filepath)
ok = false;

if ~stdlib.exists(filepath)
  return
end

% have to clear last warning before checking if lastwarning exists!
lastwarn('')

try %#ok<*TRYNC>
  delete(filepath);
  ok = true;
end

[~, id] = lastwarn();

if strcmp(id, 'MATLAB:DELETE:FileNotFound')
  ok = false;
end


end
