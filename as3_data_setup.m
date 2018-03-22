 function imdb = data_setup_msr_3d_skeleton(folder)
	
	imdb = struct();    
	
	
	highThrow = dir([folder '/HighThrow/*.png']);
	forwardKick = dir([folder '/ForwardKick/*.png']);
	sideKick = dir([folder '/SideKick/*.png']);
	jogging = dir([folder '/Jogging/*.png']);
	tennisSwing = dir([folder '/TennisSwing/*.png']);
	tennisServe = dir([folder '/TennisServe/*.png']);
    golfSwing = dir([folder '/GolfSwing/*.png']);
	pickUpThrow = dir([folder '/PickUpThrow/*.png']); 
    
	H = 32;
    W = 32;
    CH = 3;
	
	
	NhighThrow = numel(highThrow);
	NforwardKick = numel(forwardKick);
	NsideKick = numel(sideKick);
	Njogging = numel(jogging);
	NtennisSwing = numel(tennisSwing);
	NtennisServe = numel(tennisServe);
	NgolfSwing = numel(golfSwing);
	NpickUpThrow = numel(pickUpThrow);
	
	N = NhighThrow + NforwardKick + NsideKick;
	N = N + Njogging + NtennisSwing + NtennisServe;
	N = N + NgolfSwing + NpickUpThrow; 
	
	meta.sets = {'train', 'test'};
	meta.classes = {'HighThrow', 'ForwardKick', 'SideKick',...
                    'Jogging', 'TennisSwing', 'TennisServe', ...
                    'GolfSwing', 'PickUpThrow',...
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
    
      
    
	for i=1:numel(highThrow)
        fprintf('Loading %d out of %d images from HighThrow folder \r\n',...
        i, length(highThrow));
		im = single(imread([folder '/HighThrow/', highThrow(i).name]));
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
    
    num_cur = NhighThrow;
    
	% Loading the 2nd category data.
    
	for i=1:numel(forwardKick)
        fprintf('Loading %d out of %d images from ForwardKick folder \r\n',...
        i, length(forwardKick));
		im = single(imread([folder '/ForwardKick/', forwardKick(i).name]));
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
    
    num_cur = num_cur + NforwardKick;
    
    % Loading the 3rd category data.
    
	for i=1:numel(sideKick)
        fprintf('Loading %d out of %d images from SideKick folder \r\n',...
        i, length(sideKick));
		im = single(imread([folder '/SideKick/', sideKick(i).name]));
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
    
    num_cur = num_cur + NsideKick;
    
    % Loading the 4th category data.
    
    for i=1:numel(jogging)
        fprintf('Loading %d out of %d images from Jogging folder \r\n',...
        i, length(jogging));
		im = single(imread([folder '/Jogging/', jogging(i).name]));
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
    
    num_cur = num_cur + Njogging;
    
     % Loading the 5th category data.
    
    for i=1:numel(tennisSwing)
        fprintf('Loading %d out of %d images from TennisSwing folder \r\n',...
        i, length(tennisSwing));
		im = single(imread([folder '/TennisSwing/', tennisSwing(i).name]));
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
    
    num_cur = num_cur + NtennisSwing;
    
    % Loading the 6th category data.
    
    for i=1:numel(tennisServe)
        fprintf('Loading %d out of %d images from TennisServe folder \r\n',...
        i, length(tennisServe));
		im = single(imread([folder '/TennisServe/', tennisServe(i).name]));
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
    
    num_cur = num_cur + NtennisServe;
    
     % Loading the 7th category data.
    
    for i=1:numel(golfSwing)
        fprintf('Loading %d out of %d images from GolfSwing folder \r\n',...
        i, length(golfSwing));
		im = single(imread([folder '/GolfSwing/', golfSwing(i).name]));
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
    
    num_cur = num_cur + NgolfSwing;
    
    % Loading the 8th category data.
    
    for i=1:numel(pickUpThrow)
        fprintf('Loading %d out of %d images from PickUpThrow folder \r\n',...
        i, length(pickUpThrow));
		im = single(imread([folder '/PickUpThrow/', pickUpThrow(i).name]));
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
