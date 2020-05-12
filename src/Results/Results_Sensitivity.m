function [  ] = Results_Sensitivity(stimGradient, mode, strength, sensitivityList, motionStrength)
% Show the change of preference curves when sensitivity changed.

    results = zeros(size(sensitivityList, 2), size(stimGradient, 1));
    results2 = zeros(size(sensitivityList, 2), size(stimGradient, 1));
    path = [pwd, '\Results\Sensitivity\'];
    if (~exist(path)) mkdir(path); end 

    % different sensitivity (weight in the comparator):
    for i=1:1:size(sensitivityList, 2)
        sensitivity = sensitivityList(1, i);
        results(i, :) = ...
            Results_Run(mode, strength, stimGradient, motionStrength, 1, 1, sensitivity);
        results2(i, :) = ...
            Results_Run(mode, -strength, stimGradient, motionStrength, 1, 1, sensitivity);
    end

    % plot the changes
    figure(1);
    plot(motionStrength, results(1,:), 'Color', [1 0 0]);
    hold on
    plot(motionStrength, results2(1,:), 'Color', [1 0 0]);
    for i=2:1:size(sensitivityList, 2)
        plot(motionStrength, results(i,:), 'Color', [1.1-i/10 0 i/10-0.1]);
        plot(motionStrength, results2(i,:), 'Color', [1.1-i/10 0 i/10-0.1]);
    end
    hold off
    grid on
    set(gca, 'GridLineStyle', ':');
    set(gca, 'GridAlpha', 1); 
    if mode == 'A'
        xlabel({'�Ӿ��˶�ǿ��'; 'Visual Motion Strength'});
        %title(['Primary motion: audition Strength: ', mat2str(strength)]);
    else
        xlabel({'�����˶�ǿ��'; 'Auditory Motion Strength'});
        %title(['Primary motion: vision Strength: ', mat2str(strength)]);
    end
    ylabel({'���߽��Ϊ���ϵĸ���'; 'Upward Preference'});
    xlim([0.25 0.75]);
    ylim([0 1]);
    saveas(gcf, [path, 'Upward preference ', mode, ' multimodal.jpg']);   

    % Should decline
    AUC = zeros(1, size(sensitivityList, 2));
    for i=1:1:size(sensitivityList, 2)
        for j=2:1:size(motionStrength, 2)
            if motionStrength(1, j) <= 0.5
                AUC(1, i) = AUC(1, i) + ...
                    (results(i, j) + results(i, j-1)) * (motionStrength(1,j) - motionStrength(1, j-1)) /2+...
                    (results2(i, j) + results2(i, j-1)) * (motionStrength(1,j) - motionStrength(1, j-1)) /2;
            else
                AUC(1, i) = AUC(1, i) + ...
                    (2 - results(i, j) - results(i, j-1)) * (motionStrength(1,j) - motionStrength(1, j-1)) /2+...                    
                    (2 - results2(i, j) - results2(i, j-1)) * (motionStrength(1,j) - motionStrength(1, j-1)) /2;
            end
        end
    end
    AUC = AUC / 2;
    figure(2)
    plot(sensitivityList, AUC, 'r');
    hold on
    scatter(sensitivityList, AUC, '+', 'r');
    hold off
    xlabel({'����������'; 'Decision Sensitivity Level'});
    ylabel({'ƽ�������'; 'Mean Error Rate'});
    saveas(gcf, [path, 'Mean error rate ', mode, ' multimodal.jpg']);  
    saveas(gcf, [path, 'Mean error rate ', mode, ' multimodal.fig']);  
    
    % generate unimodal results
    strength = 0;
    for i=1:1:size(sensitivityList, 2)
        sensitivity = sensitivityList(1, i);
        results(i, :) = ...
            Results_Run(mode, strength, stimGradient, motionStrength, 1, 1, sensitivity);
    end

    % plot the changes
    figure(1);
    plot(motionStrength, results(1,:), 'Color', [1 0 0]);
    hold on
    for i=2:1:size(sensitivityList, 2)
        plot(motionStrength, results(i,:), 'Color', [1.1-i/10 0 i/10-0.1]);
    end
    hold off
    grid on
    set(gca, 'GridLineStyle', ':');
    set(gca, 'GridAlpha', 1); 
    if mode == 'A'
        xlabel({'�Ӿ��˶�ǿ��'; 'Visual Motion Strength'});
        %title(['Primary motion: audition Strength: ', mat2str(strength)]);
    else
        xlabel({'�����˶�ǿ��'; 'Auditory Motion Strength'});
        %title(['Primary motion: vision Strength: ', mat2str(strength)]);
    end
    ylabel({'���߽��Ϊ���ϵĸ���'; 'Upward Preference'});
    xlim([0.25 0.75]);
    ylim([0 1]);
    saveas(gcf, [path, 'Upward preference ', mode, ' unimodal.jpg']);   

    % Should decline
    AUC = zeros(1, size(sensitivityList, 2));
    for i=1:1:size(sensitivityList, 2)
        for j=2:1:size(motionStrength, 2)
            if motionStrength(1, j) <= 0.5
                AUC(1, i) = AUC(1, i) + ...
                    (results(i, j) + results(i, j-1)) * (motionStrength(1,j) - motionStrength(1, j-1)) /2;
            else
                AUC(1, i) = AUC(1, i) + ...
                    (2 - results(i, j) - results(i, j-1)) * (motionStrength(1,j) - motionStrength(1, j-1)) /2;
            end
        end
    end
    figure(2)
    plot(sensitivityList, AUC, 'r');
    hold on
    scatter(sensitivityList, AUC, '+', 'r');
    hold off
    xlabel({'����������'; 'Decision Sensitivity Level'});
    ylabel({'ƽ�������'; 'Mean Error Rate'});
    saveas(gcf, [path, 'Mean error rate ', mode, ' unimodal.jpg']);  
    saveas(gcf, [path, 'Mean error rate ', mode, ' unimodal.fig']);  
    
    close all
end

