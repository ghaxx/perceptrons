function [net r E] = nnetwork(P, T, n_vector, eta, alpha, d_momentum, learning_factor, do_plot, plot_func, args)
	% Nothing -----------------------------------
	r = 0;
    E = 0;
    size_P = size(P);
    size_T = size(T);
	
	if isfield(n_vector, 'w') == 1
		net = n_vector;
		n_vector_size = size(n_vector.w);
		size_w = [1, n_vector_size(2)];
	else
		n_vector_size = size(n_vector);

		% Checking ----------------------------------
		if check(n_vector_size) == 0 
			net = 0;
			return
		end

		% Building Network --------------------------
		net.alpha = alpha;
		net.w = cell(1, n_vector_size(2) - 1);
		net.d_w = cell(1, n_vector_size(2) - 1);
		n_vector = [size_P(1), n_vector, size_T(1)];
		for i=1 : n_vector_size(2)+1
		   net.w{i} = randn(n_vector(i) + 1, n_vector(i + 1)) / 10;
	% 	   net.w{i} = ones(n_vector(i) + 1, n_vector(i + 1)) / 10;
		   net.d_w{i} = zeros(n_vector(i) + 1, n_vector(i + 1));
		end
		size_w = [1, n_vector_size(2)+1];
	end
	% Learning ----------------------------------
	% Learning set vectors are vertical
	step = 1;
	last_r = 0;
	ek = 0;
	E = 0;
	last_E = 0;
	not_done = 1;
	
	%while r < smart_net
	iteration = 1;
	while not_done == 1
		r = 0;
        E = 0;
		index = randperm(size_P(2));
		for i=1 : size_P(2)
			% result for input, horizontal		
			V = cell(1, size_w(2)+1);
			Y = cell(1, size_w(2)+1);
			V{1} = P(:, index(i))';
			Y{1} = P(:, index(i))';

			for j=1: size_w(2)
				V{j+1} = [1 Y{j}] * net.w{j};
				Y{j+1} = logistic(V{j+1}, alpha);
			end
			
			Y_last = Y{size_w(2)+1};
			if(answer_real(Y_last') == T(:,  index(i)))
				r = r + 1;
			end
			% Error for last layer --------------------------
			ek = T(:,  index(i))' - Y_last;
			% MSE
			E = E + sum(ek .* ek) / 2;
			
			% correcting last layer -------------------------
			d = alpha * ek .* (1 - Y_last) .* Y_last ;
			net.d_w{ size_w(2) } = d_momentum * net.d_w{ size_w(2) } + eta * [1 Y{size_w(2)}]' * d;
			net.w{ size_w(2) } = net.w{ size_w(2) } + net.d_w{ size_w(2) };
			
			% predescing layers -----------------------------
			for j = size_w(2)-1 : -1 : 1
				d = logistic_prim( V{j+1}, alpha ) .* (d * net.w{ j+1 }(2:end,:)');
				
				net.d_w{ j } = d_momentum * net.d_w{ j } + eta * [1 Y{j}]' * d;
				net.w{ j } = net.w{ j } + net.d_w{ j };
				
			end
		end % for i=1 : size_P(2)
		
        % Calculating errors and energy for stable, after-era network
		[R r E] = test_nn(net, P, T);
        
		if do_plot>=1
			plot_func(net, iteration, r, E, P, T, args, 1);
        end
        
		step = step+1;
		if learning_factor >= 1
			if step > learning_factor
				not_done = 0;
			end
		else
			if E <= learning_factor
				not_done = 0;
			end
		end
		iteration = iteration + 1;
		if iteration > 40000
			iteration = 1;
			for i=1 : n_vector_size(2)+1
			   net.w{i} = randn(n_vector(i) + 1, n_vector(i + 1)) / 10;
			   net.d_w{i} = zeros(n_vector(i) + 1, n_vector(i + 1));
			end
		end
	end
	r = 1 - r;
end
%----------------------------------------------------
function [V lV] = process(P, T, net) 
	size_w = size(net.w);
	V = cell(1, size_w(2)+1);
	lV = cell(1, size_w(2)+1);
	V{1} = P';
	lV{1} = logistic(V{1});
	
	for i=1: size_w(2)
		V{i} = [1 V{i}];
		lV{i} = [1 lV{i}];
		V{i+1} = V{i} * net.w{i};
		lV{i+1} = lV{i} * net.w{i};
	end
	
end
%----------------------------------------------------
function y = logistic(x, alpha)
	a = alpha;
	y = 1 ./ (1 + exp(-a * x));
end
%----------------------------------------------------
function y = logistic_prim(x, alpha)
	a = alpha;
	y = a * logistic(x, a) .* (1 - logistic(x, a));
end
%----------------------------------------------------
function c = check(n_vector_size)
	c = 1;
    if n_vector_size(2) == 0
        fprintf('Brak warstw ukrytych... Zwyklego perceptrona uzyj.\n');
% 		c = 0;
        return        
    end
    if n_vector_size(1) ~= 1
       fprintf('Do opisu warstw ukrytych mial byc wektor a nie macierz. Siec 3D?\n'); 
	   c = 0;
	   return
	end
end