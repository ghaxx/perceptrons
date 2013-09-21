%% Genetic approach
population = 4;
[p t] = XOR_Set;

for i=1:population
	[net(i) r(i) E(i)] = nnetwork(p, t, [2], 0.8, 0.9, 0.6, 1, 0, @print_weights, [100]);
end

best = 1;
generation = 1;
while E(best) > 0.01
	for i=1:population
		[net(i) r(i) E(i)] = nnetwork(p, t, net(i), 0.8, 0.9, 0.6, 20, 0, @print_weights, [100]);
	end
	
	index = randperm(population);
	for i=1:population:2
		a = net(index(i)).w{1};
		net(index(i)).w{1} = net(index(i+1)).w{1};
		net(index(i+1)).w{1} = a;
	end
	
	for i=1:population
		for j=1:size(net(i).w)
% 			net(i).w{j} / 10
			net(i).w{j} = net(i).w{j} + (net(i).w{j} / 100);
		end
	end

	best = 1;
	for i=1:population
		if(E(i) < E(best))
			best = i;
		end
	end
	division_plane(net(best), generation, r(best), E(best), p, t, [1 16 -2 2], 1);
	generation = generation + 1;
end