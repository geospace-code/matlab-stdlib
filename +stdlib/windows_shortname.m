%% WINDOWS_SHORTNAME Retrieves the Windows short name (8.3 character) form
%
%  Example of using a COM server (Scripting.FileSystemObject) in Windows
%
%  References:
%  https://learn.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/windows-scripting/ch28h2s7
%  https://www.mathworks.com/matlabcentral/fileexchange/48950-short-path-name-on-windows-com-server

function short = windows_shortname(p)
arguments
  p (1,1) string
end

short = string.empty;

if ~ispc
  return
end

fso = actxserver('Scripting.FileSystemObject');

if isfolder(p)
  short = fso.GetFolder(p).ShortPath;
elseif isfile(p)
  short = fso.GetFile(p).ShortPath;
end

short = string(short);

delete(fso);

end
