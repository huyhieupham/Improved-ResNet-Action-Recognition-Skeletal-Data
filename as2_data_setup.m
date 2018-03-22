function imdb = data_setup_msr_3d_skeleton(folder)
	
	imdb = struct();    
	
	highArmWave = dir([folder '/HighArmWave/*.png']);
	handCatch = dir([folder '/HandCatch/*.png']);
	drawX = dir([folder '/DrawX/*.png']);
	drawCircle = dir([folder '/DrawCircle/*.png']);
    drawTick = dir([folder '/DrawTick/*.png']);
	twoHandWave = dir([folder '/TwoHandWave/*.png']);
    forwardKick = dir([folder '/ForwardKick/*.png']);
	sideBoxing  = dir([folder '/SideBoxing/*.png']);
	
	H = 32;
    W = 32;
    CH = 3;
	
	NhighArmWave = numel(highArmWave);
	NhandCatch = numel(handCatch);
	NdrawX = numel(drawX);
	NdrawCircle = numel(drawCircle);
	NdrawTick = numel(drawTick);
	NtwoHandWave = numel(twoHandWave);
	NforwardKick = numel(forwardKick);
	NsideBoxing = numel(sideBoxing);
	
	
	N = NhighArmWave + NhandCatch + NdrawX;
	N = N + NdrawCircle + NdrawTick + NtwoHandWave;
	N = N + NforwardKick + NsideBoxing;
	
	meta.sets = {'train', 'test'};
	meta.classes = {'HighArmWave', 'HandCatch', 'DrawX',...
                    'DrawCircle', 'DrawTick', 'TwoHandWave', ...
                    'ForwardKick', 'SideBoxing',...
                    };
					

	% images go here
	images.data = zeros(H, W, CH, N, 'single');
	% this will contain the mean of the training set
	images.data_mean = zeros(H, W, CH, 'single');
	% a label per image
	images.labels = zeros(1, N);
	% vector indicating to which set an image belong, i.e.,
	% training, validation, etc.
	images.set = zeros(1, N);

	numImgsTrain = 0;
	
	% Loading the 1st category data.
    
     
    
	for i=1:numel(highArmWave)
        fprintf('Loading %d out of %d images from HighArmWave folder \r\n',...
        i, length(highArmWave));
		im = single(imread([folder '/HighArmWave/', highArmWave(i).name]));
        im = imresize(im,[32 32]);
		images.data(:,:,:,i) = im;
		images.labels(i) = 1;

		% Selecting the set (train/val) randomly.
        
		if(randi(10, 1) > 5)
			images.set(i) = 1;
			images.data_mean = images.data_mean + im;
			numImgsTrain = numImgsTrain + 1;
		else
			images.set(i) = 2;
		end
    end
    
    num_cur = NhighArmWave;
    
	% Loading the 2nd category data.
    
	for i=1:numel(handCatch)
        fprintf('Loading %d out of %d images from HandCatch folder \r\n',...
        i, length(handCatch));
		im = single(imread([folder '/HandCatch/', handCatch(i).name]));
        im = imresize(im,[32 32]);
		images.data(:,:,:,num_cur+i) = im;
		images.labels(num_cur+i) = 2;

		% Selectng the set (train/val) randomly.
        
		if(randi(10, 1) > 5)
			images.set(num_cur+i) = 1;
			images.data_mean = images.data_mean + im;
			numImgsTrain = numImgsTrain + 1;
		else
			images.set(num_cur+i) = 2;
		end
    end
    
    num_cur = num_cur + NhandCatch;
    
    % Loading the 3rd category data.
    
	for i=1:numel(drawX)
        fprintf('Loading %d out of %d images from DrawX folder \r\n',...
        i, length(drawX));
		im = single(imread([folder '/DrawX/', drawX(i).name]));
        im = imresize(im,[32 32]);
		images.data(:,:,:,num_cur+i) = im;
		images.labels(num_cur+i) = 3;

		% Select the set (train/val) randomly.
        
		if(randi(10, 1) > 5)
			images.set(num_cur+i) = 1;
			images.data_mean = images.data_mean + im;
			numImgsTrain = numImgsTrain + 1;
		else
			images.set(num_cur+i) = 2;
		end
    end
    
    num_cur = num_cur + NdrawX;
    
    % Loading the 4th category data.
    
    for i=1:numel(drawCircle)
        fprintf('Loading %d out of %d images from DrawCircle folder \r\n',...
        i, length(drawCircle));
		im = single(imread([folder '/DrawCircle/', drawCircle(i).name]));
        im = imresize(im,[32 32]);
		images.data(:,:,:, num_cur+i) = im;
		images.labels(num_cur+i) = 4;

		% Select the set (train/val) randomly.
        
		if(randi(10, 1) > 5)
			images.set(num_cur+i) = 1;
			images.data_mean = images.data_mean + im;
			numImgsTrain = numImgsTrain + 1;
		else
			images.set(num_cur+i) = 2;
		end
    end
    
    num_cur = num_cur + NdrawCircle;
    
     % Loading the 5th category data.
    
    for i=1:numel(drawTick)
        fprintf('Loading %d out of %d images from DrawTick folder \r\n',...
        i, length(drawTick));
		im = single(imread([folder '/DrawTick/', drawTick(i).name]));
        im = imresize(im,[32 32]);
		images.data(:,:,:,num_cur+i) = im;
		images.labels(num_cur+i) = 5;

		% Selecting the set (train/val) randomly.
        
		if(randi(10, 1) > 5)
			images.set(num_cur+i) = 1;
			images.data_mean = images.data_mean + im;
			numImgsTrain = numImgsTrain + 1;
		else
			images.set(num_cur+i) = 2;
		end
    end
    
    num_cur = num_cur + NdrawTick;
    
    % Loading the 6th category data.
    
    for i=1:numel(twoHandWave)
        fprintf('Loading %d out of %d images from TwoHandWave folder \r\n',...
        i, length(twoHandWave));
		im = single(imread([folder '/TwoHandWave/', twoHandWave(i).name]));
        im = imresize(im,[32 32]);
		images.data(:,:,:, num_cur+i) = im;
		images.labels(num_cur+i) = 6;

		% Selecting the set (train/val) randomly.
        
		if(randi(10, 1) > 5)
			images.set(num_cur+i) = 1;
			images.data_mean = images.data_mean + im;
			numImgsTrain = numImgsTrain + 1;
		else
			images.set(num_cur+i) = 2;
		end
    end
    
    num_cur = num_cur + NtwoHandWave;
    
     % Loading the 7th category data.
    
    for i=1:numel(forwardKick)
        fprintf('Loading %d out of %d images from ForwardKick folder \r\n',...
        i, length(forwardKick));
		im = single(imread([folder '/ForwardKick/', forwardKick(i).name]));
        im = imresize(im,[32 32]);
		images.data(:,:,:, num_cur+i) = im;
		images.labels(num_cur+i) = 7;

		% Selecting the set (train/val) randomly.
        
		if(randi(10, 1) > 5)
			images.set(num_cur+i) = 1;
			images.data_mean = images.data_mean + im;
			numImgsTrain = numImgsTrain + 1;
		else
			images.set(num_cur+i) = 2;
		end
    end
    
    num_cur = num_cur + NforwardKick;
    
    % Loading the 8th category data.
    
    for i=1:numel(sideBoxing)
        fprintf('Loading %d out of %d images from SideBoxing folder \r\n',...
        i, length(sideBoxing));
		im = single(imread([folder '/SideBoxing/', sideBoxing(i).name]));
        im = imresize(im,[32 32]);
		images.data(:,:,:, num_cur+i) = im;
		images.labels(num_cur+i) = 8;

		% Selecting the set (train/val) randomly.
        
		if(randi(10, 1) > 5)
			images.set(num_cur+i) = 1;
			images.data_mean = images.data_mean + im;
			numImgsTrain = numImgsTrain + 1;
		else
			images.set(num_cur+i) = 2;
		end
    end
    
    % Computing the mean.
    
	images.data_mean = images.data_mean ./ numImgsTrain;

	% now let's add some randomization.
    
	indices = randperm(N);
	images.data(:,:,:,:) = images.data(:,:,:,indices);
	images.labels(:) = images.labels(indices);
	images.set(:) = images.set(indices);

	imdb.meta = meta;
	imdb.images = images;
	
end

	
	
	
    
  