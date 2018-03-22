function experiments(Ns, MTs, varargin)
 
%  Try to run this code on GPU by using: experiments([20 32 44 56 110], 'resnet', 'gpus', [1]);

setup;

opts.expDir = fullfile('data', 'exp');
opts.gpus = 1;
opts.preActivation = false;
opts.reLUafterSum = true;
opts = vl_argparse(opts, varargin); 

n_exp = numel(Ns); 
if ischar(MTs) || numel(MTs)==1, 
  if opts.preActivation, MTs='Original-ResNet'; end 
  if ischar(MTs), MTs = {MTs}; end; 
  MTs = repmat(MTs, [1, n_exp]); 
else
  assert(numel(MTs)==n_exp);
end

expRoot = opts.expDir; 

for i=1:n_exp, 
  opts.checkpointFn = @() plot_results(expRoot, 'cifar',[],[], 'plots', {MTs{i}});
  opts.expDir = fullfile(expRoot, ...
    sprintf('cifar-%s-%d', MTs{i}, Ns(i))); 
  [net,info] = resnet(Ns(i), 'modelType', MTs{i}, opts); 
end
