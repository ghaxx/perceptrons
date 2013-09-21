function y = logistic(x, alpha)
	a = alpha;
	y = 1 ./ (1 + exp(-a * x));
end