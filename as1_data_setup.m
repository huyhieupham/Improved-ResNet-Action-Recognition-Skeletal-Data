% Huy Hieu PHAM
% Ph.D. Student at CEREMA and IRIT, Paul Sabatier University.
% Project: Deep learnig for human action recognition.
% Janv. 2017



function imdb = as1_data_setup(folder)
	
	imdb = struct();    
	
	
	horizontalArmWave = dir([folder '/HorizontalArmWave/*.png']);
	hammer = dir([folder '/Hammer/*.png']);
	forwardPunch = dir([folder '/ForwardPunch/*.png']);
	highThrow = dir([folder '/HighThrow/*.png']);
	handClap = dir([folder '/HandClap/*.png']);
	bend = dir([folder '/Bend/*.png']);
	tennisServe = dir([folder '/TennisServe/*.png']);
	pickUpThrow = dir([folder '/PickUpThrow/*.png']);
    
	% imref = imread([folder '/airplane/', airplanes(1).name]);
	% [H, W, CH] = size(imref); % 32 x 32 x 3
     H = 32;
     W = 32;
     CH = 3;
    
	% Number of images:
	
	 NhorizontalArmWave = numel(horizontalArmWave);
	 Nhammer = numel(hammer);
	 NforwardPunch = numel(forwardPunch);
	 NhighThrow = numel(highThrow);
	 NhandClap = numel(handClap);
	 Nbend = numel(bend);
	 NtennisServe = numel(tennisServe);
	 NpickUpThrow = numel(pickUpThrow);
	
    
     
	N = NhorizontalArmWave + Nhammer + NforwardPunch;
	N = N + NhighThrow + NhandClap + Nbend;
	N = N + NtennisServe + NpickUpThrow;
    
    
   
	% we can initialize part of the structures already.
	
	meta.sets = {'train', 'test'};
	meta.classes = {'HorizontalArmWave', 'Hammer', 'ForwardPunch',...
                    'HighThrow', 'HandClap', 'Bend', ...
                    'TennisServe', 'PickUpThrow',...
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
    
    fprintf('Loading %d images from Bend folder \r\n', ...
        Nbend);
    
    
	for i=1:numel(horizontalArmWave)
        fprintf('Loading %d out of %d images from HorizontalArmWave folder \r\n',...
        i, length(horizontalArmWave));
		im = single(imread([folder '/HorizontalArmWave/', horizontalArmWave(i).name]));
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
    
    num_cur = NhorizontalArmWave;
    
	% Loading the 2nd category data.
    
	for i=1:numel(hammer)
        fprintf('Loading %d out of %d images from Hammer folder \r\n',...
        i, length(hammer));
		im = single(imread([folder '/Hammer/', hammer(i).name]));
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
    
    num_cur = num_cur + Nhammer;
    
    % Loading the 3rd category data.
    
	for i=1:numel(forwardPunch)
        fprintf('Loading %d out of %d images from ForwardPunch folder \r\n',...
        i, length(forwardPunch));
		im = single(imread([folder '/ForwardPunch/', forwardPunch(i).name]));
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
    
    num_cur = num_cur + NforwardPunch;
    
    % Loading the 4th category data.
    
    for i=1:numel(highThrow)
        fprintf('Loading %d out of %d images from HighThrow folder \r\n',...
        i, length(highThrow));
		im = single(imread([folder '/HighThrow/', highThrow(i).name]));
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
    
    num_cur = num_cur + NhighThrow;
    
     % Loading the 5th category data.
    
    for i=1:numel(handClap)
        fprintf('Loading %d out of %d images from HandClap folder \r\n',...
        i, length(handClap));
		im = single(imread([folder '/HandClap/', handClap(i).name]));
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
    
    num_cur = num_cur + NhandClap;
    
    % Loading the 6th category data.
    
    for i=1:numel(bend)
        fprintf('Loading %d out of %d images from Bend folder \r\n',...
        i, length(bend));
		im = single(imread([folder '/Bend/', bend(i).name]));
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
    
    num_cur = num_cur + Nbend;
    
     % Loading the 7th category data.
    
    for i=1:numel(tennisServe)
        fprintf('Loading %d out of %d images from TennisServe folder \r\n',...
        i, length(tennisServe));
		im = single(imread([folder '/TennisServe/', tennisServe(i).name]));
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
    
    num_cur = num_cur + NtennisServe;
    
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

%save('imdb_data.mat', '-struct' ,'imdb');
