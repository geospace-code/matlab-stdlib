%% PUBLISH_GEN_INDEX_HTML  generate index.html for package docs
% publish (generate) docs from Matlab project
% called from buildfile.m
%
% Ref:
% * https://www.mathworks.com/help/matlab/ref/publish.html
% * https://www.mathworks.com/help/matlab/matlab_prog/marking-up-matlab-comments-for-publishing.html
%
% for package code -- assumes no classes and depth == 1
function publish_gen_index_html(pkg_name, tagline, project_url, outdir)
arguments
  pkg_name (1,1) string
  tagline (1,1) string
  project_url (1,1) string
  outdir (1,1) string
end

pkg = what("+" + pkg_name);
% "+" avoids picking up cwd of same name
assert(~isempty(pkg), pkg_name + " is not detected as a Matlab directory or package")

%% Git info
repo = gitrepo(pkg.path);
git_txt = "Git branch / commit: " + repo.CurrentBranch.Name + " " + extractBefore(repo.LastCommit.ID, 8);

%% generate docs
readme = fullfile(outdir, "index.html");

if ~isfolder(outdir)
  mkdir(outdir);
end

txt = ["<!DOCTYPE html> <head> <title>" + pkg_name + " API</title> <body>", ...
     "<h1>" + pkg_name + " API</h1>", ...
     "<p>" + tagline + "</p>", ...
     "<p>" + git_txt + "</p>", ...
     "<p>Project URL: <a href=" + project_url + ">" + project_url + "</a></p>", ...
     "<h2>API Reference</h2>"];
fid = fopen(readme, 'w');
fprintf(fid, join(txt, "\n"));

for sub = pkg.m.'

s = sub{1};
[~, name] = fileparts(s);
doc_fn = publish(pkg_name + "." + name, evalCode=false, outputDir=outdir);
disp(doc_fn)

% inject summary for each function into Readme.md
summary = split(string(help(pkg_name + "." + name)), newline);
words = split(strip(summary(1)), " ");

% error if no docstring
fname = words(1);
assert(lower(fname) == lower(name), "fname %s does not match name %s \nis there a docstring at the top of the .m file?", fname, name)

line = "<a href=" + name + ".html>" + fname + "</a> ";
if(length(words) > 1)
  line = line + join(words(2:end));
end

fprintf(fid, line + "<br>\n");

end

fprintf(fid, "</body> </html>");

fclose(fid);

end
