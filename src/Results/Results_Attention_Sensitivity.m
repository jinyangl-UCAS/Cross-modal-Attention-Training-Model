function [  ] = Results_Attention_Sensitivity(stimGradient, mode, strength, attentionList, sensitivityList, motionStrength)
% Show the change of preference curves when attention and sensitivity are changed.

    path = [pwd, '\Results\Combination\'];
    if (~exist(path)) mkdir(path); end 
    
    AUC = zeros(size(sensitivityList, 2), size(attentionList, 2));
    AUC2 = zeros(size(sensitivityList, 2), size(attentionList, 2));
    
    line = 1;
    for sensitivity = sensitivityList
        results = zeros(size(attentionList, 2), size(stimGradient, 1));   
        results2 = zeros(size(attentionList, 2), size(stimGradient, 1));        
        results3 = zeros(size(attentionList, 2), size(stimGradient, 1));        

        % different attention (decay rate):        
        for i=1:1:size(attentionList, 2)
            attention = attentionList(1, i);
            results(i, :) = ...
                Results_Run(mode, strength, stimGradient, motionStrength, attention, 1, sensitivity);
            results2(i, :) = ...
                Results_Run(mode, -strength, stimGradient, motionStrength, attention, 1, sensitivity);
            results3(i, :) = ...
                Results_Run(mode, 0, stimGradient, motionStrength, attention, 1, sensitivity);
        end        

        % Should decline        
        for i=1:1:size(attentionList, 2)
            for j=2:1:size(motionStrength, 2)
                if motionStrength(1, j) <= 0.5
                    AUC(line, i) = AUC(line, i) + ...
                        (results(i, j) + results(i, j-1)) * (motionStrength(1,j) - motionStrength(1, j-1)) /2+...
                        (results2(i, j) + results2(i, j-1)) * (motionStrength(1,j) - motionStrength(1, j-1)) /2;                
                    AUC2(line, i) = AUC2(line, i) + ...
                        (results3(i, j) + results3(i, j-1)) * (motionStrength(1,j) - motionStrength(1, j-1)) /2;
                else
                    AUC(line, i) = AUC(line, i) + ...
                        (2 - results(i, j) - results(i, j-1)) * (motionStrength(1,j) - motionStrength(1, j-1)) /2+...
                        (2 - results2(i, j) - results2(i, j-1)) * (motionStrength(1,j) - motionStrength(1, j-1)) /2;
                    AUC2(line, i) = AUC2(line, i) + ...
                        (2 - results3(i, j) - results3(i, j-1)) * (motionStrength(1,j) - motionStrength(1, j-1)) /2;
                end
            end
        end

        line = line+1;
    end
    
    AUC = AUC / 2;
    figure(2)
    imagesc(AUC);
    colorbar
    xlabel({'跨模态注意力等级'; 'Cross-modal Attention Level'});
    ylabel({'决策灵敏度等级'; 'Decision Sensitivity Level'});
    set(gca,'YDir','normal');
    title('(a)');
%     title('Attention-Sensitivity combination');
    saveas(gcf, [path, 'Attention-Sensitivity Combination ', mode, ' multimodal.jpg']);
    
    figure(3)
    imagesc(AUC2);
    colorbar
    xlabel({'跨模态注意力等级'; 'Cross-modal Attention Level'});
    ylabel({'决策灵敏度等级'; 'Decision Sensitivity Level'});
    set(gca,'YDir','normal');
    title('(b)');
%     title('Attention-Sensitivity combination');
    saveas(gcf, [path, 'Attention-Sensitivity Combination ', mode, ' unimodal.jpg']);
    
    close all    
end

