% Huy Hieu PHAM
% Ph.D. Student at CEREMA and IRIT, Paul Sabatier University.
% Project: Deep learnig for human action recognition.
% Data setup for KARD dataset
% March 2017

function imdb = activity_set_3_data_setup(folder)

         imdb = struct();   
         
         drawTick = dir([folder '/DrawTick/*.png']);
         drink = dir([folder '/Drink/*.png']);
         highThrow = dir([folder '/HighThrow/*.png']);
         horizontalArmWave = dir([folder '/HorizontalArmWave/*.png']);
         phoneCall = dir([folder '/PhoneCall/*.png']);
         sitDown = dir([folder '/SitDown/*.png']);
         takeUmbrella = dir([folder '/TakeUmbrella/*.png']);
         tossPaper = dir([folder '/TossPaper/*.png']);
         
	    
	  H = 32;
      W = 32;
      CH = 3;
      
     % Number of images:
	
	 NdrawTick = numel(drawTick);
	 Ndrink = numel(drink);
     NhighThrow = numel(highThrow);
     NhorizontalArmWave = numel(horizontalArmWave);
     NphoneCall = numel(phoneCall);
     NsitDown = numel(sitDown);
     NtakeUmbrella = numel(takeUmbrella);
     NtossPaper = numel(tossPaper);
     
     N = NdrawTick + Ndrink + NhighThrow;
	 N = N + NhorizontalArmWave  + NphoneCall + NsitDown;
	 N = N + NtakeUmbrella + NtossPaper;
     
     % we can initialize part of the structures already.
	
	meta.sets = {'train', 'test'};
	meta.classes = {'DrawTick', 'Drink', 'HighThrow',...
                    'HorizontalArmWave', 'PhoneCall', 'SitDown', ...
                    'TakeUmbrella', 'TossPaper',...
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
    
    for i=1:numel(drawTick)
        fprintf('Loading %d out of %d images from DrawTick folder \r\n',...
        i, length(drawTick));
		im = single(imread([folder '/DrawTick/', drawTick(i).name]));
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
    
    num_cur = NdrawTick;
    
    % Loading the 2nd category data.
    
	for i=1:numel(drink)
        fprintf('Loading %d out of %d images from Drink folder \r\n',...
        i, length(drink));
		im = single(imread([folder '/Drink/', drink(i).name]));
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
    
    num_cur = num_cur + Ndrink;
    
    % Loading the 3rd category data.
    
	for i=1:numel(highThrow)
        fprintf('Loading %d out of %d images from HighThrow folder \r\n',...
        i, length(highThrow));
		im = single(imread([folder '/HighThrow/', highThrow(i).name]));
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
    
    num_cur = num_cur + NhighThrow;
    
    % Loading the 4th category data.
    
    for i=1:numel(horizontalArmWave)
        fprintf('Loading %d out of %d images from HorizontalArmWave folder \r\n',...
        i, length(horizontalArmWave));
		im = single(imread([folder '/HorizontalArmWave/', horizontalArmWave(i).name]));
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
    
    num_cur = num_cur + NhorizontalArmWave;
    
    % Loading the 5th category data.
    
    for i=1:numel(phoneCall)
        fprintf('Loading %d out of %d images from PhoneCall folder \r\n',...
        i, length(phoneCall));
		im = single(imread([folder '/PhoneCall/', phoneCall(i).name]));
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
    
    num_cur = num_cur + NphoneCall;
    
    % Loading the 6th category data.
    
    for i=1:numel(sitDown)
        fprintf('Loading %d out of %d images from SitDown folder \r\n',...
        i, length(sitDown));
		im = single(imread([folder '/SitDown/', sitDown(i).name]));
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
    
    num_cur = num_cur + NsitDown;
    
     % Loading the 7th category data.
    
    for i=1:numel(takeUmbrella)
        fprintf('Loading %d out of %d images from TakeUmbrella folder \r\n',...
        i, length(takeUmbrella));
		im = single(imread([folder '/TakeUmbrella/', takeUmbrella(i).name]));
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
    
    num_cur = num_cur + NtakeUmbrella;
    
    % Loading the 8th category data.
    
    for i=1:numel(tossPaper)
        fprintf('Loading %d out of %d images from TossPaper folder \r\n',...
        i, length(tossPaper));
		im = single(imread([folder '/TossPaper/', tossPaper(i).name]));
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