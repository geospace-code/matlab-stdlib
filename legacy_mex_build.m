function legacy_mex_build(top, bindir)
arguments
  top (1,1) string
  bindir (1,1) string
end

[compiler_id, compiler_opt] = get_compiler_options();

srcs = get_mex_sources(top);

%% build C++ mex
% https://www.mathworks.com/help/matlab/ref/mex.html
for s = srcs
  src = s{1};
  [~, name] = fileparts(src(1));
  disp("Building MEX target: " + name)
  mex(s{1}{:}, "-outdir", bindir, compiler_id, compiler_opt)
end

end
