function acos_result = tacos(tscalar)
	acos_result = ifftn(acos(fftn(tscalar)) )
end