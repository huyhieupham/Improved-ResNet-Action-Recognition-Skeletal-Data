function [net, info] = res_cifar(m, varargin)

setup;
opts.modelType = 'resnet' ;
opts.preActivation = false;
opts.reLUafterSum = true;
opts.shortcutBN = true;
[opts, varargin] = vl_argparse(opts, varargin) ;

if opts.preActivation ,
opts.expDir = fullfile('exp', ...
  sprintf('%s-%d', opts.modelType,m)) ;
else
     opts.expDir = fullfile('exp', ...
  sprintf('Original-ResNet-%d',m)) ;
end
opts.dataDir = fullfile('data','cifar') ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.imdbPath = fullfile(opts.dataDir, 'imdb.mat');
opts.whitenData = true;
opts.contrastNormalization = true;
opts.meanType = 'image'; % 'pixel' | 'image'
opts.border = [4 4 4 4]; % tblr
opts.gpus = []; 
opts.checkpointFn = [];
opts = vl_argparse(opts, varargin) ;

if numel(opts.border)~=4, 
  assert(numel(opts.border)==1);
  opts.border = ones(1,4) * opts.border;
end

% -------------------------------------------------------------------------
%                        Prepare model and data
% -------------------------------------------------------------------------

if opts.preActivation ,
    net = resnet_preactivation_init(m) ;
else
    net = resnet_init(m, 'networkType', opts.modelType, ...
      'reLUafterSum', opts.reLUafterSum) ;
end

if ~exist('imdb', 'var'), 
  
  imdb = as1_data_setup('./AS1');
  imdb = normalizeIMDB(imdb);
  
end

net.meta.classes.name = imdb.meta.classes(:)' ;


% -------------------------------------------------------------------------
%                                                                     Train
% -------------------------------------------------------------------------

trainfn = @cnn_train_dag_check;

rng('default');
[net, info] = trainfn(net, imdb, getBatch(opts), ...
  'expDir', opts.expDir, ...
  net.meta.trainOpts, ...
  'gpus', opts.gpus, ...
  'val', find(imdb.images.set == 2), ...
  'derOutputs', {'loss', 1}, ...
  'checkpointFn', opts.checkpointFn) ;

% -------------------------------------------------------------------------
function fn = getBatch(opts)
% -------------------------------------------------------------------------
bopts = struct('numGpus', numel(opts.gpus)) ;
fn = @(x,y) getDagNNBatch(bopts,x,y) ;

% -------------------------------------------------------------------------
function inputs = getDagNNBatch(opts, imdb, batch)
% -------------------------------------------------------------------------
images = imdb.images.data(:,:,:,batch) ;
labels = imdb.images.labels(1,batch) ;
if opts.numGpus > 0
  images = gpuArray(images) ;
end
inputs = {'image', images, 'label', labels} ;

