%% WINDOWS_SHORTNAME Retrieves the Windows short name (Matlab optional MEX)
% (8.3 character) filename
%
%  Example of using a COM server (Scripting.FileSystemObject) in Windows
%
%  References:
%  https://learn.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/windows-scripting/ch28h2s7
%  https://www.mathworks.com/matlabcentral/fileexchange/48950-short-path-name-on-windows-com-server

function s = windows_shortname(p)
arguments
  p (1,1) string
end

s = "";

if ~ispc || stdlib.is_url(p)
  return
end

fso = actxserver('Scripting.FileSystemObject');

if isfolder(p)
  s = fso.GetFolder(p).ShortPath;
elseif isfile(p)
  s = fso.GetFile(p).ShortPath;
end

s = string(s);

delete(fso);

end

%!testif 0
