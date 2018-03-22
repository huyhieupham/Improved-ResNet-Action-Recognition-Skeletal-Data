% Huy Hieu PHAM
% Ph.D. Student at CEREMA and IRIT, Paul Sabatier University.
% Project: Deep learnig for human action recognition.
% Data setup for KARD dataset
% March 2017

function imdb = activity_set_1_data_setup(folder)

         imdb = struct();   
         
         bend = dir([folder '/Bend/*.png']);
         drawX = dir([folder '/DrawX/*.png']);
         forwardKick = dir([folder '/ForwardKick/*.png']);
         horizontalArmWave = dir([folder '/HorizontalArmWave/*.png']);
         phoneCall = dir([folder '/PhoneCall/*.png']);
         standUp = dir([folder '/StandUp/*.png']);
         twoHandWave = dir([folder '/TwoHandWave/*.png']);
         walk = dir([folder '/Walk/*.png']);
         
	    
	  H = 32;
      W = 32;
      CH = 3;
      
     % Number of images:
	
	 Nbend = numel(bend);
	 NdrawX = numel(drawX);
     NforwardKick = numel(forwardKick);
     NhorizontalArmWave = numel(horizontalArmWave);
     NphoneCall = numel(phoneCall);
     NstandUp = numel(standUp);
     NtwoHandWave = numel(twoHandWave);
     Nwalk = numel(walk);
     
     N = Nbend + NdrawX + NforwardKick;
	 N = N + NhorizontalArmWave + NphoneCall + NstandUp;
	 N = N + NtwoHandWave + Nwalk;
     
     % we can initialize part of the structures already.
	
	meta.sets = {'train', 'test'};
	meta.classes = {'Bend', 'DrawX', 'ForwardKick',...
                    'HorizontalArmWave', 'PhoneCall', 'StandUp', ...
                    'TwoHandWave', 'Walk',...
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
    
	for i=1:numel(drawX)
        fprintf('Loading %d out of %d images from DrawX folder \r\n',...
        i, length(drawX));
		im = single(imread([folder '/DrawX/', drawX(i).name]));
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
    
    num_cur = num_cur + NdrawX;
    
    % Loading the 3rd category data.
    
	for i=1:numel(forwardKick)
        fprintf('Loading %d out of %d images from ForwardKick folder \r\n',...
        i, length(forwardKick));
		im = single(imread([folder '/ForwardKick/', forwardKick(i).name]));
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
    
    num_cur = num_cur + NforwardKick;
    
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
    
    for i=1:numel(standUp)
        fprintf('Loading %d out of %d images from StandUp folder \r\n',...
        i, length(standUp));
		im = single(imread([folder '/StandUp/', standUp(i).name]));
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
    
    num_cur = num_cur + NstandUp;
    
     % Loading the 7th category data.
    
    for i=1:numel(twoHandWave)
        fprintf('Loading %d out of %d images from TwoHandWave folder \r\n',...
        i, length(twoHandWave));
		im = single(imread([folder '/twoHandWave/', twoHandWave(i).name]));
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
    
    num_cur = num_cur + NtwoHandWave;
    
    % Loading the 8th category data.
    
    for i=1:numel(walk)
        fprintf('Loading %d out of %d images from Walk folder \r\n',...
        i, length(walk));
		im = single(imread([folder '/Walk/', walk(i).name]));
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
	


