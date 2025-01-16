%% IS_ADMIN is the process run as root / admin (requires MEX)

function is_admin()
error("need to 'buildtool mex' or 'legacy_mex_build()' first")
end
