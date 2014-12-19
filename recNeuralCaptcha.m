function result = recNeuralCaptcha(chars, nn)    
    if (numel(chars) == 6)
        % HOG Parameters
        CELL_SIZE = [2, 5];
        BLOCK_SIZE = [2, 2];
        NUM_BINS = 9;

        blocksPerImage = floor((size(chars{1}) ./ CELL_SIZE - BLOCK_SIZE) ./ (BLOCK_SIZE - ceil(BLOCK_SIZE / 2)) + 1);
        hogSize = prod([blocksPerImage, BLOCK_SIZE, NUM_BINS]);

%         hogData = zeros([hogSize, numel(chars)]);
        hogData = zeros([numel(chars{1}), numel(chars)]);
        
        for i = 1:numel(chars)
            hogData(:, i) = chars{i}(:);
%             hogData(:, i) = extractHOGFeatures(chars{i}, 'CellSize', CELL_SIZE);
        end

        nnResult = vec2ind(nn(hogData));

        idx = cell(1, numel(nnResult));

        for k = 1:numel(nnResult)
            idx{k} = num2str(lookupIdx(nnResult(k)));
        end

        result = strjoin(idx, '');
    else
        result = '';
    end
end