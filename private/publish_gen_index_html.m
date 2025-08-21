%% PUBLISH_GEN_INDEX_HTML  generate index.html for package docs
% publish (generate) docs from Matlab project
% called from buildfile.m
%
% Ref:
% * https://www.mathworks.com/help/matlab/ref/publish.html
% * https://www.mathworks.com/help/matlab/matlab_prog/marking-up-matlab-comments-for-publishing.html
%
% for package code -- assumes no classes and depth == 1
%
% if *.mex* files are present, publish fails

function readme = publish_gen_index_html(pkg_name, tagline, project_url, outdir, styleFile)
arguments
  pkg_name (1,1) string
  tagline (1,1) string
  project_url (1,1) string
  outdir (1,1) string
  styleFile (1,1) string
end

pkg = what("+" + pkg_name);
% "+" avoids picking up cwd of same name
assert(~isempty(pkg), pkg_name + " is not detected as a Matlab directory or package")

%% Git info
repo = gitrepo(pkg.path);
git_txt = sprintf("Git branch / commit: %s %s %s", repo.CurrentBranch.Name, repo.LastCommit.ID{1}(1:8), repo.LastCommit.CommitterDate);

%% generate docs
readme = fullfile(outdir, "index.html");

if ~isfolder(outdir)
  mkdir(outdir);
end

copyfile(styleFile, outdir)

[~, n, s] = fileparts(styleFile);
styleName = strcat(n, s);

head = ["<!DOCTYPE html>", ...
'<head lang="en">',...
'<meta charset="UTF-8">', ...
'<meta name="color-scheme" content="dark light">', ...
'<meta name="viewport" content="width=device-width, initial-scale=1">', ...
sprintf('<meta name="generator" content="Matlab %s">', matlabRelease().Release), ...
sprintf('<link rel="stylesheet" href="%s">', styleName), ...
"<title>" + pkg_name + " API</title>", ...
"</head>"];

body = [
"<body>", ...
sprintf('<h1>%s API</h1>', pkg_name), ...
sprintf('<p>%s</p>', tagline), ...
sprintf('<p>%s</p>', git_txt)];

body = [body, ...
'<p id="userAgent"></p>', ...
'<script>document.getElementById("userAgent").textContent = navigator.userAgent;</script>', ...
"<p>Project URL: <a href=" + project_url + ">" + project_url + "</a></p>", ...
"<h2>API Reference</h2>"];

fid = fopen(readme, 'w');
fprintf(fid, join([head, body], newline));

publish_pkg(fid, pkg, pkg_name)

% fprintf(fid, "The functions below are for diagnostics or internal use. Users will only use the functions above.");

% for i = 1:numel(pkg.packages)
%   sn = pkg.packages(i);
%   sn = sn{1};
%   spkg = what(fullfile("+" + pkg_name, sn));
%
%   publish_pkg(fid, spkg, pkg_name)
% end

fprintf(fid, "</body>" + newline + "</html>");

fclose(fid);

end


function publish_pkg(fid, pkg, pkg_name)

outdir = fileparts(fopen(fid));

% [~, subname] = fileparts(pkg.path);
% if ~endsWith(subname, pkg_name)
%   pkg_name = pkg_name + "." + subname(2:end);
%   relpath = subname(2:end) + "/";
%   outdir = fullfile(outdir, relpath);
%   fprintf(fid, strcat('<h3>', pkg_name, '</h3>', newline));
% else
relpath = "";
% end

fprintf(fid, newline + "<table>" + newline);
fprintf(fid, "<tr><th>Function</th> <th>Description</th> <th>Backends</th></tr>" + newline);

Nbe = struct(dotnet=0, java=0, perl=0, python=0, sys=0, native=0, legacy=0, top_level=0);

for fun = pkg.m.'

Nbe.top_level = Nbe.top_level + 1;

[~, name] = fileparts(fun{1});

doc_fn = publish(pkg_name + "." + name, evalCode=false, outputDir=outdir);
disp(doc_fn)

% inject summary for each function into Readme.md
help_txt = splitlines(string(help(pkg_name + "." + name)));
words = split(strip(help_txt(1)), " ");

% error if no docstring
fname = words(1);
assert(endsWith(fname, name, IgnoreCase=true), "fname %s does not match name %s \nis there a docstring at the top of the .m file?", fname, name)

line = "<tr><td><a href=" + relpath + name + ".html>" + fname + "</a></td><td>";
if(length(words) > 1)
   line = join([line, words(2:end).']);
end

% req = "";
% if contains(help_txt(2), "requires:") || contains(help_txt(2), "optional:")
%   req = "<strong>(" + strip(help_txt(2), " ") + ")</strong>";
% end

% determine which backends might exist for this function
req = "";
for bkd = string(pkg.packages).'
  if ~isempty(which(pkg_name + "." + bkd + "." + name))
    Nbe.(bkd) = Nbe.(bkd) + 1;
    req = req + " " + bkd;
  end
end

fprintf(fid, line + "</td> <td>" + req + "</td></tr>" + newline);

end

fprintf(fid, "</table>" + newline);

fprintf(fid, "<h2>Function counts</h2>" + newline + "<ul>" + newline);

for n = string(fieldnames(Nbe)).'
  fprintf(fid, " <li>%s: %d</li>\n", n, Nbe.(n));
end

fprintf(fid, "</ul>" + newline);

end
