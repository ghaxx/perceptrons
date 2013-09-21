function A = answer_real(X)
	size_X = size(X);
	A = zeros(size_X(1), 1);
	for i=1 : size_X(1)
		if( X(i) > 0.5 )
			A(i) = 1;
		end
	end
end