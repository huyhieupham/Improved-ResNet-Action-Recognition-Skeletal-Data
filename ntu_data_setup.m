function imdb = ntu_data_setup(dataDir)

sets = {'train', 'test'} ;
total_train = 0;
total_test = 0;

for k = 1:60
    dir_train = sprintf('C:/ResNet/cross_subject/train/%i',k);
    dir_test =  sprintf('C:/ResNet/cross_subject/test/%i',k);
    dir_train_png = dir([dir_train, '\*.png']);
    dir_test_png = dir([dir_test, '\*.png']);
    num_file_train = length(dir_train_png(not([dir_train_png.isdir])));
    total_train = total_train + num_file_train;
    num_file_test = length(dir_test_png(not([dir_test_png.isdir])));
    total_test =  total_test + num_file_test; 
end 

% Preallocate memory
totalSamples = total_train + total_test;
images = zeros(32, 32, 3, totalSamples, 'single') ;
labels = zeros(totalSamples, 1) ;
set = ones(totalSamples, 1) ;

% Read all samples
sample = 1 ;
for s = 1:2  % Iterate sets
  for label = 1:60  % Iterate labels
      dir_train_1 = sprintf('C:/ResNet/cross_subject/train/%i',label);
      dir_test_1 =  sprintf('C:/ResNet/cross_subject/test/%i',label);
      dir_train_png_1 = dir([dir_train_1, '\*.png']);
      dir_test_png_1 = dir([dir_test_1, '\*.png']);
      num_file_train_1 = length(dir_train_png_1(not([dir_train_png_1.isdir])));
      num_file_test_1 = length(dir_test_png_1(not([dir_test_png_1.isdir])));
      numSamples = [num_file_train_1,num_file_test_1];
    for i = 1:numSamples(s)  % Iterate samples
      % Read image
      fprintf('Loading %d out of %d images from train/test folder. Please calm down.... \r\n',...
        i, numSamples(s) );
      im = single(imread(sprintf('%s/%s/%i/%04i.png', dataDir, sets{s}, label, i))) ;     
      % Store it, along with label and train/val set information
      images(:,:,:,sample) = im;
      labels(sample) = label ;
      set(sample) = s ;
      sample = sample + 1 ;
    end
  end
end

% Remove mean over whole dataset
images = bsxfun(@minus, images, mean(images, 4)) ;

% Store results in the imdb struct
imdb.images = images ;
imdb.labels = labels ;
imdb.set = set ;

end





