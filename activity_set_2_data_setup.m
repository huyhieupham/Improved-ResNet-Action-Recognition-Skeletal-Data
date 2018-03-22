% Huy Hieu PHAM
% Ph.D. Student at CEREMA and IRIT, Paul Sabatier University.
% Project: Deep learnig for human action recognition.
% Data setup for KARD dataset
% March 2017

function imdb = activity_set_2_data_setup(folder)

         imdb = struct();   
         
         bend = dir([folder '/Bend/*.png']);
         catchCap = dir([folder '/CatchCap/*.png']);
         drawTick = dir([folder '/DrawTick/*.png']);
         forwardKick = dir([folder '/ForwardKick/*.png']);
         handClap = dir([folder '/HandClap/*.png']);
         highArmWave = dir([folder '/HighArmWave/*.png']);
         sideKick = dir([folder '/SideKick/*.png']);
         sitDown = dir([folder '/SitDown/*.png']);
         
	    
	  H = 32;
      W = 32;
      CH = 3;
      
     % Number of images:
	
	 Nbend = numel(bend);
	 NcatchCap = numel(catchCap);
     NdrawTick = numel(drawTick);
     NforwardKick = numel(forwardKick);
     NhandClap = numel(handClap);
     NhighArmWave = numel(highArmWave);
     NsideKick = numel(sideKick);
     NsitDown = numel(sitDown);
     
     N = Nbend + NcatchCap + NdrawTick;
	 N = N + NforwardKick + NhandClap + NhighArmWave;
	 N = N + NsideKick + NsitDown;
     
     % we can initialize part of the structures already.
	
	meta.sets = {'train', 'test'};
	meta.classes = {'Bend', 'CatchCap', 'DrawTick',...
                    'ForwardKick', 'HandClap', 'HighArmWave', ...
                    'SideKick', 'SitDown',...
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
    
    fprintf('Loading %d images from Bend folder \r\n', ...
           Nbend);
    
    for i=1:numel(bend)
        fprintf('Loading %d out of %d images from Bend folder \r\n',...
        i, length(bend));
		im = single(imread([folder '/Bend/', bend(i).name]));
        im = imresize(im,[32 32]);
		images.data(:,:,:,i) = im;
		images.labels(i) = 1;

		% Selecting the set (train/val) randomly.
        
		if(randi(100, 1) > 33) % Experiment A = 7 ; B = 3 ; C = 5
			images.set(i) = 1;
			images.data_mean = images.data_mean + im;
			numImgsTrain = numImgsTrain + 1;
		else
			images.set(i) = 2;
		end
    end
    
    num_cur = Nbend;
    
    % Loading the 2nd category data.
    
	for i=1:numel(catchCap)
        fprintf('Loading %d out of %d images from CatchCap folder \r\n',...
        i, length(catchCap));
		im = single(imread([folder '/CatchCap/', catchCap(i).name]));
        im = imresize(im,[32 32]);
		images.data(:,:,:,num_cur+i) = im;
		images.labels(num_cur+i) = 2;

		% Selectng the set (train/val) randomly.
        
		if(randi(100, 1) > 33)
			images.set(num_cur+i) = 1;
			images.data_mean = images.data_mean + im;
			numImgsTrain = numImgsTrain + 1;
		else
			images.set(num_cur+i) = 2;
		end
    end
    
    num_cur = num_cur + NcatchCap;
    
    % Loading the 3rd category data.
    
	for i=1:numel(drawTick)
        fprintf('Loading %d out of %d images from DrawTick folder \r\n',...
        i, length(drawTick));
		im = single(imread([folder '/DrawTick/', drawTick(i).name]));
        im = imresize(im,[32 32]);
		images.data(:,:,:,num_cur+i) = im;
		images.labels(num_cur+i) = 3;

		% Select the set (train/val) randomly.
        
		if(randi(100, 1) > 33)
			images.set(num_cur+i) = 1;
			images.data_mean = images.data_mean + im;
			numImgsTrain = numImgsTrain + 1;
		else
			images.set(num_cur+i) = 2;
		end
    end
    
    num_cur = num_cur + NdrawTick;
    
    % Loading the 4th category data.
    
    for i=1:numel(forwardKick)
        fprintf('Loading %d out of %d images from ForwardKick folder \r\n',...
        i, length(forwardKick));
		im = single(imread([folder '/ForwardKick/', forwardKick(i).name]));
        im = imresize(im,[32 32]);
		images.data(:,:,:, num_cur+i) = im;
		images.labels(num_cur+i) = 4;

		% Select the set (train/val) randomly.
        
		if(randi(100, 1) > 33)
			images.set(num_cur+i) = 1;
			images.data_mean = images.data_mean + im;
			numImgsTrain = numImgsTrain + 1;
		else
			images.set(num_cur+i) = 2;
		end
    end
    
    num_cur = num_cur + NforwardKick;
    
    % Loading the 5th category data.
    
    for i=1:numel(handClap)
        fprintf('Loading %d out of %d images from HandClap folder \r\n',...
        i, length(handClap));
		im = single(imread([folder '/HandClap/', handClap(i).name]));
        im = imresize(im,[32 32]);
		images.data(:,:,:,num_cur+i) = im;
		images.labels(num_cur+i) = 5;

		% Selecting the set (train/val) randomly.
        
		if(randi(100, 1) > 33)
			images.set(num_cur+i) = 1;
			images.data_mean = images.data_mean + im;
			numImgsTrain = numImgsTrain + 1;
		else
			images.set(num_cur+i) = 2;
		end
    end
    
    num_cur = num_cur + NhandClap;
    
    % Loading the 6th category data.
    
    for i=1:numel(highArmWave)
        fprintf('Loading %d out of %d images from HighArmWave folder \r\n',...
        i, length(highArmWave));
		im = single(imread([folder '/HighArmWave/', highArmWave(i).name]));
        im = imresize(im,[32 32]);
		images.data(:,:,:, num_cur+i) = im;
		images.labels(num_cur+i) = 6;

		% Selecting the set (train/val) randomly.
        
		if(randi(100, 1) > 33)
			images.set(num_cur+i) = 1;
			images.data_mean = images.data_mean + im;
			numImgsTrain = numImgsTrain + 1;
		else
			images.set(num_cur+i) = 2;
		end
    end
    
    num_cur = num_cur + NhighArmWave;
    
     % Loading the 7th category data.
    
    for i=1:numel(sideKick)
        fprintf('Loading %d out of %d images from SideKick folder \r\n',...
        i, length(sideKick));
		im = single(imread([folder '/SideKick/', sideKick(i).name]));
        im = imresize(im,[32 32]);
		images.data(:,:,:, num_cur+i) = im;
		images.labels(num_cur+i) = 7;

		% Selecting the set (train/val) randomly.
        
		if(randi(100, 1) > 33)
			images.set(num_cur+i) = 1;
			images.data_mean = images.data_mean + im;
			numImgsTrain = numImgsTrain + 1;
		else
			images.set(num_cur+i) = 2;
		end
    end
    
    num_cur = num_cur + NsideKick;
    
    % Loading the 8th category data.
    
    for i=1:numel(sitDown)
        fprintf('Loading %d out of %d images from SitDown folder \r\n',...
        i, length(sitDown));
		im = single(imread([folder '/SitDown/', sitDown(i).name]));
        im = imresize(im,[32 32]);
		images.data(:,:,:, num_cur+i) = im;
		images.labels(num_cur+i) = 8;

		% Selecting the set (train/val) randomly.
        
		if(randi(100, 1) > 33)
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
	


