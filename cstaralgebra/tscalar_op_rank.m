function operator_rank = tscalar_op_rank(tscalar)
	mytrank = tproduct(tpinv(tscalar, size(tscalar) ), tscalar)
	%mytrank = trank(tscalar, size(tscalar))
	operator_rank = tscalar_op_trace(mytrank);
end