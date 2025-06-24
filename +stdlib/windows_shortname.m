%% WINDOWS_SHORTNAME Retrieves the Windows short name
% optional: mex
%
% (8.3 character) filename
%
%  Example of using a COM server (Scripting.FileSystemObject) in Windows
%
%  References:
%  https://learn.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/windows-scripting/ch28h2s7
%  https://www.mathworks.com/matlabcentral/fileexchange/48950-short-path-name-on-windows-com-server

function s = windows_shortname(p)
arguments
  p {mustBeTextScalar}
end

s = p;
if ispc
  fso = actxserver('Scripting.FileSystemObject');

  if isfolder(p)
    s = fso.GetFolder(p).ShortPath;
  elseif isfile(p)
    s = fso.GetFile(p).ShortPath;
  end

  delete(fso);
end

if isstring(p)
  s = string(s);
end

end

%!test
%! if ispc
%! pkg load windows
%! c = getenv('ProgramFiles');
%! assert(strlength(windows_shortname(c)) == 11)
%! endif
