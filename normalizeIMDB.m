function imdb = normalizeIMDB(imdb)
	data = imdb.images.data;

	% zero mean
	data = bsxfun(@minus, data, imdb.images.data_mean);

	% expand to fill the range [-128, 128]
	range_min = min(data(:));
	range_max = max(data(:));
	range_multiplier = 127./max(abs(range_min),range_max);
	imdb.images.data = data .* range_multiplier;
end
