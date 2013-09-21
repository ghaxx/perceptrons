%% OR Test
clrscr;
hold off;
fprintf('OR test in progress...\n');
[p t] = Semi_OR_Set;
set(gca,'CameraViewAngle',get(gca,'CameraViewAngle'))
% [net r E] = nnetwork_no_ones(p, t, [], 0.8, 0.9, 0.6, 100, 1, @energy_for_2D, [-6 6 60]);
 [net r E] = nnetwork_no_ones(p, t, [4], 0.8, 0.9, 0.6, 100, 1, @division_plane, [1 50 -6 6]);
[tR tr tE] = test_nn_no_ones(net, p, t);
%% XOR Test
clrscr;
fprintf('XOR test in progress...\n');
[p t] = XOR_Set;
% [net r E] = nnetwork_no_ones(p, t, [2], 0.8, 0.9, 0.6, 0.002, 1, @print_weights, [50]);
%  [net r E] = nnetwork_no_ones(p, t, [2], 0.8, 0.9, 0.6, 0.00035, 1, @division_plane, [16 32 0 1]);
% [net r E] = nnetwork_no_ones(p, t, [], 0.8, 0.9, 0.6, 0.00035, 1, @division_plane, [16 32 -6 6]);
 [net r E] = nnetwork_no_ones(p, t, [], 0.8, 0.9, 0.6, 100, 1, @energy_for_2D, [-6 6 60]);

%% XOR Test with amp
clrscr;
fprintf('XOR test in progress...\n');
[p t] = XOR_Set;
  [net r E] = nnetwork(p, t, [2], 0.8, 0.9, 0.6, 0.00035, 1, @division_plane, [16 32 0 1]);
% [net r E] = nnetwork(p, t, [2], 0.8, 0.9, 0.6, 0.002, 1, @print_weights, [50]);
% [net r E] = nnetwork(p, t, [2], 0.8, 0.9, 0.6, 100, 1, @energy_for_2D, [-6 6 60]);

%% Hill Test with amp
clrscr;
fprintf('XOR test in progress...\n');
[p t] = Hill_Set;
  [net r E] = nnetwork(p, t, [49 49], 0.8, 0.9, 0.6, 0, 1, @division_plane, [16 32 -6 6]);
% [net r E] = nnetwork(p, t, [2], 0.8, 0.9, 0.6, 0.002, 1, @print_weights, [50]);
% [net r E] = nnetwork(p, t, [2], 0.8, 0.9, 0.6, 100, 1, @energy_for_2D, [-6 6 60]);

%% ZOO Test
clrscr;
[p t] = ZOO_Set;
[net r E] = nnetwork(p, t, [8], 0.1, 0.9, 0.9, 30, 0);
fprintf('sredni blad sieci: %f\n', r);
R = test_nn(net, p, t);

%% ZOO Test XValidation
clrscr;
[p t] = ZOO_Set;
step = floor(size(t, 2)/10);
L = size(t, 2);
axis([0 9 0 1.1]);

[net r E] = nnetwork(p(:,step:L), t(:,step:L), [4 2], 0.1, 0.9, 0.6, 30, 0);
[R last_r last_E] = test_nn(net, p(:, 1:step-1),  t(:, 1:step-1));

fprintf('%.2f %.2f\n', last_r, last_E);
	
omni_r = last_r;
omni_E = E;
for i=1:9
	j = i*step;
	[net r E] = nnetwork([p(:,1:j-1) p(:,j+step:L)], [t(:,1:j-1) t(:,j+step:L)], [4 2], 0.1, 0.9, 0.6, 30, 0);
	
	[R r E] = test_nn(net, p(:, j:j+step-1),  t(:, j:j+step-1));
	fprintf('%.2f %.2f\n', r, E);
	plot([i-1 i],[last_r r], '-b');
	last_r = r;
	plot([i-1 i],[last_E E], '-r');
	last_E = E;
	omni_r = omni_r + r;
	omni_E = omni_E + E;
end
fprintf('sredni blad: %.2f %.2f\n', omni_r/10, omni_E/10);

%% Primary Tumor Test
clrscr;
[p t] = Primary_Tumor_Set;
[net r R] = nnetwork(p, t, [30 30 30], 0.03, 1, 0.8, 1, 0);
R = test_nn(net, p);

%% Primary Tumor Test XValidation
clrscr;
fprintf('Primary Tumor Test XValidation in progress...\n');
[p t] = Primary_Tumor_Set;
L = size(t, 2);
step = floor(size(t, 2)/10);
axis([0 9 0 1.1]);

[net r E] = nnetwork(p(:,step:L), t(:,step:L), [5], 0.2, 1, 0.5, 100, 0);
[R last_r last_E] = test_nn(net, p(:, 1:step-1),  t(:, 1:step-1));

fprintf('%.2f %.2f\n', last_r, last_E);

omni_r = last_r;
omni_E = E;
for i=1:9
	j = i*step;
	[net r E] = nnetwork([p(:,1:j-1) p(:,j+step:L)], [t(:,1:j-1) t(:,j+step:L)], [5], 0.2, 1, 0.5, 100, 0);
	[R r E] = test_nn(net, p(:, j:j+step-1),  t(:, j:j+step-1));
	fprintf('%.2f %.2f\n', r, E);
	plot([i-1 i],[last_r r], '-b');
	last_r = r;
	plot([i-1 i],[last_E E], '-r');
    drawnow;
	last_E = E;
	omni_r = omni_r + r;
	omni_E = omni_E + E;
end
fprintf('sredni blad: %.2f %.2f\n', omni_r/10, omni_E/10);

