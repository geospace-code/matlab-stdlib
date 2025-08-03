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

function publish_gen_index_html(pkg_name, tagline, project_url, outdir)
arguments
  pkg_name {mustBeTextScalar}
  tagline {mustBeTextScalar}
  project_url {mustBeTextScalar}
  outdir {mustBeTextScalar}
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

txt = ["<!DOCTYPE html>", ...
"<head>",...
'<meta name="color-scheme" content="dark light">', ...
'<meta name="viewport" content="width=device-width, initial-scale=1">', ...
'<meta name="generator" content="Matlab ' + matlabRelease().Release + '">', ...
"<title>" + pkg_name + " API</title>", ...
"</head>", ...
"<body>", ...
"<h1>" + pkg_name + " API</h1>", ...
"<p>" + tagline + "</p>", ...
"<p>" + git_txt + "</p>", ...
"<p>Project URL: <a href=" + project_url + ">" + project_url + "</a></p>", ...
"<h2>API Reference</h2>"];
fid = fopen(readme, 'w');
fprintf(fid, join(txt, newline));

publish_pkg(fid, pkg, pkg_name)

fprintf(fid, "The functions below are for diagnostics or internal use. Users will only use the functions above.");

for i = 1:numel(pkg.packages)
  sn = pkg.packages(i);
  sn = sn{1};
  spkg = what(fullfile("+" + pkg_name, sn));

  publish_pkg(fid, spkg, pkg_name)
end

fprintf(fid, "</body> </html>");

fclose(fid);

end


function publish_pkg(fid, pkg, pkg_name)

outdir = fileparts(fopen(fid));

[~, subname] = fileparts(pkg.path);
if ~endsWith(subname, pkg_name)
  pkg_name = pkg_name + "." + subname(2:end);
  relpath = subname(2:end) + "/";
  outdir = fullfile(outdir, relpath);
  fprintf(fid, strcat('<h3>', pkg_name, '</h3>', newline));
else
  relpath = "";
end

for fun = pkg.m.'

[~, name] = fileparts(fun{1});

doc_fn = publish(pkg_name + "." + name, evalCode=false, outputDir=outdir);
disp(doc_fn)

% inject summary for each function into Readme.md
help_txt = splitlines(string(help(pkg_name + "." + name)));
words = split(strip(help_txt(1)), " ");

% error if no docstring
fname = words(1);
assert(endsWith(fname, name, IgnoreCase=true), "fname %s does not match name %s \nis there a docstring at the top of the .m file?", fname, name)

line = "<a href=" + relpath + name + ".html>" + fname + "</a> ";
if(length(words) > 1)
   line = join([line, words(2:end).']);
end

req = "";

if contains(help_txt(2), "requires:") || contains(help_txt(2), "optional:")
  req = "<strong>(" + strip(help_txt(2), " ") + ")</strong>";
end

fprintf(fid, line + " " + req + "<br>" + newline);

end

end
