function idem_base = idempotent_base(tsize)
	% Created by Liang Liao on 20200122

	idem_base = eye(prod(tsize));
	idem_base = reshape(idem_base, [tsize, prod(tsize) ] );
	for i = 1: numel(tsize)
		idem_base = ifft(idem_base, [], i);
	end
	idem_base = reshape(idem_base, prod(tsize), prod(tsize));

end



