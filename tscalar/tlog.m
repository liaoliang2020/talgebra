function log_result = tlog(tscalar)
	log_result = ifftn(log(fftn(tscalar)));
end

