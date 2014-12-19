function lDist = benchmarkKNN(knnClassifier)
    BASE_PATH = '/Volumes/Kenneth/Coursework Fall 2014/CS 4701/captcha/examples';
    
    images = dir(fullfile(BASE_PATH, '*.jpg'));
    
    lDist = [];
    
    for i = 1:numel(images)
        fprintf('Processing image %d of %d\n', i, 28);
        
        currImgPath = fullfile(BASE_PATH, images(i).name);
        [~, answer, ~] = fileparts(currImgPath);
        
        result = recKnnCaptcha(currImgPath, true, knnClassifier);
        
        if (~strcmp(result, ''))
            measure = 1 - levenshtein(result, upper(answer)) / 6;
            lDist = [lDist measure];
            
            fprintf('Result: %s | Answer: %s | Score: %d\n', result, upper(answer), measure);
        end
    end
end