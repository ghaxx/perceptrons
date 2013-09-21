function B = answer_sure(X)
	size_X = size(X, 1);
	A = zeros(size_X, 1);
	essential = 0;
	max = A(1);
	crop = 0.4;
	sure_enough = 0.3;
	
	for i=1 : size_X
		if( X(i) > crop )
			A(i) = X(i);
			essential = essential + 1;
			if max < A(i)
				max = A(i);
			end
		else
			A(i) = 0;
		end
	end
	if essential == 1
		sureness = sum(A);
	else
		if essential == 0
			sureness = 0;
		else
			sureness = sum(A) / essential;
			sureness = (1 / crop) * (max - sureness);
		end
	end
	if sureness > sure_enough
		B = answer_max(A);
	else
		B = answer_real(A);
	end
end