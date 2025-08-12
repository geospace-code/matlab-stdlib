%% IS_MEX_FUN detect if a function is loaded as MEX or plain .m

function y = is_mex_fun(name)

% this method is 4x faster than using inmem() and processing strings

y = endsWith(which(name), mexext());

end
